import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../colors.dart';
import '../custom_dialog.dart';
import '../home_screen.dart';
import '../my_text.dart';
import 'package:http/http.dart' as http;

import 'da.dart';

class TravelRequisition extends StatefulWidget {
  const TravelRequisition({Key? key}) : super(key: key);

  @override
  State<TravelRequisition> createState() => _TravelRequisitionState();
}

class _TravelRequisitionState extends State<TravelRequisition> {
  final TextEditingController _Datecontroller = TextEditingController();
  final TextEditingController _fromcontroller = TextEditingController();
  final TextEditingController _tocontroller = TextEditingController();
  final TextEditingController _projectNamecontroller = TextEditingController();
  final TextEditingController _projectDescriptioncontroller =
      TextEditingController();
  final TextEditingController _FundedProjectcontroller =
      TextEditingController();
  final TextEditingController _FundedDescriptioncontroller =
      TextEditingController();
  final TextEditingController _remarkcontroller = TextEditingController();

  String? modeValue;
  String? reasonValue;
  String? fundStatusValue;

  bool _validateDate = false;
  bool _validateFrom = false;
  bool _validateTo = false;
  bool _validateMode = false;
  bool _validateReason = false;
  bool _validateProject = false;
  bool _validateDescription = false;
  bool _validateFundStatus = false;
  bool _validateFundDescription = false;
  bool _validateFundedProject = false;
  bool _validateRemark = false;

  final FocusNode _fromNode = FocusNode();
  final FocusNode _toNode = FocusNode();
  final FocusNode _invoiceNode = FocusNode();
  final FocusNode _invoiceAmountNode = FocusNode();
  final FocusNode _projectNameNode = FocusNode();
  final FocusNode _projectDescriptionNode = FocusNode();
  final FocusNode _fundedProjectNode = FocusNode();
  final FocusNode _fundedDescriptionNode = FocusNode();
  final FocusNode _remarkNode = FocusNode();

  var isLoading = false.obs;

  DateTime selectedDate = DateTime.now(), initialDate = DateTime.now();

  _selectDate(
    BuildContext context,
    TextEditingController date,
  ) async {
    final DateTime? selected = await showDatePicker(
      locale: const Locale('en', 'IN'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, picker) {
        return Theme(data: theme, child: picker!);
      },
    );
    if (selected != null) {
      setState(() {
        selectedDate = selected;
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        date.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    schoolController.getModeTransport();

    schoolController.getReasonTravel();
    schoolController.getPaymentMode();

    schoolController.getPaymentType();

    // print(schoolController.travelReason!.length.toString());

    return Obx(
      () => isLoading.value
          ? const loadingWidget()
          : Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFF8A2724),
                  iconTheme: const IconThemeData(color: Colors.white),
                title: const Text(
                  'Travel Requisition Form',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 10),
                      const Text('Date:',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MyColors.grey_95)),
                      Container(height: 10),
                      Container(
                        height: 45,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: <Widget>[
                            Container(width: 15),
                            Expanded(
                              child: TextField(
                                onTap: () {
                                  _selectDate(
                                    context,
                                    _Datecontroller,
                                  );
                                },
                                readOnly: true,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                maxLines: 1,
                                style: MyText.body2(context)!
                                    .copyWith(color: MyColors.grey_40),
                                keyboardType: TextInputType.datetime,
                                controller: _Datecontroller,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(-12),
                                    border: InputBorder.none,
                                    hintText: "Starting Date(yyyy-mm-dd)",
                                    hintStyle: MyText.body1(context)!
                                        .copyWith(color: MyColors.grey_40)),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _selectDate(
                                      context,
                                      _Datecontroller,
                                    );
                                  });
                                },
                                icon: const Icon(Icons.calendar_today,
                                    color: MyColors.grey_40))
                          ],
                        ),
                      ),
                      _validateDate
                          ? const Text('Please select a date',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red))
                          : const SizedBox(),
                      Container(height: 15),
                      buildList(
                          context,
                          'From:',
                          _fromNode,
                          _fromcontroller,
                          'Source Name',
                          _validateFrom,
                          'Please enter a valid source name'),
                      Container(height: 15),

                      buildList(
                          context,
                          'To:',
                          _toNode,
                          _tocontroller,
                          'Destination Name',
                          _validateTo,
                          'Please enter a valid destination name'),

                      Container(height: 15),

                      const Text('Mode of Transport:',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MyColors.grey_95)),
                      Container(height: 10),
                      //dropdown
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.white,
                                spreadRadius: 1,
                                blurRadius: 5)
                          ],
                        ),
                        child: Stack(children: [
                          DropdownButton<String>(
                            value: modeValue,
                            iconSize: 24,
                            elevation: 2,
                            hint: const Text(
                              'Mode of Transport',
                              style: TextStyle(color: Colors.grey),
                            ),
                            items: schoolController.modeTransport!.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text(value.toString()),
                              );
                            }).toList(),
                            onChanged: (data) {
                              setState(() {
                                modeValue = data;
                              });
                            },
                          ),
                        ]),
                      ),
                      _validateMode
                          ? const Text('Please select a Mode of Transport',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red))
                          : const SizedBox(),

                      Container(height: 15),
                      const Text('Reason for Travel:',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MyColors.grey_95)),
                      Container(height: 10),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.white,
                                spreadRadius: 1,
                                blurRadius: 5)
                          ],
                        ),
                        child: Stack(children: [
                          DropdownButton<String>(
                            value: reasonValue,
                            iconSize: 24,
                            elevation: 2,
                            hint: const Text(
                              'Select Reason',
                              style: TextStyle(color: Colors.grey),
                            ),
                            // ignore: can_be_null_after_null_aware
                            items: schoolController.travelReason!.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text(value.toString()),
                              );
                            }).toList(),
                            onChanged: (data) {
                              setState(() {
                                reasonValue = data;
                              });
                            },
                          ),
                        ]),
                      ),
                      _validateReason
                          ? const Text('Please select a reason',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red))
                          : const SizedBox(),
                      Container(height: 15),

                      reasonValue == 'Project'
                          ? buildList(
                              context,
                              'Name of project:',
                              _projectNameNode,
                              _projectNamecontroller,
                              'Project Name',
                              _validateProject,
                              'Please fill the project name')
                          : reasonValue == null
                              ? const SizedBox()
                              : buildList(
                                  context,
                                  'Description:',
                                  _projectDescriptionNode,
                                  _projectDescriptioncontroller,
                                  'Description',
                                  _validateDescription,
                                  'Please fill the description'),
                      Container(height: 15),

                      const Text('Is it Funded ?',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MyColors.grey_95)),
                      Container(height: 10),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.white,
                                spreadRadius: 1,
                                blurRadius: 5)
                          ],
                        ),
                        child: Stack(children: [
                          DropdownButton<String>(
                            value: fundStatusValue,
                            iconSize: 24,
                            elevation: 2,
                            hint: const Text(
                              'Select Status',
                              style: TextStyle(color: Colors.grey),
                            ),
                            // ignore: can_be_null_after_null_aware
                            items: ['Yes', 'No', "Don't Know"].map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (data) {
                              setState(() {
                                fundStatusValue = data;
                              });
                            },
                          ),
                        ]),
                      ),
                      _validateFundStatus
                          ? const Text('Please select a status',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red))
                          : const SizedBox(),

                      Container(height: 15),

                      fundStatusValue == 'Yes'
                          ? buildList(
                              context,
                              'Name of Funder:',
                              _fundedProjectNode,
                              _FundedProjectcontroller,
                              'Funder Name',
                              _validateFundedProject,
                              'Please fill the funder')
                          : fundStatusValue == null
                              ? const SizedBox()
                              : fundStatusValue == 'No'
                                  ? buildList(
                                      context,
                                      'Description:',
                                      _fundedDescriptionNode,
                                      _FundedDescriptioncontroller,
                                      'Description',
                                      _validateFundDescription,
                                      'Please fill the description')
                                  : const SizedBox(),
                      fundStatusValue != "Dont Know"
                          ? Container(height: 15)
                          : const SizedBox(),
                      buildList(
                          context,
                          'Remark:',
                          _remarkNode,
                          _remarkcontroller,
                          'Remark',
                          _validateRemark,
                          'Please fill the remark'),
                      Container(height: 15),

                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8A2724),
                                elevation: 0),
                            child: Text("Submit",
                                style: MyText.subhead(context)!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () async {
                              setState(() {
                                print('object');

                                _Datecontroller.text.isNotEmpty
                                    ? _validateDate = false
                                    : _validateDate = true;

                                _fromcontroller.text.isNotEmpty
                                    ? _validateFrom = false
                                    : _validateFrom = true;

                                _tocontroller.text.isNotEmpty
                                    ? _validateTo = false
                                    : _validateTo = true;
                                _remarkcontroller.text.isNotEmpty
                                    ? _validateRemark = false
                                    : _validateRemark = true;

                                modeValue != null
                                    ? _validateMode = false
                                    : _validateMode = true;

                                reasonValue != null
                                    ? _validateReason = false
                                    : _validateReason = true;

                                fundStatusValue != null
                                    ? _validateFundStatus = false
                                    : _validateFundStatus = true;

                                if (reasonValue == 'Project') {
                                  _projectNamecontroller.text.isNotEmpty
                                      ? _validateProject = false
                                      : _validateProject = true;
                                } else if (reasonValue == 'Fund Raising' ||
                                    reasonValue == 'Other') {
                                  _projectDescriptioncontroller.text.isNotEmpty
                                      ? _validateDescription = false
                                      : _validateDescription = true;
                                }
                                if (fundStatusValue == 'Yes') {
                                  _FundedProjectcontroller.text.isNotEmpty
                                      ? _validateFundedProject = false
                                      : _validateFundedProject = true;
                                  // validateHere(
                                  //     _projectNamecontroller, _validateProject);
                                } else if (fundStatusValue == 'No') {
                                  _FundedDescriptioncontroller.text.isNotEmpty
                                      ? _validateFundDescription = false
                                      : _validateFundDescription = true;
                                  // validateHere(_FundedDescriptioncontroller,
                                  //     _validateFundDescription);
                                } else {}
                              });

                              if (!_validateDate &&
                                  !_validateFrom &&
                                  !_validateTo &&
                                  !_validateRemark &&
                                  !_validateMode &&
                                  !_validateReason &&
                                  !_validateFundStatus &&
                                  !_validateProject &&
                                  !_validateDescription &&
                                  !_validateFundedProject &&
                                  !_validateFundDescription) {
                                isLoading.value = true;
                                var rsp = await insertData(
                                    GetStorage().read('userId'),
                                    _Datecontroller.text,
                                    _fromcontroller.text,
                                    _tocontroller.text,
                                    modeValue.toString(),
                                    reasonValue.toString(),
                                    _projectNamecontroller.text,
                                    _projectDescriptioncontroller.text,
                                    fundStatusValue.toString(),
                                    _FundedProjectcontroller.text,
                                    _FundedDescriptioncontroller.text,
                                    _remarkcontroller.text);
                                if (rsp['status'].toString() == '1') {
                                  isLoading.value = false;
                                  _Datecontroller.clear();
                                  _fromcontroller.clear();
                                  _tocontroller.clear();
                                  _remarkcontroller.clear();
                                  _projectNamecontroller.clear();
                                  _projectDescriptioncontroller.clear();
                                  _FundedProjectcontroller.clear();
                                  _FundedDescriptioncontroller.clear();
                                  modeValue = null;
                                  reasonValue = null;
                                  fundStatusValue = null;

                                  showDialog(
                                      context: context,
                                      builder: (_) => const CustomEventDialog(
                                          title: 'Home'));
                                } else {
                                  setState(() {
                                    isLoading.value = false;
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (_) => const CustomEventDialog(
                                          title: 'Something went wrong'));
                                }
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class loadingWidget extends StatelessWidget {
  const loadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
              color: Colors.white,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/17000ft.jpg',
                    height: 60,
                    width: 60,
                  ),
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(MyColors.primary),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Please wait...',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ))
                ],
              ))),
        )
      ],
    );
  }
}

buildDate(
  BuildContext context,
) {}

buildList(
    BuildContext context,
    String title,
    FocusNode node,
    TextEditingController controller,
    String hint,
    bool validate,
    String validateText) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: MyColors.grey_95)),
      Container(height: 10),
      Container(
        height: 45,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: TextField(
          onSubmitted: (value) {
            //     FocusScope.of(context).requestFocus(_toNode);
          },
          focusNode: node,
          textInputAction: TextInputAction.next,
          maxLines: 1,
          controller: controller,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(-12),
              border: InputBorder.none,
              hintText: hint,
              hintStyle:
                  MyText.body1(context)!.copyWith(color: MyColors.grey_40)),
        ),
      ),
      validate
          ? Text(validateText,
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red))
          : const SizedBox(),
    ],
  );
}

// GetStorage().read('userId')

Future insertData(
  String userid,
  String date,
  String from,
  String to,
  String modeofTransport,
  String reason,
  String nameOfProject,
  String description,
  String fundStatus,
  String fundedProject,
  String fundedDescription,
  String remark,
) async {
  var response = await http
      .post(Uri.parse('${MyColors.baseUrl}insert_travelRequisition.php'), headers: {
    "Accept": "Application/json"
  }, body: {
    'submitted_by': userid,
    'travel_date': date,
    'travel_from': from,
    'travel_to': to,
    'mode': modeofTransport,
    'reason': reason,
    'project_name': nameOfProject,
    'description': description,
    'fund_status': fundStatus,
    'funded_project': fundedProject,
    'funded_description': fundedDescription,
    'remark': remark,
  });
  print('this is response by travel ${response.body}');
  var convertedDatatoJson = jsonDecode(response.body);
  return convertedDatatoJson;
}

