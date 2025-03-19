import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old17000ft/component/confirmaton.dart';
import 'package:pdfx/pdfx.dart';

import '../../colors.dart';
import '../../component/customDropdown.dart';
import '../../component/custom_date_picker.dart';
import '../../component/error_text.dart';
import '../../component/responsive.dart';
import '../../component/sixzedBox.dart';
import '../../component/snacjbar.dart';

import '../../home_screen.dart';
import 'comoff.dart';
import 'leave_modal.dart';
import 'leave_request_controller.dart';
import 'leave_sync.dart';

class LeaveForm extends StatefulWidget {
  final String? userId; // Declare userId as a final field
  final String? office; // Declare userId as a final field
  LeaveForm({
    super.key,
    required this.userId, // Use `this.userId` to assign the passed parameter to the class field
    required this.office, // Use `this.userId` to assign the passed parameter to the class field
  });

  @override
  _LeaveFormState createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LeaveControllerForm leaveControllerForm =
      Get.put(LeaveControllerForm());
  final leaveController = Get.put(LeaveController());

  @override
  void initState() {
    super.initState();
    print(
        'This is the init user id: ${widget.userId}' // Correctly accessing the userId
        'This is the init office: ${widget.office}'); // Correctly accessing the userId
    if (widget.userId != null) {
      leaveControllerForm.fetchLeaveData(widget.userId!);
    }

    // Fetch dates when needed
    leaveController.fetchAvailableDates(widget.userId!);
  }

  Future<void> _selectDate(BuildContext context, int index) async {
    DateTime lastAllowedDate;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2051),
      locale: const Locale('en'), // Force English locale

    );

    if (picked != null) {
      setState(() {
        switch (index) {
          case 1:
            leaveControllerForm.lieuDateController.text =
                "${picked.toLocal()}".split(' ')[0];
            leaveControllerForm.lieuFieldError = false; // lib
            break;

          default:
            break;
        }
      });
    }
  }
  void _validateLeaveDates() {
    final startDate = leaveControllerForm.startDate;
    final endDate = leaveControllerForm.endDate;
    final double? numberOfDays = double.tryParse(leaveControllerForm.numberOfLeaveController.text);

    // Check if end date is before start date
    if (startDate != null && endDate != null && endDate.isBefore(startDate)) {
      _showErrorAndClearEndDate('End date cannot be before start date');
      return;
    }

    // Check for half-day leave validation
    if (leaveControllerForm.numberOfLeaveController.text == '0.5' &&
        startDate != null &&
        endDate != null &&
        startDate != endDate) {
      _showErrorAndClearEndDate('Half-day leave must be on the same day');
      return;
    }

    // Validate leave type
    if (leaveControllerForm.selectedLeaveType == 'CL' && numberOfDays != null) {
      if (numberOfDays > leaveControllerForm.cl.value) {
        _showErrorAndClearEndDate('Insufficient CL Leave');
        return;
      } else if (numberOfDays > 3) {
        _showErrorAndClearEndDate('Maximum 3 CL days allowed');
        return;
      }
    }

    if (leaveControllerForm.selectedLeaveType == 'SL' && numberOfDays != null) {
      if (numberOfDays > leaveControllerForm.sl.value) {
        _showErrorAndClearEndDate('Insufficient SL Leave');
        return;
      } else if (numberOfDays > 7) {
        _showErrorAndClearEndDate('Maximum 7 SL days allowed');
        return;
      }
    }

    if (leaveControllerForm.selectedLeaveType == 'EL' && numberOfDays != null) {
      if (numberOfDays > leaveControllerForm.el.value) {
        _showErrorAndClearEndDate('Insufficient EL Leave');
        return;
      } else if (numberOfDays > 3 &&
          leaveControllerForm.startDate!.difference(DateTime.now()).inDays < 15) {
        _showErrorAndClearEndDate(
            'Leave exceeding 3 days must be requested 15 days in advance');
        return;
      } else if (numberOfDays > 15) {
        _showErrorAndClearEndDate('Maximum 15 EL days allowed');
        return;
      }
    }

    if (leaveControllerForm.selectedLeaveType == 'CO' && numberOfDays != null) {
      if (numberOfDays > 1) {
        _showErrorAndClearEndDate('Only 1 CO day is allowed');
        return;
      }
    }
  }

  void _showErrorAndClearEndDate(String errorMessage) {
    leaveControllerForm.endDate = null; // Clear the end date field
    leaveControllerForm.numberOfLeaveController.text = ''; // Optionally clear the total number of days
    setState(() {}); // Update UI to reflect cleared date

    // Show the error dialog
    showConfirmationDialog(errorMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8A2724),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Leave Request Form',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Equal padding for all sides
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSizedBox(side: 'height', value: 20),
                  Row(
                    children: [
                      // First Column for 'CL'
                      Expanded(
                        flex: 1, // Ensure equal distribution across all columns
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align text to the left
                          children: [
                            Text('CL',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.grey_95)),
                            SizedBox(height: 8),
                            Obx(() => Text(
                                  leaveControllerForm.cl.value.toString(),
                                  style: TextStyle(fontSize: 16),
                                )),
                          ],
                        ),
                      ),

                      // Spacer with a flexible width based on screen size

                      // Second Column for 'SL'
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('SL',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.grey_95)),
                            SizedBox(height: 8),
                            Obx(() => Text(
                                  leaveControllerForm.sl.value.toString(),
                                  style: TextStyle(fontSize: 16),
                                )),
                          ],
                        ),
                      ),

                      // Spacer with a flexible width based on screen size

                      // Third Column for 'EL'
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('EL',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.grey_95)),
                            SizedBox(height: 8),
                            Obx(() => Text(
                                  leaveControllerForm.el.value.toString(),
                                  style: TextStyle(fontSize: 16),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  CustomSizedBox(side: 'height', value: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Half Day?',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: MyColors.grey_95,
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomDropdown(
                        labelText: '-Select Type-',
                        selectedValue: leaveControllerForm.selectedHalfDay,
                        items: const [
                          DropdownMenuItem(
                            value: 'select',
                            child: Text('Select'),
                          ),
                          DropdownMenuItem(
                            value: 'yes',
                            child: Text('Yes'),
                          ),
                          DropdownMenuItem(
                            value: 'no',
                            child: Text('No'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              leaveControllerForm.selectedHalfDay = value;

                              // Update number of leaves based on the half-day selection
                              if (value == 'yes') {
                                leaveControllerForm
                                    .numberOfLeaveController.text = '0.5';
                              } else {
                                leaveControllerForm.updateTotalDays();
                              }
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value == 'select') {
                            return 'Please select this field';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  CustomSizedBox(side: 'height', value: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Leave Type',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: MyColors.grey_95)),
                        SizedBox(height: 10),
                        CustomDropdown(
                          labelText: '-Select Type-',
                          selectedValue: leaveControllerForm.selectedLeaveType,
                          items: [
                            DropdownMenuItem(
                              value: 'Select Type',
                              child: Text('Select Type'),
                            ),
                            DropdownMenuItem(
                              value: 'SL',
                              child: Text('SL - Sick Leave'),
                            ),
                            DropdownMenuItem(
                              value: 'CL',
                              child: Text('CL - Casual Leave'),
                            ),
                            if (leaveControllerForm.selectedHalfDay != 'yes')
                              DropdownMenuItem(
                                value: 'EL',
                                child: Text('EL - Earned Leave'),
                              ),
                            DropdownMenuItem(
                              value: 'CO',
                              child: Text('CO - Compensatory Leave'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              leaveControllerForm.selectedLeaveType = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value == 'Select Type') {
                              return 'Please select a leave type';
                            }
                            return null;
                          },
                        )

                      ]),
                  CustomSizedBox(side: 'height', value: 20),
                  if (leaveControllerForm.selectedLeaveType == 'CO') ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('In Lieu of Date',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: MyColors.grey_95)),
                        SizedBox(height: 10),
                        Obx(() {
                          // Check if there are available dates
                          if (leaveController.availableDates.isNotEmpty) {
                            return CustomDropdown(
                              labelText: 'Select Lieu Date',
                              selectedValue: leaveControllerForm
                                  .selectedLieuDate, // Current selected value
                              items: leaveController.availableDates
                                  .map((String date) {
                                return DropdownMenuItem<String>(
                                  value: date,
                                  child: Text(date),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                // Update the selected value in both controllers
                                leaveControllerForm.selectedLieuDate =
                                    newValue; // Ensure this is observable
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a date';
                                }
                                return null;
                              },
                            );
                          } else {
                            // Show a date picker button if no dates are available
                            return TextField(
                              controller:
                                  leaveControllerForm.lieuDateController,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Select Date',
                                errorText:
                                    (leaveControllerForm.lieuFieldError ??
                                            false)
                                        ? 'Date is required'
                                        : null,
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () {
                                    _selectDate(context,
                                        1); // Pass index 1 for dateController1
                                  },
                                ),
                              ),
                              onTap: () {
                                _selectDate(context,
                                    1); // Pass index 5 for dateController5
                              },
                            );
                          }
                        }),
                      ],
                    ),
                  ],
                  CustomSizedBox(
                    value: 20,
                    side: 'height',
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Start Date',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.grey_95)),
                            CustomSizedBox(
                              value: 10,
                              side: 'height',
                            ),
                            CustomDatePicker(
                              selectedDate: leaveControllerForm.startDate,
                              label: 'Start Date',
                              onDateChanged: (newDate) {
                                setState(() {
                                  leaveControllerForm.startDate = DateTime(
                                      newDate.year, newDate.month, newDate.day);

                                  leaveControllerForm.updateTotalDays();
                                  leaveControllerForm.validateStartDate();

                                  // Ensure the end date is restricted for half-day leave
                                  if (leaveControllerForm
                                          .numberOfLeaveController.text ==
                                      '0.5') {
                                    leaveControllerForm.endDate =
                                        leaveControllerForm.startDate;
                                  }
                                });
                              },
                              isStartDate: true,
                              errorText:
                                  leaveControllerForm.startDateFieldError,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width *
                              0.05), // Adjust the gap dynamically
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('End Date',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.grey_95)),
                            CustomSizedBox(
                              value: 10,
                              side: 'height',
                            ),
                        CustomDatePicker(
                          selectedDate: leaveControllerForm.endDate,
                          label: 'End Date',
                          firstDate: leaveControllerForm.startDate ?? DateTime(2000),
                          lastDate: leaveControllerForm.numberOfLeaveController.text == '0.5'
                              ? leaveControllerForm.startDate // Restrict to the same day if half-day leave
                              : DateTime(2100),
                          onDateChanged: (newDate) {
                            setState(() {
                              leaveControllerForm.endDate = DateTime(
                                newDate.year,
                                newDate.month,
                                newDate.day,
                              );

                              leaveControllerForm.updateTotalDays(); // Update total leave days
                              _validateLeaveDates(); // Call validation function
                            });
                          },
                          isStartDate: false,
                          errorText: leaveControllerForm.endDateFieldError, // Optional for inline error
                        ),

                        ],
                        ),
                      ),
                    ],
                  ),
                  CustomSizedBox(
                    value: 20,
                    side: 'height',

                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Number of Leaves Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Number Of Leaves',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.grey_95)),
                            CustomSizedBox(
                              value: 10,
                              side: 'height',
                            ),
                            TextFormField(
                                controller:
                                    leaveControllerForm.numberOfLeaveController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Total Number of Days',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please fill this field';
                                  }

                                  // Parse the value as a number
                                  final numberOfDays = double.tryParse(value);

                                  // If parsing fails, it's not a valid number
                                  if (numberOfDays == null) {
                                    return 'Please enter a valid number';
                                  }

                                  // Validate the "Half Day" selection
                                  if (leaveControllerForm.selectedHalfDay ==
                                          'yes' &&
                                      numberOfDays != 0.5) {
                                    return 'Invalid value for Half Day';
                                  }

                                  // General validation for leave type
                                  final DateTime currentDate = DateTime.now();
                                  final int daysDifference =
                                      leaveControllerForm.startDate != null
                                          ? leaveControllerForm.startDate!
                                              .difference(currentDate)
                                              .inDays
                                          : 0;

                                  final int availableCL =
                                      leaveControllerForm.cl.value;
                                  final int availableSL =
                                      leaveControllerForm.sl.value;
                                  final double availableEL =
                                      leaveControllerForm.el.value;

                                  // Check based on leave type
                                  if (leaveControllerForm.selectedLeaveType ==
                                      'CL') {
                                    if (numberOfDays > availableCL) {
                                      showConfirmationDialog(
                                          'Insufficient CL Leave $availableCL');
                                      return 'Insufficient CL Leave $availableCL';
                                    } else if (numberOfDays > 3) {
                                      showConfirmationDialog(
                                          'Max Leave size 3');
                                      return 'Max Leave size 3';
                                    }
                                  }

                                  if (leaveControllerForm.selectedLeaveType ==
                                      'SL') {
                                    if (numberOfDays > availableSL) {
                                      showConfirmationDialog(
                                          'Insufficient SL Leave $availableSL');
                                      return 'Insufficient SL Leave $availableSL';
                                    } else if (numberOfDays > 7) {
                                      showConfirmationDialog(
                                          'Max Leave size 7');
                                      return 'Max Leave size 7';
                                    }
                                  }

                                  if (leaveControllerForm.selectedLeaveType ==
                                      'EL') {
                                    if (numberOfDays > availableEL) {
                                      showConfirmationDialog(
                                          'Insufficient EL Leave $availableEL');
                                      return 'Insufficient EL Leave $availableEL';
                                    } else if (numberOfDays > 3 &&
                                        daysDifference < 15) {
                                      showConfirmationDialog(
                                          'Request more than 3 EL only can apply before 15 days');
                                      return 'Not Valid';
                                    } else if (numberOfDays > 15) {
                                      showConfirmationDialog(
                                          'Max Leave size 15');
                                      return 'Max Leave size 15';
                                    }
                                  }

                                  if (leaveControllerForm.selectedLeaveType ==
                                      'CO') {
                                    if (numberOfDays > 1) {
                                      showConfirmationDialog(
                                          'Max Leave size 1');
                                      return 'Max Leave size 1';
                                    }
                                  }

                                  return null; // If all validations pass
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                  CustomSizedBox(
                    value: 20,
                    side: 'height',
                  ),
                  if (leaveControllerForm.selectedLeaveType == 'SL' &&
                      (int.tryParse(leaveControllerForm
                                  .numberOfLeaveController.text) ??
                              0) >
                          3) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Upload Medical',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: MyColors.grey_95)),
                        CustomSizedBox(
                          value: 10,
                          side: 'height',
                        ),
                        // Upload Field Container
                        // Upload Field Container

                        Container(
                          height: 57,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              width: 2,
                              color: leaveControllerForm
                                          .isImageUploadedNumberOfLeaves ==
                                      false
                                  ? Colors.grey
                                  : Colors.red,
                            ),
                          ),
                          child: ListTile(
                            title: const Text('Click or Upload Image/PDF'),
                            trailing: const Icon(Icons.camera_alt,
                                color: MyColors.grey_95),
                            onTap: () {
                              // Show the bottom sheet for image or PDF upload
                              showModalBottomSheet(
                                backgroundColor: MyColors.primary,
                                context: context,
                                builder: (builder) =>
                                    leaveControllerForm.bottomSheet(context),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 8.0),

                        if (leaveControllerForm.imagePaths.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              // Show responsive popup with uploaded files in a row
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: MyColors.primary,
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Uploaded Files',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        IconButton(
                                          icon: const Icon(Icons.close,
                                              color: Colors.white),
                                          onPressed: () => Navigator.of(context)
                                              .pop(), // Close the popup
                                        ),
                                      ],
                                    ),
                                    content: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                          leaveControllerForm.imagePaths.length,
                                          (index) {
                                            final filePath = leaveControllerForm
                                                .imagePaths[index];
                                            final isImage =
                                                filePath.endsWith('.jpg') ||
                                                    filePath.endsWith('.png');

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (isImage) {
                                                    // Show larger image in dialog
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialog(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          child: Stack(
                                                            children: [
                                                              Center(
                                                                child:
                                                                    Image.file(
                                                                  File(
                                                                      filePath),
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                              Positioned(
                                                                top: 10,
                                                                right: 10,
                                                                child:
                                                                    IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .close,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 30),
                                                                  onPressed: () =>
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    // Show PDF using pdfx package
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialog(
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: Column(
                                                            children: [
                                                              Expanded(
                                                                child: PdfView(
                                                                  controller:
                                                                      PdfController(
                                                                    document: PdfDocument
                                                                        .openFile(
                                                                            filePath),
                                                                  ),
                                                                ),
                                                              ),
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(),
                                                                child:
                                                                    const Text(
                                                                        "Close"),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }
                                                },
                                                child: Stack(
                                                  alignment: Alignment.topRight,
                                                  children: [
                                                    isImage
                                                        ? Image.file(
                                                            File(filePath),
                                                            width: 100,
                                                            height: 100,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Container(
                                                            width: 100,
                                                            height: 100,
                                                            color: Colors.grey,
                                                            child: const Icon(
                                                                Icons
                                                                    .picture_as_pdf,
                                                                size: 40,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                    Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      child: IconButton(
                                                        icon: const Icon(
                                                            Icons.delete,
                                                            color: Colors.red),
                                                        onPressed: () {
                                                          // Delete file and update UI
                                                          setState(() {
                                                            leaveControllerForm
                                                                .imagePaths
                                                                .removeAt(
                                                                    index);
                                                          });
                                                          Navigator.pop(
                                                              context); // Close the popup
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              'Files Uploaded: ${leaveControllerForm.imagePaths.length}',
                              style:
                                  const TextStyle(color: MyColors.accentDark),
                            ),
                          ),

                        ErrorText(
                          isVisible: leaveControllerForm.validateUploadPhoto,
                          message: 'Medical Image or PDF Required',
                        ),

// Spacer
                        CustomSizedBox(
                          value: 20,
                          side: 'height',
                        ),
                      ],
                    ),
                  ],
                  CustomSizedBox(
                    value: 20,
                    side: 'height',
                  ),
                  Text('Message',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: MyColors.grey_95)),
                  CustomSizedBox(
                    value: 20,
                    side: 'height',
                  ),
                  TextFormField(
                    controller: leaveControllerForm.messageController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'Write your comments..',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      // Optional: adds a border
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Comments cannot be empty.';
                      }
                      return null;
                    },
                  ),
                  CustomSizedBox(
                    value: 20,
                    side: 'height',
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primary, // Custom button color
                    ),
                    onPressed: () async {
                      setState(() {
                        leaveControllerForm.validateStartDate();
                        leaveControllerForm.validateEndDate();

                        // Only require upload photo if leave type is 'SL' and number of leaves is more than 3
                        if (leaveControllerForm.selectedLeaveType == 'SL' &&
                            (int.tryParse(leaveControllerForm
                                        .numberOfLeaveController.text) ??
                                    0) >
                                3) {
                          leaveControllerForm.validateUploadPhoto =
                              leaveControllerForm.multipleImage.isEmpty;
                        } else {
                          leaveControllerForm.validateUploadPhoto = false;
                        }
                      });

                      // Check form validation and upload photo validation
                      if (_formKey.currentState!.validate() &&
                          !leaveControllerForm.validateUploadPhoto) {
                        print("Form is valid! Proceeding with submission...");
                        print('UserId init: ${widget.userId}');

                        // Show the loader
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: MyColors.primary,
                              ),
                            );
                          },
                        );

                        await Future.delayed(
                            Duration(seconds: 2)); // Simulate submission delay

                        List<File> registerImageFiles = leaveControllerForm
                            .imagePaths
                            .map((imagePath) => File(imagePath))
                            .toList();
                        String registerImageFilePaths = registerImageFiles
                            .map((file) => file.path)
                            .join(',');

                        LeaveRequestModal leaveRequestModal = LeaveRequestModal(
                          office: widget.office.toString(),
                          empId: widget.userId.toString(),
                          type: leaveControllerForm.selectedLeaveType ?? 'N/A',
                          numberOfLeaves: leaveControllerForm
                                  .numberOfLeaveController.text.isNotEmpty
                              ? leaveControllerForm.numberOfLeaveController.text
                              : 'N/A',
                          startDate: leaveControllerForm.startDate != null
                              ? "${leaveControllerForm.startDate!.year.toString().padLeft(4, '0')}-${leaveControllerForm.startDate!.month.toString().padLeft(2, '0')}-${leaveControllerForm.startDate!.day.toString().padLeft(2, '0')}"
                              : null,
                          endDate: leaveControllerForm.endDate != null
                              ? "${leaveControllerForm.endDate!.year.toString().padLeft(4, '0')}-${leaveControllerForm.endDate!.month.toString().padLeft(2, '0')}-${leaveControllerForm.endDate!.day.toString().padLeft(2, '0')}"
                              : null,
                          reason: leaveControllerForm.messageController.text,
                          compoff: leaveControllerForm.selectedLieuDate ??
                              leaveControllerForm.lieuDateController.text,
                          document: registerImageFilePaths ?? '',
                          leaveRequest: 'true',
                        );
                        print(
                            "Leave Request Modal: ${leaveRequestModal.toJson()}");

                        await submitLeaveRequest(leaveRequestModal);

                        // Dismiss the loader
                        Navigator.pop(context);

                        // Show success message after successful submission
                        customSnackbar(
                            'Data Submitted Successfully',
                            'Submitted',
                            MyColors.primary,
                            Colors.white,
                            Icons.verified);

                        // Clear fields and navigate to HomeScreen
                        leaveControllerForm.clearFields();
                        Get.offAll(() =>
                            const HomeScreen()); // Replace with your home widget
                      } else {
                        // If validation fails, show error message
                        customSnackbar(
                            'Please Select all fields in the list',
                            'Failed to submit',
                            MyColors.primary,
                            Colors.white,
                            Icons.error);
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Method to show the confirmation dialog
void showConfirmationDialog(String description) {
  Get.dialog(
    Confirmation2(
      title: 'Not Valid!',
      desc: description,
      onPressed: () {
        // Handle what happens on 'Yes'
        print('Confirmed!');
        // You can also add any additional logic you need here
      },
      yes: 'OK',
      iconname: Icons.warning, // You can choose any icon you like
    ),
  );
}
