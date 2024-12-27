// // import 'dart:convert';

// // import 'package:flutter/material.dart';
// // import 'package:form/Controllers/pendingExpenses_Controller.dart';
// // import 'package:form/Controllers/school_Controller.dart';
// // import 'package:form/Model/distribution.dart';
// // import 'package:form/Model/programme.dart';
// // import 'package:form/Model/school_data.dart';
// // import 'package:form/Model/staff_data.dart';
// // import 'package:form/Model/state_model.dart' as c;
// // import 'package:form/home_screen.dart';

// // import 'package:get/get.dart';
// // import 'package:intl/intl.dart';

// // import '../colors.dart';
// // import '../data.dart';
// // import '../my_text.dart';
// // import 'package:http/http.dart' as http;

// // final StateController _stateController = Get.put(StateController());
// // final DistrictController _districtController = Get.put(DistrictController());

// // final BlockController _blockController = Get.put(BlockController());
// // final SchoolController _schoolController = Get.put(SchoolController());
// // final StaffController staffController = Get.put(StaffController());

// // class TourBudget extends StatefulWidget {
// //   const TourBudget({Key? key}) : super(key: key);

// //   @override
// //   _TourBudgetState createState() => _TourBudgetState();
// // }

// // class _TourBudgetState extends State<TourBudget> {
// //   TextEditingController _officeController = TextEditingController();
// //   TextEditingController _fromController = TextEditingController();
// //   TextEditingController _toController = TextEditingController();
// //   TextEditingController _daController = TextEditingController();
// //   TextEditingController _noOfDayController = TextEditingController();

// //   bool _validateLeader = false;

// //   bool _validatestate = false;

// //   bool _validateblock = false;
// //   bool _validateDistrict = false;
// //   bool _validateProgram = false;
// //   bool _validateFrom = false;
// //   bool _validateTo = false;
// //   bool _validateStaff = false;
// //   bool _validateSchool = false;
// //   bool _validateTransport = false;
// //   bool _validateStaffT = false;
// //   bool _validateGoodsT = false;

// //   bool _validateDA = false;
// //   var _loading = false.obs;
// //   String? _districtName;
// //   String? _state;
// //   String? _blockName;
// //   String? _programName;
// //   String? _fromDate;
// //   String? _toDate;

// //   String? dropdownValue;
// //   String? dropdownValue1;
// //   String? dropdownValue2;
// //   String? dropdownValue3;
// //   String? dropdownValue4;
// //   String? dropdownValue5;
// //   String? dropdownValue6;
// //   String? dropdownValue7;
// //   String? teamleader;

// //   int? from;
// //   int? to;

// //   getNumber(int a) {
// //     return a;
// //   }

// //   List<String> _selectedTransport = [];

// //   @override
// //   void initState() {
// //     super.initState();

// //     _selectedTransport = [];
// //   }

// //   void displayPopup1(BuildContext context, String title) {
// //     String? modeOfTransport;
// //     String? dropDownValue2;
// //     String? dropDownValue3;
// //     String? dropDownValue4;

// //     showModalBottomSheet<void>(
// //       context: context,
// //       backgroundColor: Colors.white,
// //       shape: const RoundedRectangleBorder(
// //         borderRadius: BorderRadius.only(
// //             topLeft: Radius.circular(24), topRight: Radius.circular(24)),
// //       ),
// //       builder: (BuildContext context) {
// //         return GetBuilder<SchoolController>(
// //             init: schoolController,
// //             builder: (schoolController) {
// //               return LayoutBuilder(
// //                 builder: (BuildContext context, BoxConstraints constraints) {
// //                   return SingleChildScrollView(
// //                     child: ConstrainedBox(
// //                       constraints: BoxConstraints(
// //                         minHeight: constraints.minHeight,
// //                       ),
// //                       child: Column(
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: [
// //                           SizedBox(
// //                             width: MediaQuery.of(context).size.width,
// //                             child: Padding(
// //                               padding: const EdgeInsets.all(12.0),
// //                               child: Column(
// //                                 crossAxisAlignment: CrossAxisAlignment.start,
// //                                 children: [
// //                                   Center(
// //                                     child: Text(
// //                                       title,
// //                                       textAlign: TextAlign.center,
// //                                       style: const TextStyle(
// //                                         color: Color(0xff353535),
// //                                         fontSize: 18,
// //                                         fontFamily: "Poppins",
// //                                         fontWeight: FontWeight.w600,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                   const SizedBox(
// //                                     height: 20,
// //                                   ),
// //                                   const Text('Mode of Transport:',
// //                                       style: TextStyle(
// //                                           fontSize: 16,
// //                                           fontWeight: FontWeight.bold,
// //                                           color: MyColors.grey_95)),
// //                                   Container(height: 10),
// //                                   Container(
// //                                     decoration: BoxDecoration(
// //                                       borderRadius: BorderRadius.circular(5),
// //                                       boxShadow: const [
// //                                         BoxShadow(
// //                                             color: Colors.white,
// //                                             spreadRadius: 1,
// //                                             blurRadius: 5)
// //                                       ],
// //                                     ),
// //                                     child: Stack(children: [
// //                                       DropdownButton<String>(
// //                                         value: title == 'Goods Transport'
// //                                             ? schoolController.selectedGoodsMode
// //                                             : schoolController
// //                                                 .selectedStaffMode,
// //                                         iconSize: 14,
// //                                         hint: Text(
// //                                           'Select Mode of Transport'.tr,
// //                                           style: const TextStyle(
// //                                               color: Colors.grey),
// //                                         ),
// //                                         items: title == 'Goods Transport'
// //                                             ? DataModel()
// //                                                 .modeOfGoodsTransport
// //                                                 .map((value) {
// //                                                 return DropdownMenuItem<String>(
// //                                                     value: value,
// //                                                     child: Row(
// //                                                       mainAxisSize:
// //                                                           MainAxisSize.min,
// //                                                       children: [
// //                                                         Text(
// //                                                           value,
// //                                                           style:
// //                                                               const TextStyle(
// //                                                                   fontSize: 12),
// //                                                         )
// //                                                       ],
// //                                                     ));
// //                                               }).toList()
// //                                             : DataModel()
// //                                                 .modeOfStaffTransport
// //                                                 .map((value) {
// //                                                 return DropdownMenuItem<String>(
// //                                                     value: value,
// //                                                     child: Row(
// //                                                       mainAxisSize:
// //                                                           MainAxisSize.min,
// //                                                       children: [
// //                                                         Text(
// //                                                           value,
// //                                                           style:
// //                                                               const TextStyle(
// //                                                                   fontSize: 12),
// //                                                         )
// //                                                       ],
// //                                                     ));
// //                                               }).toList(),
// //                                         onChanged: (data) {
// //                                           if (title == 'Goods Transport') {
// //                                             schoolController.setDropVal(
// //                                                 title, data!);
// //                                           } else if (title ==
// //                                               'Staff Transport') {
// //                                             schoolController.setDropVal(
// //                                                 title, data!);
// //                                           }
// //                                         },
// //                                       ),
// //                                     ]),
// //                                   ),
// //                                   schoolController.validateMode!
// //                                       ? const Text(
// //                                           'Please select a transport mode',
// //                                           style: TextStyle(
// //                                               fontSize: 12,
// //                                               fontWeight: FontWeight.bold,
// //                                               color: Colors.red))
// //                                       : const SizedBox(),
// //                                   title == 'Goods Transport'
// //                                       ? Container(height: 10)
// //                                       : const SizedBox(),
// //                                   title == 'Goods Transport'
// //                                       ? Row(
// //                                           children: [
// //                                             const Text('Types of Goods:',
// //                                                 style: TextStyle(
// //                                                     fontSize: 16,
// //                                                     fontWeight: FontWeight.bold,
// //                                                     color: MyColors.grey_95)),
// //                                             IconButton(
// //                                                 onPressed: () {
// //                                                   schoolController
// //                                                       .selectTypesofGoods(
// //                                                           context);
// //                                                 },
// //                                                 icon: const Icon(
// //                                                   Icons.add,
// //                                                   color: Color(0xFF8A2724),
// //                                                 ))
// //                                           ],
// //                                         )
// //                                       : const SizedBox(),
// //                                   ListBody(
// //                                     children: schoolController.selectedGoods
// //                                         .map((items2) => Row(
// //                                               children: [
// //                                                 Text(
// //                                                   items2,
// //                                                   style: const TextStyle(
// //                                                     color: Color(0xFF8A2724),
// //                                                   ),
// //                                                 ),
// //                                               ],
// //                                             ))
// //                                         .toList(),
// //                                   ),
// //                                   title == 'Goods Transport' &&
// //                                           schoolController.validateType!
// //                                       ? const Text('Please select a Goods type',
// //                                           style: TextStyle(
// //                                               fontSize: 12,
// //                                               fontWeight: FontWeight.bold,
// //                                               color: Colors.red))
// //                                       : const SizedBox(),
// //                                   Container(height: 10),
// //                                   schoolController.selectedStaffMode ==
// //                                               ('Rented Car') ||
// //                                           schoolController.selectedGoodsMode ==
// //                                               ('Rented Car')
// //                                       ? const Text('Vehicle No.:',
// //                                           style: TextStyle(
// //                                               fontSize: 15,
// //                                               fontWeight: FontWeight.bold,
// //                                               color: MyColors.grey_95))
// //                                       : const SizedBox(),
// //                                   Container(height: 10),
// //                                   schoolController.selectedStaffMode ==
// //                                               ('Rented Car') ||
// //                                           schoolController.selectedGoodsMode ==
// //                                               ('Rented Car')
// //                                       ? Container(
// //                                           height: 45,
// //                                           decoration: const BoxDecoration(
// //                                               color: Colors.white,
// //                                               borderRadius: BorderRadius.all(
// //                                                   Radius.circular(4))),
// //                                           alignment: Alignment.centerLeft,
// //                                           padding: const EdgeInsets.symmetric(
// //                                               horizontal: 25),
// //                                           child: TextField(
// //                                             textInputAction:
// //                                                 TextInputAction.next,
// //                                             onSubmitted: (value) {},
// //                                             maxLines: 1,
// //                                             controller:
// //                                                 schoolController.vehicle,
// //                                             decoration: InputDecoration(
// //                                                 contentPadding:
// //                                                     const EdgeInsets.all(-12),
// //                                                 border: InputBorder.none,
// //                                                 hintText: "Number of Vehicle"
// //                                                     .tr,
// //                                                 hintStyle:
// //                                                     MyText.body1(context)!
// //                                                         .copyWith(
// //                                                             color: MyColors
// //                                                                 .grey_40)),
// //                                           ),
// //                                         )
// //                                       : const SizedBox(),
// //                                   schoolController.selectedStaffMode ==
// //                                               ('Rented Car') ||
// //                                           schoolController.selectedGoodsMode ==
// //                                               ('Rented Car')
// //                                       ? schoolController.validateVehicleNo!
// //                                           ? const Text(
// //                                               'Please enter a Vehicle No.',
// //                                               style: TextStyle(
// //                                                   fontSize: 12,
// //                                                   fontWeight: FontWeight.bold,
// //                                                   color: Colors.red))
// //                                           : const SizedBox()
// //                                       : const SizedBox(),
// //                                   Container(height: 10),
// //                                   schoolController.selectedStaffMode ==
// //                                               ('Office Car') ||
// //                                           schoolController.selectedGoodsMode ==
// //                                               ('Office Car')
// //                                       ? Row(
// //                                           children: [
// //                                             const Text('Select Vehicles:',
// //                                                 style: TextStyle(
// //                                                     fontSize: 16,
// //                                                     fontWeight: FontWeight.bold,
// //                                                     color: MyColors.grey_95)),
// //                                             IconButton(
// //                                                 onPressed: () {
// //                                                   schoolController
// //                                                       .selectOfficeCars(
// //                                                           context);
// //                                                 },
// //                                                 icon: const Icon(
// //                                                   Icons.add,
// //                                                   color: Color(0xFF8A2724),
// //                                                 ))
// //                                           ],
// //                                         )
// //                                       : const SizedBox(),
// //                                   schoolController.selectedStaffMode ==
// //                                               ('Office Car') ||
// //                                           schoolController.selectedGoodsMode ==
// //                                               ('Office Car')
// //                                       ? ListBody(
// //                                           children: schoolController
// //                                               .selectedSCar
// //                                               .map((items2) => Row(
// //                                                     children: [
// //                                                       Text(
// //                                                         items2,
// //                                                         style: const TextStyle(
// //                                                           color:
// //                                                               Color(0xFF8A2724),
// //                                                         ),
// //                                                       ),
// //                                                     ],
// //                                                   ))
// //                                               .toList(),
// //                                         )
// //                                       : const SizedBox(),
// //                                   schoolController.selectedStaffMode ==
// //                                               ('Office Car') ||
// //                                           schoolController.selectedGoodsMode ==
// //                                               ('Office Car')
// //                                       ? schoolController.validateOfficeCar!
// //                                           ? const Text(
// //                                               'Please select a Vehicle',
// //                                               style: TextStyle(
// //                                                   fontSize: 12,
// //                                                   fontWeight: FontWeight.bold,
// //                                                   color: Colors.red))
// //                                           : const SizedBox()
// //                                       : const SizedBox(),
// //                                   Container(height: 10),
// //                                   const Text('Distance(KM):',
// //                                       style: TextStyle(
// //                                           fontSize: 15,
// //                                           fontWeight: FontWeight.bold,
// //                                           color: MyColors.grey_95)),
// //                                   Container(height: 10),
// //                                   Container(
// //                                     height: 45,
// //                                     decoration: const BoxDecoration(
// //                                         color: Colors.white,
// //                                         borderRadius: BorderRadius.all(
// //                                             Radius.circular(4))),
// //                                     alignment: Alignment.centerLeft,
// //                                     padding: const EdgeInsets.symmetric(
// //                                         horizontal: 25),
// //                                     child: TextField(
// //                                       textInputAction: TextInputAction.next,
// //                                       onSubmitted: (value) {},
// //                                       maxLines: 1,
// //                                       controller: schoolController.distance,
// //                                       decoration: InputDecoration(
// //                                           contentPadding:
// //                                               const EdgeInsets.all(-12),
// //                                           border: InputBorder.none,
// //                                           hintText: "Enter Distance in KM".tr,
// //                                           hintStyle: MyText.body1(context)!
// //                                               .copyWith(
// //                                                   color: MyColors.grey_40)),
// //                                     ),
// //                                   ),
// //                                   schoolController.validateDistance!
// //                                       ? const Text('Please enter distance',
// //                                           style: TextStyle(
// //                                               fontSize: 12,
// //                                               fontWeight: FontWeight.bold,
// //                                               color: Colors.red))
// //                                       : const SizedBox(),
// //                                   Container(height: 20),
// //                                   const Text('Amount:',
// //                                       style: TextStyle(
// //                                           fontSize: 15,
// //                                           fontWeight: FontWeight.bold,
// //                                           color: MyColors.grey_95)),
// //                                   Container(height: 10),
// //                                   Container(
// //                                     height: 45,
// //                                     decoration: const BoxDecoration(
// //                                         color: Colors.white,
// //                                         borderRadius: BorderRadius.all(
// //                                             Radius.circular(4))),
// //                                     alignment: Alignment.centerLeft,
// //                                     padding: const EdgeInsets.symmetric(
// //                                         horizontal: 25),
// //                                     child: TextField(
// //                                       textInputAction: TextInputAction.next,
// //                                       onSubmitted: (value) {},
// //                                       maxLines: 1,
// //                                       controller: schoolController.amount,
// //                                       decoration: InputDecoration(
// //                                           contentPadding:
// //                                               const EdgeInsets.all(-12),
// //                                           border: InputBorder.none,
// //                                           hintText: "Enter Amount",
// //                                           hintStyle: MyText.body1(context)!
// //                                               .copyWith(
// //                                                   color: MyColors.grey_40)),
// //                                     ),
// //                                   ),
// //                                   schoolController.validateAmount!
// //                                       ? const Text('Please fill an amount',
// //                                           style: TextStyle(
// //                                               fontSize: 12,
// //                                               fontWeight: FontWeight.bold,
// //                                               color: Colors.red))
// //                                       : const SizedBox(),
// //                                   Container(height: 10),
// //                                   SizedBox(
// //                                     width: double.infinity,
// //                                     height: 45,
// //                                     child: ElevatedButton(
// //                                       style: ElevatedButton.styleFrom(
// //                                           primary: const Color(0xFF8A2724),
// //                                           elevation: 0),
// //                                       child: Text("Add Transport",
// //                                           style: MyText.subhead(context)!
// //                                               .copyWith(color: Colors.white)),
// //                                       onPressed: () async {
// //                                         AddTransport data = AddTransport(
// //                                           modeofTransport:
// //                                               title == 'Staff Transport'
// //                                                   ? schoolController
// //                                                       .selectedStaffMode
// //                                                   : schoolController
// //                                                       .selectedGoodsMode,
// //                                           typeOfGoods:
// //                                               schoolController.selectedGoods,
// //                                           vehicleNo:
// //                                               schoolController.vehicle.text,
// //                                           selectedVehicle:
// //                                               schoolController.selectedSCar,
// //                                           distance:
// //                                               schoolController.distance.text,
// //                                           amount: schoolController.amount.text,
// //                                         );

// //                                         if (title == 'Staff Transport') {
// //                                           schoolController.validateAll();

// //                                           if (!schoolController.validateMode! &&
// //                                               !schoolController
// //                                                   .validateOfficeCar! &&
// //                                               !schoolController
// //                                                   .validateDistance! &&
// //                                               !schoolController
// //                                                   .validateAmount!) {
// //                                             schoolController.addStaffData(data);
// //                                             schoolController.vehicle.clear();
// //                                             schoolController.distance.clear();
// //                                             schoolController.amount.clear();
// //                                             schoolController.clearTransport();

// //                                             Navigator.of(context).pop();
// //                                           }
// //                                         }
// //                                         if (title == 'Goods Transport') {
// //                                           schoolController.validateAll();

// //                                           if (!schoolController.validateMode! &&
// //                                               !schoolController.validateType! &&
// //                                               !schoolController
// //                                                   .validateOfficeCar! &&
// //                                               !schoolController
// //                                                   .validateDistance! &&
// //                                               !schoolController
// //                                                   .validateAmount!) {
// //                                             schoolController.addGoodsData(data);
// //                                             schoolController.vehicle.clear();
// //                                             schoolController.distance.clear();
// //                                             schoolController.amount.clear();
// //                                             schoolController.clearTransport();
// //                                             //   distribution.clear();

// //                                             Navigator.of(context).pop();
// //                                           }
// //                                         }
// //                                         //  print(schoolController.schoolData);
// //                                       },
// //                                     ),
// //                                   ),
// //                                   const SizedBox(height: 20),
// //                                 ],
// //                               ),
// //                             ),
// //                           )
// //                         ],
// //                       ),
// //                     ),
// //                   );
// //                 },
// //               );
// //             });
// //         // );
// //       },
// //     );
// //   }

// //   void _selectStaff() async {
// //     List<String>? results = await showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return MultiSelect(
// //             title: 'Select Staff', items2: staffController.staffList.data);
// //       },
// //     );

// //     // Update UI
// //     if (results != null) {
// //       setState(() {
// //         schoolController.selectedStaff.addAll(results);

// //         _daController.text = ((int.parse(DateFormat('dd')
// //                         .format(DateFormat('dd').parse(_toController.text))) -
// //                     int.parse(DateFormat('dd')
// //                         .format(DateFormat('dd').parse(_fromController.text))) +
// //                     1) *
// //                 500 *
// //                 schoolController.selectedStaff.length)
// //             .toString();
// //       });
// //     }
// //   }

// //   //bool _validateState = false;

// //   DateTime selectedDate = DateTime.now(), initialDate = DateTime.now();

// //   _selectDate(
// //     BuildContext context,
// //     TextEditingController date,
// //     String title,
// //   ) async {
// //     final DateTime? selected = await showDatePicker(
// //       locale: const Locale('en', 'IN'),
// //       context: context,
// //       initialDate: title == 'to' ? schoolController.from! : DateTime.now(),
// //       firstDate: title == 'to' ? schoolController.from! : DateTime.now(),
// //       lastDate: DateTime(2040),
// //       builder: (context, picker) {
// //         return Theme(
// //             data: Theme.of(context)
// //                 .copyWith(colorScheme: const ColorScheme.light()),
// //             child: picker!);
// //       },
// //     );
// //     if (selected != null) {
// //       setState(() {
// //         selectedDate = selected;
// //         schoolController.setDate(selected, title);
// //         String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
// //         date.text = formattedDate;
// //         if (title == 'from') {
// //           _toController.clear();
// //         }
// //       });
// //     }
// //   }

// //   var isLoading = false.obs;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         appBar: AppBar(
// //           backgroundColor: const Color(0xFF8A2724),
// //           title: const Text(
// //             'Tour Budget Form',
// //             style: TextStyle(
// //               color: Colors.white,
// //               fontSize: 20,
// //             ),
// //           ),
// //         ),
// //         body: Obx(
// //           () => staffController.isLoading.value || isLoading.value
// //               ? const Center(child: CircularProgressIndicator())
// //               : SingleChildScrollView(
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(12.0),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         const Text('Tour Leader:',
// //                             style: TextStyle(
// //                                 fontSize: 16,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: MyColors.grey_95)),
// //                         Container(height: 10),
// //                         Container(
// //                           decoration: BoxDecoration(
// //                             borderRadius: BorderRadius.circular(5),
// //                             boxShadow: const [
// //                               BoxShadow(
// //                                   color: Colors.white,
// //                                   spreadRadius: 1,
// //                                   blurRadius: 5)
// //                             ],
// //                           ),
// //                           child: Stack(children: [
// //                             DropdownButton<String>(
// //                               value: teamleader,
// //                               iconSize: 14,
// //                               hint: Text(
// //                                 'Select tour leader'.tr,
// //                                 style: const TextStyle(color: Colors.grey),
// //                               ),
// //                               items:
// //                                   staffController.staffList.data!.map((value) {
// //                                 return DropdownMenuItem<String>(
// //                                     value: value.firstName.toString() +
// //                                         ' ' +
// //                                         value.lastName.toString(),
// //                                     child: Row(
// //                                       mainAxisSize: MainAxisSize.min,
// //                                       children: [
// //                                         Text(
// //                                           value.firstName.toString() +
// //                                               ' ' +
// //                                               value.lastName.toString(),
// //                                           style: const TextStyle(fontSize: 12),
// //                                         )
// //                                       ],
// //                                     ));
// //                               }).toList(),
// //                               onChanged: (data) {
// //                                 setState(() {
// //                                   teamleader = data;
// //                                   print(teamleader);
// //                                 });
// //                               },
// //                             ),
// //                           ]),
// //                         ),
// //                         _validateLeader
// //                             ? const Text('Please select a tour leader',
// //                                 style: TextStyle(
// //                                     fontSize: 12,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: Colors.red))
// //                             : const SizedBox(),
// //                         const Text('State:',
// //                             style: TextStyle(
// //                                 fontSize: 16,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: MyColors.grey_95)),
// //                         Container(height: 10),
// //                         Container(
// //                           width: MediaQuery.of(context).size.width * 0.9,
// //                           decoration: BoxDecoration(
// //                             borderRadius: BorderRadius.circular(5),
// //                             boxShadow: const [
// //                               BoxShadow(
// //                                   color: Colors.white,
// //                                   spreadRadius: 1,
// //                                   blurRadius: 5)
// //                             ],
// //                           ),
// //                           child: Stack(children: [
// //                             DropdownButton<String>(
// //                               value: dropdownValue,
// //                               iconSize: 24,
// //                               elevation: 2,
// //                               hint: Text(
// //                                 'Select State'.tr,
// //                                 style: const TextStyle(color: Colors.grey),
// //                               ),
// //                               // ignore: can_be_null_after_null_aware
// //                               items: DataModel().state.map((value) {
// //                                 return DropdownMenuItem<String>(
// //                                   value: value.toString(),
// //                                   child: Text(value.toString()),
// //                                 );
// //                               }).toList(),
// //                               onChanged: (data) {
// //                                 setState(() {
// //                                   dropdownValue = data;
// //                                   dropdownValue1 = null;
// //                                 });
// //                               },
// //                             ),
// //                           ]),
// //                         ),
// //                         _validatestate
// //                             ? const Text('Please select a state',
// //                                 style: TextStyle(
// //                                     fontSize: 12,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: Colors.red))
// //                             : const SizedBox(),
// //                         const Text('District:',
// //                             style: TextStyle(
// //                                 fontSize: 16,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: MyColors.grey_95)),
// //                         Container(height: 10),
// //                         GetBuilder<DistrictController>(
// //                             init: DistrictController(),
// //                             builder: (districtController) {
// //                               List<c.District>? district;
// //                               district =
// //                                   districtController.districtList.value.data;

// //                               return Container(
// //                                 width: MediaQuery.of(context).size.width * 0.9,
// //                                 decoration: BoxDecoration(
// //                                   borderRadius: BorderRadius.circular(5),
// //                                   boxShadow: const [
// //                                     BoxShadow(
// //                                         color: Colors.white,
// //                                         spreadRadius: 1,
// //                                         blurRadius: 5)
// //                                   ],
// //                                 ),
// //                                 child: Stack(children: [
// //                                   DropdownButton<String>(
// //                                     value: dropdownValue1,
// //                                     iconSize: 24,
// //                                     elevation: 2,
// //                                     hint: Text(
// //                                       'Select District'.tr,
// //                                       style:
// //                                           const TextStyle(color: Colors.grey),
// //                                     ),
// //                                     // ignore: can_be_null_after_null_aware
// //                                     items: DataModel()
// //                                         .districtWithState
// //                                         .where((element) =>
// //                                             element.state == dropdownValue)
// //                                         .map((value) {
// //                                       return DropdownMenuItem<String>(
// //                                         value: value.district.toString(),
// //                                         child: Text(value.district.toString()),
// //                                       );
// //                                     }).toList(),
// //                                     onChanged: (data) {
// //                                       setState(() {
// //                                         dropdownValue1 = data;
// //                                         dropdownValue2 = null;
// //                                       });
// //                                     },
// //                                   ),
// //                                 ]),
// //                               );
// //                             }),
// //                         _validateDistrict
// //                             ? const Text('Please select a district',
// //                                 style: TextStyle(
// //                                     fontSize: 12,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: Colors.red))
// //                             : const SizedBox(),
// //                         const Text('Block Name:',
// //                             style: TextStyle(
// //                                 fontSize: 16,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: MyColors.grey_95)),
// //                         Container(height: 10),
// //                         GetBuilder<BlockController>(
// //                             init: BlockController(),
// //                             builder: (blockController) {
// //                               return Container(
// //                                 width: MediaQuery.of(context).size.width * 0.9,
// //                                 decoration: BoxDecoration(
// //                                   borderRadius: BorderRadius.circular(5),
// //                                   boxShadow: const [
// //                                     BoxShadow(
// //                                         color: Colors.white,
// //                                         spreadRadius: 1,
// //                                         blurRadius: 5)
// //                                   ],
// //                                 ),
// //                                 child: Stack(children: [
// //                                   DropdownButton<String>(
// //                                     value: dropdownValue2,
// //                                     iconSize: 24,
// //                                     elevation: 2,
// //                                     hint: Text(
// //                                       'Select Block'.tr,
// //                                       style:
// //                                           const TextStyle(color: Colors.grey),
// //                                     ),
// //                                     // ignore: can_be_null_after_null_aware
// //                                     items: DataModel()
// //                                         .blockWithDistrict
// //                                         .where((element) =>
// //                                             element.district == dropdownValue1)
// //                                         .map((value) {
// //                                       return DropdownMenuItem<String>(
// //                                         value: value.block.toString(),
// //                                         child: Text(value.block.toString()),
// //                                       );
// //                                     }).toList(),
// //                                     onChanged: (data) {
// //                                       setState(() {
// //                                         dropdownValue2 = data;
// //                                         dropdownValue4 = null;
// //                                       });
// //                                     },
// //                                   ),
// //                                 ]),
// //                               );
// //                             }),
// //                         _validateblock
// //                             ? const Text('Please select a block',
// //                                 style: TextStyle(
// //                                     fontSize: 12,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: Colors.red))
// //                             : const SizedBox(),
// //                         Container(height: 10),
// //                         const Text('From:',
// //                             style: TextStyle(
// //                                 fontSize: 16,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: MyColors.grey_95)),
// //                         Container(height: 10),
// //                         Container(
// //                           height: 45,
// //                           decoration: const BoxDecoration(
// //                               color: Colors.white,
// //                               borderRadius:
// //                                   BorderRadius.all(Radius.circular(4))),
// //                           alignment: Alignment.centerLeft,
// //                           padding: const EdgeInsets.symmetric(horizontal: 10),
// //                           child: Row(
// //                             children: <Widget>[
// //                               Container(width: 15),
// //                               Expanded(
// //                                 child: TextField(
// //                                   onTap: () {
// //                                     _selectDate(
// //                                         context, _fromController, 'from');
// //                                   },
// //                                   readOnly: true,
// //                                   onChanged: (value) {
// //                                     setState(() {});
// //                                   },
// //                                   maxLines: 1,
// //                                   style: MyText.body2(context)!
// //                                       .copyWith(color: MyColors.grey_40),
// //                                   keyboardType: TextInputType.datetime,
// //                                   controller: _fromController,
// //                                   decoration: InputDecoration(
// //                                       contentPadding: const EdgeInsets.all(-12),
// //                                       border: InputBorder.none,
// //                                       hintText: "Starting Date(dd-mm-yyyy)",
// //                                       hintStyle: MyText.body1(context)!
// //                                           .copyWith(color: MyColors.grey_40)),
// //                                 ),
// //                               ),
// //                               IconButton(
// //                                   onPressed: () {
// //                                     setState(() {
// //                                       _selectDate(
// //                                           context, _fromController, 'from');
// //                                     });
// //                                   },
// //                                   icon: const Icon(Icons.calendar_today,
// //                                       color: MyColors.grey_40))
// //                             ],
// //                           ),
// //                         ),
// //                         _validateFrom
// //                             ? const Text('Please select a date',
// //                                 style: TextStyle(
// //                                     fontSize: 12,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: Colors.red))
// //                             : const SizedBox(),
// //                         const Text('To:',
// //                             style: TextStyle(
// //                                 fontSize: 16,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: MyColors.grey_95)),
// //                         Container(height: 10),
// //                         Container(
// //                           height: 45,
// //                           decoration: const BoxDecoration(
// //                               color: Colors.white,
// //                               borderRadius:
// //                                   BorderRadius.all(Radius.circular(4))),
// //                           alignment: Alignment.centerLeft,
// //                           padding: const EdgeInsets.symmetric(horizontal: 10),
// //                           child: Row(
// //                             children: <Widget>[
// //                               Container(width: 15),
// //                               Expanded(
// //                                 child: TextField(
// //                                   onTap: () {
// //                                     _selectDate(context, _toController, 'to');
// //                                   },
// //                                   readOnly: true,
// //                                   onChanged: (value) {},
// //                                   maxLines: 1,
// //                                   style: MyText.body2(context)!
// //                                       .copyWith(color: MyColors.grey_40),
// //                                   keyboardType: TextInputType.datetime,
// //                                   controller: _toController,
// //                                   decoration: InputDecoration(
// //                                       contentPadding: const EdgeInsets.all(-12),
// //                                       border: InputBorder.none,
// //                                       hintText: "Ending Date(dd-mm-yyyy)",
// //                                       hintStyle: MyText.body1(context)!
// //                                           .copyWith(color: MyColors.grey_40)),
// //                                 ),
// //                               ),
// //                               IconButton(
// //                                   onPressed: () {
// //                                     setState(() {
// //                                       _selectDate(context, _toController, 'to');
// //                                     });
// //                                   },
// //                                   icon: const Icon(Icons.calendar_today,
// //                                       color: MyColors.grey_40))
// //                             ],
// //                           ),
// //                         ),
// //                         _validateTo
// //                             ? const Text('Please select a date',
// //                                 style: TextStyle(
// //                                     fontSize: 12,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: Colors.red))
// //                             : const SizedBox(),
// //                         Container(height: 10),
// //                         Row(
// //                           children: [
// //                             const Text('Staff to Visit:',
// //                                 style: TextStyle(
// //                                     fontSize: 16,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: MyColors.grey_95)),
// //                             IconButton(
// //                                 onPressed: () {
// //                                   _selectStaff();
// //                                 },
// //                                 icon: const Icon(
// //                                   Icons.add,
// //                                   color: Color(0xFF8A2724),
// //                                 ))
// //                           ],
// //                         ),
// //                         ListBody(
// //                           children: schoolController.selectedStaff
// //                               .map((items2) => Row(
// //                                     children: [
// //                                       Text(
// //                                         items2,
// //                                         style: const TextStyle(
// //                                           color: Color(0xFF8A2724),
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ))
// //                               .toList(),
// //                         ),
// //                         _validateStaff
// //                             ? const Text('Please select a staff',
// //                                 style: TextStyle(
// //                                     fontSize: 12,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: Colors.red))
// //                             : const SizedBox(),
// //                         Container(height: 10),
// //                         Row(
// //                           children: [
// //                             const Text('Add School Details:',
// //                                 style: TextStyle(
// //                                     fontSize: 16,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: MyColors.grey_95)),
// //                             IconButton(
// //                                 onPressed: () {
// //                                   setState(() {
// //                                     schoolController
// //                                         .filterdata(dropdownValue2!);

// //                                     displayPopup2(context, 'Add School');
// //                                   });
// //                                 },
// //                                 icon: const Icon(
// //                                   Icons.add,
// //                                   color: Color(0xFF8A2724),
// //                                 ))
// //                           ],
// //                         ),
// //                         GetBuilder<SchoolController>(
// //                             init: SchoolController(),
// //                             builder: (_schoolController) {
// //                               return _schoolController.schoolData == null
// //                                   ? const SizedBox()
// //                                   : ListBody(
// //                                       children: _schoolController.schoolData!
// //                                           .map((items2) => Row(
// //                                                 children: [
// //                                                   Text(
// //                                                     items2.schoolName!,
// //                                                     style: const TextStyle(
// //                                                       color: Color(0xFF8A2724),
// //                                                     ),
// //                                                   ),
// //                                                   // IconButton(
// //                                                   //     onPressed: () {
// //                                                   //       setState(() {
// //                                                   //         displayPopup2(
// //                                                   //           context,
// //                                                   //           'Edit School',
// //                                                   //         );
// //                                                   //       });
// //                                                   //     },
// //                                                   //     icon: const Icon(
// //                                                   //       Icons.edit,
// //                                                   //       size: 20,
// //                                                   //     )),
// //                                                   const Spacer(),
// //                                                   IconButton(
// //                                                       onPressed: () {
// //                                                         setState(() {
// //                                                           schoolController
// //                                                               .schoolData!
// //                                                               .remove(items2);
// //                                                         });
// //                                                       },
// //                                                       icon: const Icon(
// //                                                         Icons.delete,
// //                                                         size: 20,
// //                                                         color: Colors.red,
// //                                                       ))
// //                                                 ],
// //                                               ))
// //                                           .toList(),
// //                                     );
// //                             }),
// //                         _validateSchool
// //                             ? const Text('Please select a school',
// //                                 style: TextStyle(
// //                                     fontSize: 12,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: Colors.red))
// //                             : const SizedBox(),
// //                         Container(height: 10),
// //                         Row(
// //                           children: [
// //                             const Text('Transport: ',
// //                                 style: TextStyle(
// //                                     fontSize: 16,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: MyColors.grey_95)),
// //                             IconButton(
// //                                 onPressed: () {
// //                                   schoolController.selectMainTransport(context);
// //                                 },
// //                                 icon: const Icon(
// //                                   Icons.add,
// //                                   color: Color(0xFF8A2724),
// //                                 ))
// //                           ],
// //                         ),
// //                         GetBuilder<SchoolController>(
// //                             init: SchoolController(),
// //                             builder: (schoolController) {
// //                               return ListBody(
// //                                 children: schoolController.selectedMainTransport
// //                                     .map(
// //                                       (items2) => Column(
// //                                         children: [
// //                                           Row(children: [
// //                                             Text(items2,
// //                                                 style: const TextStyle(
// //                                                     fontSize: 12,
// //                                                     fontWeight:
// //                                                         FontWeight.normal,
// //                                                     color: MyColors.grey_95)),
// //                                             IconButton(
// //                                                 onPressed: () {
// //                                                   displayPopup1(
// //                                                     context,
// //                                                     items2.tr,
// //                                                   );
// //                                                 },
// //                                                 icon: const Icon(Icons.add))
// //                                           ]),
// //                                           items2 == 'Staff Transport'
// //                                               ? ListBody(
// //                                                   children:
// //                                                       schoolController
// //                                                           .staffData!
// //                                                           .map(
// //                                                             (items2) => Column(
// //                                                               children: [
// //                                                                 Row(children: [
// //                                                                   Text(
// //                                                                       items2
// //                                                                           .modeofTransport
// //                                                                           .toString(),
// //                                                                       style: const TextStyle(
// //                                                                           fontSize:
// //                                                                               12,
// //                                                                           fontWeight: FontWeight
// //                                                                               .normal,
// //                                                                           color:
// //                                                                               MyColors.grey_95)),
// //                                                                   const Spacer(),
// //                                                                   IconButton(
// //                                                                       onPressed:
// //                                                                           () {
// //                                                                         setState(
// //                                                                             () {
// //                                                                           schoolController
// //                                                                               .staffData!
// //                                                                               .remove(items2);
// //                                                                         });
// //                                                                       },
// //                                                                       icon:
// //                                                                           const Icon(
// //                                                                         Icons
// //                                                                             .delete,
// //                                                                         color: Colors
// //                                                                             .red,
// //                                                                       ))
// //                                                                 ]),
// //                                                               ],
// //                                                             ),
// //                                                           )
// //                                                           .toList(),
// //                                                 )
// //                                               : ListBody(
// //                                                   children:
// //                                                       schoolController
// //                                                           .goodsData!
// //                                                           .map(
// //                                                             (items2) => Column(
// //                                                               children: [
// //                                                                 Row(children: [
// //                                                                   Text(
// //                                                                       items2
// //                                                                           .modeofTransport
// //                                                                           .toString(),
// //                                                                       style: const TextStyle(
// //                                                                           fontSize:
// //                                                                               12,
// //                                                                           fontWeight: FontWeight
// //                                                                               .normal,
// //                                                                           color:
// //                                                                               MyColors.grey_95)),
// //                                                                   const Spacer(),
// //                                                                   IconButton(
// //                                                                       onPressed:
// //                                                                           () {
// //                                                                         setState(
// //                                                                             () {
// //                                                                           schoolController
// //                                                                               .goodsData!
// //                                                                               .remove(items2);
// //                                                                         });
// //                                                                       },
// //                                                                       icon:
// //                                                                           const Icon(
// //                                                                         Icons
// //                                                                             .delete,
// //                                                                         color: Colors
// //                                                                             .red,
// //                                                                       ))
// //                                                                 ]),
// //                                                               ],
// //                                                             ),
// //                                                           )
// //                                                           .toList(),
// //                                                 )
// //                                         ],
// //                                       ),
// //                                     )
// //                                     .toList(),
// //                               );
// //                             }),
// //                         Container(height: 10),
// //                         _validateTransport
// //                             ? const Text(
// //                                 'Please select atleast one transport Mode',
// //                                 style: TextStyle(
// //                                     fontSize: 12,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: Colors.red))
// //                             : const SizedBox(),
// //                         _validateGoodsT
// //                             ? const Text(
// //                                 'Please select atleast one transport for Goods',
// //                                 style: TextStyle(
// //                                     fontSize: 12,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: Colors.red))
// //                             : const SizedBox(),
// //                         Container(height: 10),
// //                         _validateStaffT
// //                             ? const Text(
// //                                 'Please select atleast one transport for Staff',
// //                                 style: TextStyle(
// //                                     fontSize: 12,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: Colors.red))
// //                             : const SizedBox(),
// //                         Container(height: 20),
// //                         const Text('DA (Daily Allowance):',
// //                             style: TextStyle(
// //                                 fontSize: 15,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: MyColors.grey_95)),
// //                         Container(height: 10),
// //                         Container(
// //                           height: 45,
// //                           decoration: const BoxDecoration(
// //                               color: Colors.white,
// //                               borderRadius:
// //                                   BorderRadius.all(Radius.circular(4))),
// //                           alignment: Alignment.centerLeft,
// //                           padding: const EdgeInsets.symmetric(horizontal: 25),
// //                           child: TextField(
// //                             textInputAction: TextInputAction.next,
// //                             onSubmitted: (value) {},
// //                             maxLines: 1,
// //                             controller: _daController,
// //                             decoration: InputDecoration(
// //                                 contentPadding: const EdgeInsets.all(-12),
// //                                 border: InputBorder.none,
// //                                 hintText: "DA",
// //                                 hintStyle: MyText.body1(context)!
// //                                     .copyWith(color: MyColors.grey_40)),
// //                           ),
// //                         ),
// //                         _validateDA
// //                             ? const Text('Please fill DA',
// //                                 style: TextStyle(
// //                                     fontSize: 12,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: Colors.red))
// //                             : const SizedBox(),
// //                         const SizedBox(
// //                           height: 15,
// //                         ),
// //                         SizedBox(
// //                           width: double.infinity,
// //                           height: 45,
// //                           child: ElevatedButton(
// //                             style: ElevatedButton.styleFrom(
// //                                 primary: const Color(0xFF8A2724), elevation: 0),
// //                             child: Text("Create TourBudget",
// //                                 style: MyText.subhead(context)!
// //                                     .copyWith(color: Colors.white)),
// //                             onPressed: () async {
// //                               setState(() {
// //                                 teamleader != null
// //                                     ? _validateLeader = false
// //                                     : _validateLeader = true;
// //                                 _state != null
// //                                     ? _validatestate = false
// //                                     : _validatestate = true;
// //                                 _districtName != null
// //                                     ? _validateDistrict = false
// //                                     : _validateDistrict = true;

// //                                 _blockName != null
// //                                     ? _validateblock = false
// //                                     : _validateblock = true;

// //                                 _fromController.text.isNotEmpty
// //                                     ? _validateFrom = false
// //                                     : _validateFrom = true;

// //                                 _toController.text.isNotEmpty
// //                                     ? _validateTo = false
// //                                     : _validateTo = true;

// //                                 schoolController.staffData!.isNotEmpty
// //                                     ? _validateStaff = false
// //                                     : _validateStaff = true;

// //                                 schoolController.schoolData!.isNotEmpty
// //                                     ? _validateSchool = false
// //                                     : _validateSchool = true;

// //                                 schoolController
// //                                         .selectedMainTransport.isNotEmpty
// //                                     ? _validateTransport = false
// //                                     : _validateTransport = true;

// //                                 if (!_validateTransport) {
// //                                   schoolController.goodsData!.isNotEmpty
// //                                       ? _validateGoodsT = false
// //                                       : _validateGoodsT = true;

// //                                   schoolController.staffData!.isNotEmpty
// //                                       ? _validateStaffT = false
// //                                       : _validateStaffT = true;
// //                                 }
// //                                 _daController.text.isNotEmpty
// //                                     ? _validateDA = false
// //                                     : _validateDA = true;
// //                               });

// //                               if (!_validateLeader &&
// //                                   !_validatestate &&
// //                                   !_validateDistrict &&
// //                                   !_validateblock &&
// //                                   !_validateFrom &&
// //                                   //  !_validatePaymentApprovedBy &&
// //                                   !_validateTo &&
// //                                   !_validateStaff &&
// //                                   !_validateSchool &&
// //                                   !_validateTransport &&
// //                                   //  !_validateExpenseApprovedBy &&
// //                                   !_validateStaffT &&
// //                                   !_validateGoodsT &&
// //                                   !_validateDA) {
// //                                 isLoading.value = true;

// //                                 for (int i = 0;
// //                                     i <= schoolController.schoolData!.length;
// //                                     i++) {
// //                                   List<String> programm = [];
// //                                   for (int k = 0;
// //                                       k <
// //                                           schoolController
// //                                               .schoolData![i].programme!.length;
// //                                       k++) {
// //                                     programm.add(schoolController
// //                                         .schoolData![i].programme![k].program!);
// //                                   }
// //                                   var rsp = await insertTourData(
// //                                       teamleader!,
// //                                       dropdownValue!,
// //                                       dropdownValue1!,
// //                                       dropdownValue2!,
// //                                       programm,
// //                                       schoolController.from.toString(),
// //                                       schoolController.to.toString(),
// //                                       schoolController
// //                                           .schoolData![i].schoolName!,
// //                                       schoolController
// //                                           .schoolData![i].visitDate!,
// //                                       schoolController.selectedStaff,
// //                                       schoolController.selectedMainTransport,
// //                                       schoolController.gmode,
// //                                       schoolController.gvehicleNo,
// //                                       schoolController.gSelectCar,
// //                                       schoolController.goods,
// //                                       schoolController.gdistance,
// //                                       schoolController.gamount,
// //                                       schoolController.smode,
// //                                       schoolController.samount,
// //                                       schoolController.svehicleNo,
// //                                       schoolController.sdistance,
// //                                       schoolController.sSelectCar,
// //                                       schoolController.schoolData![i].activity!,
// //                                       schoolController
// //                                           .schoolData![i].distribution!,
// //                                       schoolController.schoolData![i].setup!,
// //                                       schoolController
// //                                           .schoolData![i].collection!,
// //                                       _daController.text,
// //                                       '',
// //                                       '');
// //                                   print(rsp);
// //                                   if (rsp['status'].toString() == '1') {
// //                                     print('Done');
// //                                   }
// //                                   setState(() {
// //                                     isLoading.value = false;
// //                                   });
// //                                 }
// //                               }
// //                             },
// //                           ),
// //                         )
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //           //  ),
// //         ));
// //   }
// // }

// // void displayPopup2(
// //   BuildContext context,
// //   String title,
// // ) {
// //   List<AddSchool> addSchools = [];

// //   showModalBottomSheet<void>(
// //     context: context,
// //     backgroundColor: Colors.white,
// //     shape: const RoundedRectangleBorder(
// //       borderRadius: BorderRadius.only(
// //           topLeft: Radius.circular(24), topRight: Radius.circular(24)),
// //     ),
// //     builder: (BuildContext context) {
// //       return GetBuilder<SchoolController>(builder: (schoolController) {
// //         return LayoutBuilder(
// //           builder: (BuildContext context, BoxConstraints constraints) {
// //             return SingleChildScrollView(
// //               child: ConstrainedBox(
// //                 constraints: BoxConstraints(
// //                   minHeight: constraints.minHeight,
// //                 ),
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     Container(
// //                         child: SizedBox(
// //                       width: MediaQuery.of(context).size.width,
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(12.0),
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Center(
// //                               child: Text(
// //                                 title,
// //                                 textAlign: TextAlign.center,
// //                                 style: const TextStyle(
// //                                   color: Color(0xff353535),
// //                                   fontSize: 18,
// //                                   fontFamily: "Poppins",
// //                                   fontWeight: FontWeight.w600,
// //                                 ),
// //                               ),
// //                             ),
// //                             const SizedBox(
// //                               height: 20,
// //                             ),
// //                             const Text('School Name:',
// //                                 style: TextStyle(
// //                                     fontSize: 16,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: MyColors.grey_95)),
// //                             Container(height: 10),

// //                             Container(
// //                               decoration: BoxDecoration(
// //                                 borderRadius: BorderRadius.circular(5),
// //                                 boxShadow: const [
// //                                   BoxShadow(
// //                                       color: Colors.white,
// //                                       spreadRadius: 1,
// //                                       blurRadius: 5)
// //                                 ],
// //                               ),
// //                               child: Stack(children: [
// //                                 DropdownButton<String>(
// //                                   value: schoolController.schoolName,
// //                                   iconSize: 14,
// //                                   hint: Text(
// //                                     'Select School'.tr,
// //                                     style: const TextStyle(color: Colors.grey),
// //                                   ),
// //                                   items: schoolController.filterd!.map((value) {
// //                                     return DropdownMenuItem<String>(
// //                                         value: value.schoolName.toString(),
// //                                         child: Row(
// //                                           mainAxisSize: MainAxisSize.min,
// //                                           children: [
// //                                             Text(
// //                                               value.schoolName.toString(),
// //                                               style:
// //                                                   const TextStyle(fontSize: 12),
// //                                             )
// //                                           ],
// //                                         ));
// //                                   }).toList(),
// //                                   onChanged: (data) {
// //                                     schoolController.setValue(data!);
// //                                   },
// //                                 ),
// //                               ]),
// //                             ),
// //                             schoolController.validateName!
// //                                 ? const Text(
// //                                     'Please Select a School',
// //                                     style: TextStyle(
// //                                         fontSize: 12,
// //                                         fontWeight: FontWeight.bold,
// //                                         color: Colors.red),
// //                                   )
// //                                 : const SizedBox(),

// //                             Container(height: 10),
// //                             const Text('Visit Date:',
// //                                 style: TextStyle(
// //                                     fontSize: 16,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: MyColors.grey_95)),
// //                             Container(height: 10),
// //                             Container(
// //                               height: 45,
// //                               decoration: const BoxDecoration(
// //                                   color: Colors.white,
// //                                   borderRadius:
// //                                       BorderRadius.all(Radius.circular(4))),
// //                               alignment: Alignment.centerLeft,
// //                               padding:
// //                                   const EdgeInsets.symmetric(horizontal: 10),
// //                               child: Row(
// //                                 children: <Widget>[
// //                                   Container(width: 15),
// //                                   Expanded(
// //                                     child: TextField(
// //                                       onTap: () {
// //                                         schoolController.selectDate(
// //                                             context,
// //                                             schoolController
// //                                                 .visitDataController);
// //                                       },
// //                                       readOnly: true,
// //                                       onChanged: (value) {},
// //                                       maxLines: 1,
// //                                       style: MyText.body2(context)!
// //                                           .copyWith(color: MyColors.grey_40),
// //                                       keyboardType: TextInputType.datetime,
// //                                       controller:
// //                                           schoolController.visitDataController,
// //                                       decoration: InputDecoration(
// //                                           contentPadding:
// //                                               const EdgeInsets.all(-12),
// //                                           border: InputBorder.none,
// //                                           hintText: "Visit Date(dd-mm-yyyy)",
// //                                           hintStyle: MyText.body1(context)!
// //                                               .copyWith(
// //                                                   color: MyColors.grey_40)),
// //                                     ),
// //                                   ),
// //                                   IconButton(
// //                                       onPressed: () {
// //                                         schoolController.selectDate(
// //                                             context,
// //                                             schoolController
// //                                                 .visitDataController);
// //                                       },
// //                                       icon: const Icon(Icons.calendar_today,
// //                                           color: MyColors.grey_40))
// //                                 ],
// //                               ),
// //                             ),
// //                             schoolController.validateDate!
// //                                 ? const Text(
// //                                     'Please Select a Date',
// //                                     style: TextStyle(
// //                                         fontSize: 12,
// //                                         fontWeight: FontWeight.bold,
// //                                         color: Colors.red),
// //                                   )
// //                                 : const SizedBox(),
// //                             const SizedBox(
// //                               height: 10,
// //                             ),
// //                             Row(
// //                               children: [
// //                                 const Text('Select Programme',
// //                                     style: TextStyle(
// //                                         fontSize: 16,
// //                                         fontWeight: FontWeight.bold,
// //                                         color: MyColors.grey_95)),
// //                                 IconButton(
// //                                     onPressed: () {
// //                                       schoolController.selectProgram(context);
// //                                     },
// //                                     icon: const Icon(
// //                                       Icons.add,
// //                                       color: Color(0xFF8A2724),
// //                                     ))
// //                               ],
// //                             ),
// //                             ListBody(
// //                               children: schoolController.selectedProgramme
// //                                   .map((items2) => Row(
// //                                         children: [
// //                                           Text(
// //                                             items2.program!,
// //                                             style: const TextStyle(
// //                                               color: Color(0xFF8A2724),
// //                                             ),
// //                                           ),
// //                                         ],
// //                                       ))
// //                                   .toList(),
// //                             ),
// //                             schoolController.validateProgramme!
// //                                 ? const Text(
// //                                     'Please Select atleast one Programme',
// //                                     style: TextStyle(
// //                                         fontSize: 12,
// //                                         fontWeight: FontWeight.bold,
// //                                         color: Colors.red),
// //                                   )
// //                                 : const SizedBox(),
// //                             Container(height: 10),
// //                             Row(
// //                               children: [
// //                                 const Text('Select Activity',
// //                                     style: TextStyle(
// //                                         fontSize: 16,
// //                                         fontWeight: FontWeight.bold,
// //                                         color: MyColors.grey_95)),
// //                                 IconButton(
// //                                     onPressed: () {
// //                                       schoolController.selectActivity(context);
// //                                     },
// //                                     icon: const Icon(
// //                                       Icons.add,
// //                                       color: Color(0xFF8A2724),
// //                                     ))
// //                               ],
// //                             ),
// //                             ListBody(
// //                               children: schoolController.selectedActivity
// //                                   .map((items2) => Row(
// //                                         children: [
// //                                           Text(
// //                                             items2,
// //                                             style: const TextStyle(
// //                                               color: Color(0xFF8A2724),
// //                                             ),
// //                                           ),
// //                                         ],
// //                                       ))
// //                                   .toList(),
// //                             ),
// //                             schoolController.validateActivity!
// //                                 ? const Text(
// //                                     'Please Select atleast one Activity',
// //                                     style: TextStyle(
// //                                         fontSize: 12,
// //                                         fontWeight: FontWeight.bold,
// //                                         color: Colors.red),
// //                                   )
// //                                 : const SizedBox(),
// //                             Container(height: 20),

// //                             schoolController.selectedActivity
// //                                     .contains('Distribution')
// //                                 ? Row(
// //                                     children: [
// //                                       const Text('Select Distribution',
// //                                           style: TextStyle(
// //                                               fontSize: 16,
// //                                               fontWeight: FontWeight.bold,
// //                                               color: MyColors.grey_95)),
// //                                       IconButton(
// //                                           onPressed: () {
// //                                             schoolController
// //                                                 .selectDistribution(context);
// //                                           },
// //                                           icon: const Icon(
// //                                             Icons.add,
// //                                             color: Color(0xFF8A2724),
// //                                           ))
// //                                     ],
// //                                   )
// //                                 : const SizedBox(),
// //                             ListBody(
// //                               children: schoolController.selectedDistribution
// //                                   .map((items2) => Row(
// //                                         children: [
// //                                           Text(
// //                                             items2,
// //                                             style: const TextStyle(
// //                                               color: Color(0xFF8A2724),
// //                                             ),
// //                                           ),
// //                                         ],
// //                                       ))
// //                                   .toList(),
// //                             ),
// //                             schoolController.selectedActivity
// //                                         .contains('Distribution') &&
// //                                     schoolController.validateActivity!
// //                                 ? const Text(
// //                                     'Please Select atleast one Activity',
// //                                     style: TextStyle(
// //                                         fontSize: 12,
// //                                         fontWeight: FontWeight.bold,
// //                                         color: Colors.red),
// //                                   )
// //                                 : const SizedBox(),

// //                             Container(height: 10),
// //                             schoolController.selectedActivity.contains('Setup')
// //                                 ? Row(
// //                                     children: [
// //                                       const Text('Setup',
// //                                           style: TextStyle(
// //                                               fontSize: 16,
// //                                               fontWeight: FontWeight.bold,
// //                                               color: MyColors.grey_95)),
// //                                       IconButton(
// //                                           onPressed: () {
// //                                             schoolController
// //                                                 .selectSetup(context);
// //                                           },
// //                                           icon: const Icon(
// //                                             Icons.add,
// //                                             color: Color(0xFF8A2724),
// //                                           ))
// //                                     ],
// //                                   )
// //                                 : const SizedBox(),
// //                             ListBody(
// //                               children: schoolController.selectedSetup
// //                                   .map((items2) => Row(
// //                                         children: [
// //                                           Text(
// //                                             items2,
// //                                             style: const TextStyle(
// //                                               color: Color(0xFF8A2724),
// //                                             ),
// //                                           ),
// //                                         ],
// //                                       ))
// //                                   .toList(),
// //                             ),
// //                             schoolController.selectedActivity
// //                                         .contains('Setup') &&
// //                                     schoolController.validateSetup!
// //                                 ? const Text(
// //                                     'Please Select atleast one Setup',
// //                                     style: TextStyle(
// //                                         fontSize: 12,
// //                                         fontWeight: FontWeight.bold,
// //                                         color: Colors.red),
// //                                   )
// //                                 : const SizedBox(),
// //                             // _validateProgram
// //                             //     ? const Text('Please select a programme',
// //                             //         style: TextStyle(
// //                             //             fontSize: 12,
// //                             //             fontWeight: FontWeight.bold,
// //                             //             color: Colors.red))
// //                             //     : const SizedBox(),
// //                             Container(height: 10),
// //                             schoolController.selectedActivity
// //                                     .contains('Data Collection')
// //                                 ? Row(
// //                                     children: [
// //                                       const Text('Collection',
// //                                           style: TextStyle(
// //                                               fontSize: 16,
// //                                               fontWeight: FontWeight.bold,
// //                                               color: MyColors.grey_95)),
// //                                       IconButton(
// //                                           onPressed: () {
// //                                             schoolController
// //                                                 .selectCollection(context);
// //                                           },
// //                                           icon: const Icon(
// //                                             Icons.add,
// //                                             color: Color(0xFF8A2724),
// //                                           ))
// //                                     ],
// //                                   )
// //                                 : const SizedBox(),
// //                             ListBody(
// //                               children: schoolController.selectedCollection
// //                                   .map((items2) => Row(
// //                                         children: [
// //                                           Text(
// //                                             items2,
// //                                             style: const TextStyle(
// //                                               color: Color(0xFF8A2724),
// //                                             ),
// //                                           ),
// //                                         ],
// //                                       ))
// //                                   .toList(),
// //                             ),
// //                             schoolController.selectedActivity
// //                                         .contains('Data Collection') &&
// //                                     schoolController.validateActivity!
// //                                 ? const Text(
// //                                     'Please Select atleast one Collection',
// //                                     style: TextStyle(
// //                                         fontSize: 12,
// //                                         fontWeight: FontWeight.bold,
// //                                         color: Colors.red),
// //                                   )
// //                                 : const SizedBox(),
// //                             Container(height: 10),

// //                             SizedBox(
// //                               width: double.infinity,
// //                               height: 45,
// //                               child: ElevatedButton(
// //                                 style: ElevatedButton.styleFrom(
// //                                     primary: const Color(0xFF8A2724),
// //                                     elevation: 0),
// //                                 child: Text("Add School",
// //                                     style: MyText.subhead(context)!
// //                                         .copyWith(color: Colors.white)),
// //                                 onPressed: () async {
// //                                   AddSchool data = AddSchool(
// //                                       schoolName: schoolController.schoolName,
// //                                       visitDate: schoolController
// //                                           .visitDataController.text,
// //                                       collection:
// //                                           schoolController.selectedCollection,
// //                                       programme:
// //                                           schoolController.selectedProgramme,
// //                                       activity:
// //                                           schoolController.selectedActivity,
// //                                       distribution:
// //                                           schoolController.selectedDistribution,
// //                                       setup: schoolController.selectedSetup);

// //                                   addSchools.add(data);
// //                                   schoolController.validateSchool();

// //                                   if (!schoolController.validateName! &&
// //                                       !schoolController.validateDate! &&
// //                                       !schoolController.validateProgramme! &&
// //                                       !schoolController.validateActivity! &&
// //                                       !schoolController.validateDistribution! &&
// //                                       !schoolController.validateSetup! &&
// //                                       !schoolController.validateCollection!) {
// //                                     schoolController.addSchoolData(
// //                                       addSchools,
// //                                     );
// //                                     schoolController.distribution!.clear();
// //                                     schoolController.schoolName1 = "";
// //                                     schoolController.clearData();

// //                                     Navigator.of(context).pop();
// //                                   }
// //                                 },
// //                               ),
// //                             ),
// //                             const SizedBox(height: 20),
// //                           ],
// //                         ),
// //                       ),
// //                     ))
// //                   ],
// //                 ),
// //               ),
// //             );
// //           },
// //         );
// //       });
// //       // );
// //     },
// //   );
// // }

// // //programme name ->  Setup and Distribution

// // class MultiSelect extends StatefulWidget {
// //   final List<SchoolData>? items;
// //   final String? title;
// //   final List<Datum>? items2;
// //   final List<ProgrammeMaster>? programme;
// //   final List<String>? activity;
// //   final List<String>? collection;
// //   final List<ProgrammeMaster>? setup;
// //   final List<String>? officeCar;
// //   final List<String>? items4;
// //   final List<String>? mode;
// //   final List<String>? goods;
// //   final List<Data1>? distribution;

// //   const MultiSelect(
// //       {Key? key,
// //       this.items,
// //       this.items2,
// //       this.programme,
// //       this.title,
// //       this.items4,
// //       this.mode,
// //       this.goods,
// //       this.activity,
// //       this.collection,
// //       this.setup,
// //       this.officeCar,
// //       this.distribution})
// //       : super(key: key);

// //   @override
// //   State<StatefulWidget> createState() => _MultiSelectState();
// // }

// // class _MultiSelectState extends State<MultiSelect> {
// //   // this variable holds the selected items
// //   final List<String> _selectedItems = [];

// // // This function is triggered when a checkbox is checked or unchecked
// //   void _itemChange(String itemValue, bool isSelected) {
// //     setState(() {
// //       if (isSelected) {
// //         if (!schoolController.selectedStaff.contains(itemValue)) {
// //           _selectedItems.add(itemValue);
// //         }
// //       } else {
// //         _selectedItems.remove(itemValue);
// //       }
// //     });
// //   }

// //   String? help;

// //   // this function is called when the Cancel button is pressed
// //   void _cancel() {
// //     Navigator.pop(context);
// //   }

// // // this function is called when the Submit button is tapped
// //   void _submit() {
// //     setState(() {
// //       Navigator.pop(context, _selectedItems);
// //     });
// //   }

// //   // var value = true;
// //   @override
// //   Widget build(BuildContext context) {
// //     return AlertDialog(
// //       title: Text(widget.title!),
// //       content: GetBuilder<SchoolController>(
// //           init: SchoolController(),
// //           builder: (schoolController) {
// //             return SingleChildScrollView(
// //                 child: widget.distribution == null
// //                     ? widget.officeCar == null
// //                         ? widget.goods == null
// //                             ? widget.collection == null
// //                                 ? widget.setup == null
// //                                     ? widget.activity == null
// //                                         ? widget.items4 == null
// //                                             ? widget.programme == null
// //                                                 ? widget.items == null
// //                                                     ? ListBody(
// //                                                         children: widget.items2!
// //                                                             .map((items2) {
// //                                                           // if (help == null) {
// //                                                           //   help =
// //                                                           //       items2.location;
// //                                                           // } else {
// //                                                           //   if (help ==
// //                                                           //       items2
// //                                                           //           .location) {
// //                                                           //     help = '';
// //                                                           //   } else {
// //                                                           //     help = items2
// //                                                           //         .location;
// //                                                           //   }
// //                                                           // }

// //                                                           return Column(
// //                                                             crossAxisAlignment:
// //                                                                 CrossAxisAlignment
// //                                                                     .start,
// //                                                             mainAxisSize:
// //                                                                 MainAxisSize
// //                                                                     .min,
// //                                                             children: [
// //                                                               // Text(
// //                                                               //   help!,
// //                                                               //   style:
// //                                                               //       const TextStyle(
// //                                                               //     fontWeight:
// //                                                               //         FontWeight
// //                                                               //             .bold,
// //                                                               //   ),
// //                                                               // ),
// //                                                               CheckboxListTile(
// //                                                                   subtitle:
// //                                                                       Text(
// //                                                                           items2
// //                                                                               .location!),
// //                                                                   activeColor:
// //                                                                       const Color(
// //                                                                           0xFF8A2724),
// //                                                                   value: schoolController
// //                                                                       .selectedStaff
// //                                                                       .contains(items2
// //                                                                               .firstName! +
// //                                                                           " " +
// //                                                                           items2
// //                                                                               .lastName!),
// //                                                                   title: Text(items2
// //                                                                           .firstName! +
// //                                                                       " " +
// //                                                                       items2
// //                                                                           .lastName!),
// //                                                                   controlAffinity:
// //                                                                       ListTileControlAffinity
// //                                                                           .leading,
// //                                                                   onChanged:
// //                                                                       (isChecked) =>
// //                                                                           setState(
// //                                                                               () {
// //                                                                             // _itemChange(
// //                                                                             //     items2.firstName! +
// //                                                                             //         " " +
// //                                                                             //         items2.lastName!,
// //                                                                             //     isChecked!);

// //                                                                             schoolController.checkStaff(items2.firstName! +
// //                                                                                 " " +
// //                                                                                 items2.lastName!);
// //                                                                           })),
// //                                                             ],
// //                                                           );
// //                                                         }).toList(),
// //                                                       )
// //                                                     : ListBody(
// //                                                         children: widget.items!
// //                                                             .map((item) =>
// //                                                                 CheckboxListTile(
// //                                                                     activeColor:
// //                                                                         const Color(
// //                                                                             0xFF8A2724),
// //                                                                     value: _selectedItems
// //                                                                         .contains(item
// //                                                                             .schoolName!),
// //                                                                     title: Text(item
// //                                                                         .schoolName!),
// //                                                                     controlAffinity:
// //                                                                         ListTileControlAffinity
// //                                                                             .leading,
// //                                                                     onChanged: (isChecked) =>
// //                                                                         setState(
// //                                                                             () {
// //                                                                           // _itemChange(item.schoolName!,
// //                                                                           //     isChecked!);
// //                                                                         })))
// //                                                             .toList(),
// //                                                       )
// //                                                 : ListBody(
// //                                                     children: widget.programme!
// //                                                         .map((item) =>
// //                                                             CheckboxListTile(
// //                                                                 activeColor:
// //                                                                     const Color(
// //                                                                         0xFF8A2724),
// //                                                                 value: schoolController
// //                                                                     .selectedProgramme
// //                                                                     .contains(
// //                                                                         item),
// //                                                                 title: Text(item
// //                                                                     .program!),
// //                                                                 controlAffinity:
// //                                                                     ListTileControlAffinity
// //                                                                         .leading,
// //                                                                 onChanged:
// //                                                                     (isChecked) =>
// //                                                                         setState(
// //                                                                             () {
// //                                                                           schoolController
// //                                                                               .checkProgramme(item);

// //                                                                           //   _itemChange(item, isChecked!);
// //                                                                         })))
// //                                                         .toList(),
// //                                                   )
// //                                             : ListBody(
// //                                                 children: widget.items4!
// //                                                     .map((item4) =>
// //                                                         CheckboxListTile(
// //                                                             activeColor:
// //                                                                 const Color(
// //                                                                     0xFF8A2724),
// //                                                             value: schoolController
// //                                                                 .selectedMainTransport
// //                                                                 .contains(
// //                                                                     item4),
// //                                                             title: Text(item4),
// //                                                             controlAffinity:
// //                                                                 ListTileControlAffinity
// //                                                                     .leading,
// //                                                             onChanged:
// //                                                                 (isChecked) =>
// //                                                                     setState(
// //                                                                         () {
// //                                                                       schoolController
// //                                                                           .checkMainTransport(
// //                                                                               item4);
// //                                                                     })))
// //                                                     .toList(),
// //                                               )
// //                                         // : ListBody(
// //                                         //     children: widget.mode!
// //                                         //         .map((item) =>
// //                                         //             CheckboxListTile(
// //                                         //                 activeColor:
// //                                         //                     const Color(
// //                                         //                         0xFF8A2724),
// //                                         //                 value: schoolController
// //                                         //                     .selectedVehicle
// //                                         //                     .contains(item),
// //                                         //                 title: Text(item),
// //                                         //                 controlAffinity:
// //                                         //                     ListTileControlAffinity
// //                                         //                         .leading,
// //                                         //                 onChanged:
// //                                         //                     (isChecked) =>
// //                                         //                         setState(
// //                                         //                             () {
// //                                         //                           schoolController
// //                                         //                               .checkTransport(
// //                                         //                                   item);
// //                                         //                         })))
// //                                         //         .toList(),
// //                                         //   )
// //                                         : ListBody(
// //                                             children: widget.activity!
// //                                                 .map((item) => CheckboxListTile(
// //                                                     activeColor:
// //                                                         const Color(0xFF8A2724),
// //                                                     value: schoolController
// //                                                         .selectedActivity
// //                                                         .contains(item),
// //                                                     title: Text(item),
// //                                                     controlAffinity:
// //                                                         ListTileControlAffinity
// //                                                             .leading,
// //                                                     onChanged: (isChecked) =>
// //                                                         setState(() {
// //                                                           schoolController
// //                                                               .checkActivity(
// //                                                                   item);
// //                                                         })))
// //                                                 .toList(),
// //                                           )
// //                                     : ListBody(
// //                                         children: widget.setup!
// //                                             .map((item) => CheckboxListTile(
// //                                                 activeColor:
// //                                                     const Color(0xFF8A2724),
// //                                                 // ignore: iterable_contains_unrelated_type
// //                                                 value: schoolController
// //                                                     .selectedSetup
// //                                                     .contains(item),
// //                                                 title: Text(item.program!),
// //                                                 controlAffinity:
// //                                                     ListTileControlAffinity
// //                                                         .leading,
// //                                                 onChanged: (isChecked) =>
// //                                                     setState(() {
// //                                                       schoolController
// //                                                           .checkSetup(
// //                                                               item.program!);
// //                                                       //   _itemChange(item, isChecked!);
// //                                                     })))
// //                                             .toList(),
// //                                       )
// //                                 : ListBody(
// //                                     children: widget.collection!
// //                                         .map((item) => CheckboxListTile(
// //                                             activeColor:
// //                                                 const Color(0xFF8A2724),
// //                                             value: schoolController
// //                                                 .selectedCollection
// //                                                 .contains(item),
// //                                             title: Text(item),
// //                                             controlAffinity:
// //                                                 ListTileControlAffinity.leading,
// //                                             onChanged: (isChecked) =>
// //                                                 setState(() {
// //                                                   schoolController
// //                                                       .checkCollection(item);
// //                                                   //   _itemChange(item, isChecked!);
// //                                                 })))
// //                                         .toList(),
// //                                   )
// //                             : ListBody(
// //                                 children: widget.goods!
// //                                     .map((item) => CheckboxListTile(
// //                                         activeColor: const Color(0xFF8A2724),
// //                                         value: schoolController.selectedGoods
// //                                             .contains(item),
// //                                         title: Text(item),
// //                                         controlAffinity:
// //                                             ListTileControlAffinity.leading,
// //                                         onChanged: (isChecked) => setState(() {
// //                                               schoolController.checkGoods(item);
// //                                               //   _itemChange(item, isChecked!);
// //                                             })))
// //                                     .toList(),
// //                               )
// //                         : ListBody(
// //                             children: widget.officeCar!
// //                                 .map((item) => CheckboxListTile(
// //                                     activeColor: const Color(0xFF8A2724),
// //                                     value: schoolController.selectedSCar
// //                                         .contains(item),
// //                                     title: Text(item),
// //                                     controlAffinity:
// //                                         ListTileControlAffinity.leading,
// //                                     onChanged: (isChecked) => setState(() {
// //                                           schoolController.checkVehicle(item);
// //                                           //   _itemChange(item, isChecked!);
// //                                         })))
// //                                 .toList(),
// //                           )
// //                     : ListBody(
// //                         children: widget.distribution!
// //                             .map((item) => CheckboxListTile(
// //                                 activeColor: const Color(0xFF8A2724),
// //                                 value: schoolController.selectedDistribution
// //                                     .contains(item.itemName!),
// //                                 title: Text(item.itemName!),
// //                                 controlAffinity:
// //                                     ListTileControlAffinity.leading,
// //                                 onChanged: (isChecked) => setState(() {
// //                                       schoolController
// //                                           .checkDistribution(item.itemName!);
// //                                       //   _itemChange(item, isChecked!);
// //                                     })))
// //                             .toList(),
// //                       ));
// //           }),
// //       actions: [
// //         TextButton(
// //           child: const Text(
// //             'Cancel',
// //             style: TextStyle(
// //               color: Color(0xFF8A2724),
// //             ),
// //           ),
// //           onPressed: _cancel,
// //         ),
// //         ElevatedButton(
// //           style: ElevatedButton.styleFrom(
// //             primary: const Color(0xFF8A2724),
// //           ),
// //           child: const Text('Submit'),
// //           onPressed: _submit,
// //         ),
// //       ],
// //     );
// //   }
// // }

// // Future insertTourData(
// //   String tour_leader,
// //   String state_name,
// //   String dist_name,
// //   String block_name,
// //   List<String> program_name,
// //   String datefrom,
// //   String dateto,
// //   String school_name,
// //   String vist_date,
// //   List<String> vist_staff,
// //   List<String> tb_transport,
// //   List<String> gmode_transport,
// //   List<String> gvehicle_no,
// //   List<String> gofficeCar,
// //   List<String> type_goods,
// //   List<String> goods_transport_km,
// //   List<String> goods_transport_amount,
// //   List<String> smode_transport,
// //   List<String> staff_transport_amount,
// //   List<String> svehicle_no,
// //   List<String> staff_transport_km,
// //   List<String> sofficeCar,
// //   List<String> activity,
// //   List<String> distribution,
// //   List<String> program_setup,
// //   List<String> data_collection,
// //   String daily_allowance,
// //   String emp_location,
// //   String vehicle_no,
// // ) async {
// //   print(tour_leader);
// //   print(state_name);
// //   print(dist_name);
// //   print(block_name);
// //   print(program_name);
// //   print(datefrom);
// //   print(dateto);
// //   print(school_name);
// //   print(vist_date);
// //   print(vist_staff);
// //   print(tb_transport);
// //   print(gmode_transport);
// //   print(gvehicle_no);
// //   print(gofficeCar);
// //   print(type_goods);
// //   print(goods_transport_km);
// //   print(goods_transport_amount);
// //   print(smode_transport);
// //   print(staff_transport_amount);
// //   print(svehicle_no);
// //   print(staff_transport_km);
// //   print(sofficeCar);
// //   print(activity);
// //   print(distribution);
// //   print(program_setup);
// //   print(data_collection);
// //   print(daily_allowance);
// //   print(emp_location);
// //   print(vehicle_no);

// //   var response =
// //       await http.post(Uri.parse(MyColors.baseUrl + 'tour_budget'), headers: {
// //     "Accept": "Application/json"
// //   }, body: {
// //     "tour_leader_name": tour_leader.toString(),
// //     "state_name": state_name.toString(),
// //     "dist_name": dist_name.toString(),
// //     "block_name": block_name.toString(),
// //     "program_name": program_name.toString(),
// //     "datefrom": datefrom.toString(),
// //     "dateto": dateto.toString(),
// //     "school_name": school_name.toString(),
// //     "vist_date": vist_date.toString(),
// //     "vist_staff": vist_staff.toString(),
// //     "tb_transport": tb_transport.toString(),
// //     "gmode_transport": gmode_transport.toString(),
// //     "gvehicel_no": gvehicle_no.toString(),
// //     "gvehicle_drop": gofficeCar.toString(),
// //     "type_goods": type_goods.toString(),
// //     "goods_transport_km": goods_transport_km.toString(),
// //     "goods_transport_amount": goods_transport_amount.toString(),
// //     "smode_transport": smode_transport.toString(),
// //     "svehicel_no": svehicle_no.toString(),
// //     "staff_transport_km": staff_transport_km.toString(),
// //     "staff_transport_amount": staff_transport_amount.toString(),
// //     "svehicle_drop": sofficeCar.toString(),
// //     "activity": activity.toString(),
// //     "distribution": distribution.toString(),
// //     "program_setup": program_setup.toString(),
// //     "data_collection": data_collection.toString(),
// //     "daily_allowance": daily_allowance.toString(),
// //     "emp_location": emp_location.toString(),
// //     "tour_id": ''.toString(),
// //     "vehicle_no": vehicle_no.toString(),
// //   });
// //   var convertedDatatoJson = jsonDecode(response.body);
// //   return convertedDatatoJson;
// // }

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:form/Controllers/issue_tracker_Controller.dart';
// import 'package:form/Controllers/pendingExpenses_Controller.dart';
// import 'package:form/Controllers/school_Controller.dart';
// import 'package:form/Model/distribution.dart';
// import 'package:form/Model/programme.dart';
// import 'package:form/Model/school_data.dart';
// import 'package:form/Model/staff_data.dart';
// import 'package:form/Model/state_model.dart' as c;
// import 'package:form/home_screen.dart';

// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../colors.dart';
// import '../custom_dialog.dart';
// import '../data.dart';
// import '../my_text.dart';
// import 'package:http/http.dart' as http;

// final StateController _stateController = Get.put(StateController());
// final DistrictController _districtController = Get.put(DistrictController());

// final BlockController _blockController = Get.put(BlockController());
// final SchoolController _schoolController = Get.put(SchoolController());
// final StaffController staffController = Get.put(StaffController());
// final IssueTrackerController issueTracker = Get.put(IssueTrackerController());

// class TourBudget extends StatefulWidget {
//   const TourBudget({Key? key}) : super(key: key);

//   @override
//   _TourBudgetState createState() => _TourBudgetState();
// }

// class _TourBudgetState extends State<TourBudget> {
//   TextEditingController _officeController = TextEditingController();
//   TextEditingController _fromController = TextEditingController();
//   TextEditingController _toController = TextEditingController();
//   TextEditingController _daController = TextEditingController();
//   TextEditingController _noOfDayController = TextEditingController();

//   bool _validateLeader = false;

//   bool _validatestate = false;

//   bool _validateblock = false;
//   bool _validateDistrict = false;
//   bool _validateProgram = false;
//   bool _validateFrom = false;
//   bool _validateTo = false;
//   bool _validateStaff = false;
//   bool _validateSchool = false;
//   bool _validateTransport = false;
//   bool _validateStaffT = false;
//   bool _validateGoodsT = false;

//   bool _validateDA = false;
//   var _loading = false.obs;
//   String? _districtName;
//   String? _state;
//   String? _blockName;
//   String? _programName;
//   String? _fromDate;
//   String? _toDate;

//   String? dropdownValue;
//   String? dropdownValue1;
//   String? dropdownValue2;
//   String? dropdownValue3;
//   String? dropdownValue4;
//   String? dropdownValue5;
//   String? dropdownValue6;
//   String? dropdownValue7;

//   int? from;
//   int? to;

//   getNumber(int a) {
//     return a;
//   }

//   List<String> _selectedTransport = [];

//   @override
//   void initState() {
//     super.initState();

//     _selectedTransport = [];
//   }

//   void displayPopup1(BuildContext context, String title) {
//     String? modeOfTransport;
//     String? dropDownValue2;
//     String? dropDownValue3;
//     String? dropDownValue4;

//     showModalBottomSheet<void>(
//       context: context,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(24), topRight: Radius.circular(24)),
//       ),
//       builder: (BuildContext context) {
//         return GetBuilder<SchoolController>(
//             init: schoolController,
//             builder: (schoolController) {
//               return LayoutBuilder(
//                 builder: (BuildContext context, BoxConstraints constraints) {
//                   return SingleChildScrollView(
//                     child: ConstrainedBox(
//                       constraints: BoxConstraints(
//                         minHeight: constraints.minHeight,
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width,
//                             child: Padding(
//                               padding: const EdgeInsets.all(12.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Center(
//                                     child: Text(
//                                       title,
//                                       textAlign: TextAlign.center,
//                                       style: const TextStyle(
//                                         color: Color(0xff353535),
//                                         fontSize: 18,
//                                         fontFamily: "Poppins",
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   const Text('Mode of Transport:',
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                           color: MyColors.grey_95)),
//                                   Container(height: 10),
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5),
//                                       boxShadow: const [
//                                         BoxShadow(
//                                             color: Colors.white,
//                                             spreadRadius: 1,
//                                             blurRadius: 5)
//                                       ],
//                                     ),
//                                     child: Stack(children: [
//                                       DropdownButton<String>(
//                                         value: title == 'Goods Transport'
//                                             ? schoolController.selectedGoodsMode
//                                             : schoolController
//                                                 .selectedStaffMode,
//                                         iconSize: 14,
//                                         hint: Text(
//                                           'Select Mode of Transport'.tr,
//                                           style: const TextStyle(
//                                               color: Colors.grey),
//                                         ),
//                                         items: title == 'Goods Transport'
//                                             ? DataModel()
//                                                 .modeOfGoodsTransport
//                                                 .map((value) {
//                                                 return DropdownMenuItem<String>(
//                                                     value: value,
//                                                     child: Row(
//                                                       mainAxisSize:
//                                                           MainAxisSize.min,
//                                                       children: [
//                                                         Text(
//                                                           value,
//                                                           style:
//                                                               const TextStyle(
//                                                                   fontSize: 12),
//                                                         )
//                                                       ],
//                                                     ));
//                                               }).toList()
//                                             : DataModel()
//                                                 .modeOfStaffTransport
//                                                 .map((value) {
//                                                 return DropdownMenuItem<String>(
//                                                     value: value,
//                                                     child: Row(
//                                                       mainAxisSize:
//                                                           MainAxisSize.min,
//                                                       children: [
//                                                         Text(
//                                                           value,
//                                                           style:
//                                                               const TextStyle(
//                                                                   fontSize: 12),
//                                                         )
//                                                       ],
//                                                     ));
//                                               }).toList(),
//                                         onChanged: (data) {
//                                           if (title == 'Goods Transport') {
//                                             schoolController.setDropVal(
//                                                 title, data!);
//                                           } else if (title ==
//                                               'Staff Transport') {
//                                             schoolController.setDropVal(
//                                                 title, data!);
//                                           }
//                                         },
//                                       ),
//                                     ]),
//                                   ),
//                                   schoolController.validateStaffMode! ||
//                                           schoolController.validateGoodsMode!
//                                       ? const Text(
//                                           'Please select a transport mode',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.red))
//                                       : const SizedBox(),
//                                   title == 'Goods Transport'
//                                       ? Container(height: 10)
//                                       : const SizedBox(),
//                                   title == 'Goods Transport'
//                                       ? Row(
//                                           children: [
//                                             const Text('Types of Goods:',
//                                                 style: TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: MyColors.grey_95)),
//                                             IconButton(
//                                                 onPressed: () {
//                                                   schoolController
//                                                       .selectTypesofGoods(
//                                                           context);
//                                                 },
//                                                 icon: const Icon(
//                                                   Icons.add,
//                                                   color: Color(0xFF8A2724),
//                                                 ))
//                                           ],
//                                         )
//                                       : const SizedBox(),
//                                   ListBody(
//                                     children: schoolController.selectedGoods
//                                         .map((items2) => Row(
//                                               children: [
//                                                 Text(
//                                                   items2,
//                                                   style: const TextStyle(
//                                                     color: Color(0xFF8A2724),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ))
//                                         .toList(),
//                                   ),
//                                   schoolController.validateGoodsAfjal!
//                                       ? const Text('Please select a Goods type',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.red))
//                                       : const SizedBox(),
//                                   Container(height: 10),
//                                   schoolController.selectedStaffMode ==
//                                               ('Rented Car') ||
//                                           schoolController.selectedGoodsMode ==
//                                               ('Rented Car')
//                                       ? const Text('Vehicle No.:',
//                                           style: TextStyle(
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.bold,
//                                               color: MyColors.grey_95))
//                                       : const SizedBox(),
//                                   Container(height: 10),
//                                   schoolController.selectedStaffMode ==
//                                               ('Rented Car') ||
//                                           schoolController.selectedGoodsMode ==
//                                               ('Rented Car')
//                                       ? Container(
//                                           height: 45,
//                                           decoration: const BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(4))),
//                                           alignment: Alignment.centerLeft,
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 25),
//                                           child: TextField(
//                                             textInputAction:
//                                                 TextInputAction.next,
//                                             onSubmitted: (value) {},
//                                             maxLines: 1,
//                                             controller:
//                                                 schoolController.vehicle,
//                                             decoration: InputDecoration(
//                                                 contentPadding:
//                                                     const EdgeInsets.all(-12),
//                                                 border: InputBorder.none,
//                                                 hintText: "Number of Vehicle"
//                                                     .tr,
//                                                 hintStyle:
//                                                     MyText.body1(context)!
//                                                         .copyWith(
//                                                             color: MyColors
//                                                                 .grey_40)),
//                                           ),
//                                         )
//                                       : const SizedBox(),
//                                   schoolController.selectedStaffMode ==
//                                               ('Rented Car') ||
//                                           schoolController.selectedGoodsMode ==
//                                               ('Rented Car')
//                                       ? schoolController
//                                                   .validateStaffVehicle! ||
//                                               schoolController
//                                                   .validateVehicleNo!
//                                           ? const Text(
//                                               'Please enter a Vehicle No.',
//                                               style: TextStyle(
//                                                   fontSize: 12,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.red))
//                                           : const SizedBox()
//                                       : const SizedBox(),
//                                   Container(height: 10),
//                                   schoolController.selectedStaffMode ==
//                                               ('Office Car') ||
//                                           schoolController.selectedGoodsMode ==
//                                               ('Office Car')
//                                       ? const Text('Vehicle No :',
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                               color: MyColors.grey_95))
//                                       : const SizedBox(),
//                                   schoolController.selectedStaffMode ==
//                                               ('Office Car') ||
//                                           schoolController.selectedGoodsMode ==
//                                               ('Office Car')
//                                       ? Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(5),
//                                             boxShadow: const [
//                                               BoxShadow(
//                                                   color: Colors.white,
//                                                   spreadRadius: 1,
//                                                   blurRadius: 5)
//                                             ],
//                                           ),
//                                           child: Stack(children: [
//                                             DropdownButton<String>(
//                                               value: schoolController.officeCar,
//                                               iconSize: 14,
//                                               hint: Text(
//                                                 'Select a Vehicle'.tr,
//                                                 style: const TextStyle(
//                                                     color: Colors.grey),
//                                               ),
//                                               items: schoolController.car!
//                                                   .map((value) {
//                                                 return DropdownMenuItem<String>(
//                                                     value: value,
//                                                     child: Row(
//                                                       mainAxisSize:
//                                                           MainAxisSize.min,
//                                                       children: [
//                                                         Text(
//                                                           value,
//                                                           style:
//                                                               const TextStyle(
//                                                                   fontSize: 12),
//                                                         )
//                                                       ],
//                                                     ));
//                                               }).toList(),
//                                               onChanged: (data) {
//                                                 setState(() {
//                                                   schoolController.setCar(data);
//                                                 });
//                                               },
//                                             ),
//                                           ]),
//                                         )
//                                       : const SizedBox(),
//                                   schoolController.selectedStaffMode ==
//                                               ('Office Car') ||
//                                           schoolController.selectedGoodsMode ==
//                                               ('Office Car')
//                                       ? schoolController.validateStaffCar! ||
//                                               schoolController
//                                                   .validateGOfficeCar!
//                                           ? const Text(
//                                               'Please select a Vehicle',
//                                               style: TextStyle(
//                                                   fontSize: 12,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.red))
//                                           : const SizedBox()
//                                       : const SizedBox(),
//                                   Container(height: 10),
//                                   const Text('Distance(KM):',
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold,
//                                           color: MyColors.grey_95)),
//                                   Container(height: 10),
//                                   Container(
//                                     height: 45,
//                                     decoration: const BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(4))),
//                                     alignment: Alignment.centerLeft,
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 25),
//                                     child: TextField(
//                                       textInputAction: TextInputAction.next,
//                                       onSubmitted: (value) {},
//                                       maxLines: 1,
//                                       controller: schoolController.distance,
//                                       decoration: InputDecoration(
//                                           contentPadding:
//                                               const EdgeInsets.all(-12),
//                                           border: InputBorder.none,
//                                           hintText: "Enter Distance in KM".tr,
//                                           hintStyle: MyText.body1(context)!
//                                               .copyWith(
//                                                   color: MyColors.grey_40)),
//                                     ),
//                                   ),
//                                   schoolController.validateStaffDistance! ||
//                                           schoolController.validateGDistance!
//                                       ? const Text('Please enter distance',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.red))
//                                       : const SizedBox(),
//                                   Container(height: 20),
//                                   const Text('Amount:',
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold,
//                                           color: MyColors.grey_95)),
//                                   Container(height: 10),
//                                   Container(
//                                     height: 45,
//                                     decoration: const BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(4))),
//                                     alignment: Alignment.centerLeft,
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 25),
//                                     child: TextField(
//                                       textInputAction: TextInputAction.next,
//                                       onSubmitted: (value) {},
//                                       maxLines: 1,
//                                       controller: schoolController.amount,
//                                       decoration: InputDecoration(
//                                           contentPadding:
//                                               const EdgeInsets.all(-12),
//                                           border: InputBorder.none,
//                                           hintText: "Enter Amount",
//                                           hintStyle: MyText.body1(context)!
//                                               .copyWith(
//                                                   color: MyColors.grey_40)),
//                                     ),
//                                   ),
//                                   schoolController.validateStaffAmount! ||
//                                           schoolController.validateGAmount!
//                                       ? const Text('Please fill an amount',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.red))
//                                       : const SizedBox(),
//                                   Container(height: 10),
//                                   SizedBox(
//                                     width: double.infinity,
//                                     height: 45,
//                                     child: ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                           primary: const Color(0xFF8A2724),
//                                           elevation: 0),
//                                       child: Text("Add Transport",
//                                           style: MyText.subhead(context)!
//                                               .copyWith(color: Colors.white)),
//                                       onPressed: () async {
//                                         AddTransport data = AddTransport(
//                                           modeofTransport:
//                                               title == 'Staff Transport'
//                                                   ? schoolController
//                                                       .selectedStaffMode
//                                                   : schoolController
//                                                       .selectedGoodsMode,
//                                           typeOfGoods:
//                                               schoolController.selectedGoods,
//                                           vehicleNo:
//                                               schoolController.vehicle.text,
//                                           selectedVehicle:
//                                               schoolController.officeCar != null
//                                                   ? schoolController.officeCar
//                                                   : '',
//                                           distance:
//                                               schoolController.distance.text,
//                                           amount: schoolController.amount.text,
//                                         );

//                                         if (title == 'Goods Transport') {
//                                           print(title);
//                                           print('Started');
//                                           schoolController.validateGoodsAll();

//                                           print(!schoolController
//                                               .validateGoodsAfjal!);
//                                           print(!schoolController
//                                               .validateGoodsMode!);
//                                           print(!schoolController
//                                               .validateGOfficeCar!);
//                                           print(!schoolController
//                                               .validateVehicleNo!);
//                                           print(!schoolController
//                                               .validateGDistance!);
//                                           if (!schoolController.validateGoodsMode! &&
//                                               !schoolController
//                                                   .validateGoodsAfjal! &&
//                                               !schoolController
//                                                   .validateGOfficeCar! &&
//                                               !schoolController
//                                                   .validateVehicleNo! &&
//                                               !schoolController
//                                                   .validateGAmount! &&
//                                               !schoolController
//                                                   .validateGDistance!) {
//                                             schoolController.addGoodsData(data);
//                                             schoolController.vehicle.clear();

//                                             schoolController.distance.clear();
//                                             schoolController.amount.clear();
//                                             schoolController.clearTransport();

//                                             schoolController.car!.remove(
//                                                 schoolController.officeCar);
//                                             schoolController.setCar(null);

//                                             Navigator.of(context).pop();
//                                           }
//                                         }

//                                         if (title == 'Staff Transport') {
//                                           schoolController
//                                               .validateStaffTransport();

//                                           if (!schoolController
//                                                   .validateStaffMode! &&
//                                               !schoolController
//                                                   .validateStaffCar! &&
//                                               !schoolController
//                                                   .validateStaffVehicle! &&
//                                               !schoolController
//                                                   .validateStaffAmount! &&
//                                               !schoolController
//                                                   .validateStaffDistance!) {
//                                             schoolController.addStaffData(data);
//                                             schoolController.vehicle.clear();

//                                             schoolController.distance.clear();
//                                             schoolController.amount.clear();
//                                             schoolController.clearTransport();
//                                             schoolController.car!.remove(
//                                                 schoolController.officeCar);
//                                             schoolController.setCar(null);

//                                             Navigator.of(context).pop();
//                                           }
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                   const SizedBox(height: 20),
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             });
//         // );
//       },
//     );
//   }

//   void _selectStaff() async {
//     List<String>? results = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return MultiSelect(
//             title: 'Select Staff', items2: staffController.staffList[0].data);
//       },
//     );

//     // Update UI
//     if (results != null) {
//       setState(() {
//         schoolController.selectedStaff.addAll(results);

//         _daController.text = ((int.parse(DateFormat('dd')
//                         .format(DateFormat('dd').parse(_toController.text))) -
//                     int.parse(DateFormat('dd')
//                         .format(DateFormat('dd').parse(_fromController.text))) +
//                     1) *
//                 500 *
//                 schoolController.selectedStaff.length)
//             .toString();
//       });
//     }
//   }

//   //bool _validateState = false;

//   DateTime selectedDate = DateTime.now(), initialDate = DateTime.now();

//   _selectDate(
//     BuildContext context,
//     TextEditingController date,
//     String title,
//   ) async {
//     final DateTime? selected = await showDatePicker(
//       locale: const Locale('en', 'IN'),
//       context: context,
//       initialDate: title == 'to' ? schoolController.from! : DateTime.now(),
//       firstDate: title == 'to' ? schoolController.from! : DateTime.now(),
//       lastDate: DateTime(2040),
//       builder: (context, picker) {
//         return Theme(
//             data: Theme.of(context)
//                 .copyWith(colorScheme: const ColorScheme.light()),
//             child: picker!);
//       },
//     );
//     if (selected != null) {
//       setState(() {
//         selectedDate = selected;
//         schoolController.setDate(selected, title);
//         String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
//         date.text = formattedDate;
//         if (title == 'from') {
//           _toController.clear();
//         }
//       });
//     }
//   }

//   var isLoading = false.obs;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF8A2724),
//           title: const Text(
//             'Tour Budget Form',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//             ),
//           ),
//         ),
//         body: Obx(
//           () => staffController.isLoading.value || isLoading.value
//               ? const Center(child: CircularProgressIndicator())
//               : SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text('Tour Leader:',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: MyColors.grey_95)),
//                         Container(height: 10),
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             boxShadow: const [
//                               BoxShadow(
//                                   color: Colors.white,
//                                   spreadRadius: 1,
//                                   blurRadius: 5)
//                             ],
//                           ),
//                           child: Stack(children: [
//                             DropdownButton<String>(
//                               value: schoolController.teamleader,
//                               iconSize: 14,
//                               hint: Text(
//                                 'Select tour leader'.tr,
//                                 style: const TextStyle(color: Colors.grey),
//                               ),
//                               items:
//                                   staffController.staffList[0].data!.map((value) {
//                                 return DropdownMenuItem<String>(
//                                     value: value.firstName.toString() +
//                                         ' ' +
//                                         value.lastName.toString(),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Text(
//                                           value.firstName.toString() +
//                                               ' ' +
//                                               value.lastName.toString(),
//                                           style: const TextStyle(fontSize: 12),
//                                         )
//                                       ],
//                                     ));
//                               }).toList(),
//                               onChanged: (data) {
//                                 setState(() {
//                                   schoolController.setLeader(data);
//                                 });
//                               },
//                             ),
//                           ]),
//                         ),
//                         _validateLeader
//                             ? const Text('Please select a tour leader',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.red))
//                             : const SizedBox(),
//                         const Text('State:',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: MyColors.grey_95)),
//                         Container(height: 10),
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.9,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             boxShadow: const [
//                               BoxShadow(
//                                   color: Colors.white,
//                                   spreadRadius: 1,
//                                   blurRadius: 5)
//                             ],
//                           ),
//                           child: Stack(children: [
//                             DropdownButton<String>(
//                               value: dropdownValue,
//                               iconSize: 24,
//                               elevation: 2,
//                               hint: Text(
//                                 'Select State'.tr,
//                                 style: const TextStyle(color: Colors.grey),
//                               ),
//                               // ignore: can_be_null_after_null_aware
//                               items: DataModel().state.map((value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value.toString(),
//                                   child: Text(value.toString()),
//                                 );
//                               }).toList(),
//                               onChanged: (data) {
//                                 setState(() {
//                                   dropdownValue = data;
//                                   dropdownValue1 = null;
//                                 });
//                               },
//                             ),
//                           ]),
//                         ),
//                         _validatestate
//                             ? const Text('Please select a state',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.red))
//                             : const SizedBox(),
//                         const Text('District:',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: MyColors.grey_95)),
//                         Container(height: 10),
//                         GetBuilder<DistrictController>(
//                             init: DistrictController(),
//                             builder: (districtController) {
//                               List<c.District>? district;
//                               district =
//                                   districtController.districtList.value.data;

//                               return Container(
//                                 width: MediaQuery.of(context).size.width * 0.9,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   boxShadow: const [
//                                     BoxShadow(
//                                         color: Colors.white,
//                                         spreadRadius: 1,
//                                         blurRadius: 5)
//                                   ],
//                                 ),
//                                 child: Stack(children: [
//                                   DropdownButton<String>(
//                                     value: dropdownValue1,
//                                     iconSize: 24,
//                                     elevation: 2,
//                                     hint: Text(
//                                       'Select District'.tr,
//                                       style:
//                                           const TextStyle(color: Colors.grey),
//                                     ),
//                                     // ignore: can_be_null_after_null_aware
//                                     items: DataModel()
//                                         .districtWithState
//                                         .where((element) =>
//                                             element.state == dropdownValue)
//                                         .map((value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value.district.toString(),
//                                         child: Text(value.district.toString()),
//                                       );
//                                     }).toList(),
//                                     onChanged: (data) {
//                                       setState(() {
//                                         dropdownValue1 = data;
//                                         dropdownValue2 = null;
//                                       });
//                                     },
//                                   ),
//                                 ]),
//                               );
//                             }),
//                         _validateDistrict
//                             ? const Text('Please select a district',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.red))
//                             : const SizedBox(),
//                         const Text('Block Name:',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: MyColors.grey_95)),
//                         Container(height: 10),
//                         GetBuilder<BlockController>(
//                             init: BlockController(),
//                             builder: (blockController) {
//                               return Container(
//                                 width: MediaQuery.of(context).size.width * 0.9,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   boxShadow: const [
//                                     BoxShadow(
//                                         color: Colors.white,
//                                         spreadRadius: 1,
//                                         blurRadius: 5)
//                                   ],
//                                 ),
//                                 child: Stack(children: [
//                                   DropdownButton<String>(
//                                     value: dropdownValue2,
//                                     iconSize: 24,
//                                     elevation: 2,
//                                     hint: Text(
//                                       'Select Block'.tr,
//                                       style:
//                                           const TextStyle(color: Colors.grey),
//                                     ),
//                                     // ignore: can_be_null_after_null_aware
//                                     items: DataModel()
//                                         .blockWithDistrict
//                                         .where((element) =>
//                                             element.district == dropdownValue1)
//                                         .map((value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value.block.toString(),
//                                         child: Text(value.block.toString()),
//                                       );
//                                     }).toList(),
//                                     onChanged: (data) {
//                                       setState(() {
//                                         dropdownValue2 = data;
//                                         dropdownValue4 = null;
//                                       });
//                                     },
//                                   ),
//                                 ]),
//                               );
//                             }),
//                         _validateblock
//                             ? const Text('Please select a block',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.red))
//                             : const SizedBox(),
//                         Container(height: 10),
//                         const Text('From:',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: MyColors.grey_95)),
//                         Container(height: 10),
//                         Container(
//                           height: 45,
//                           decoration: const BoxDecoration(
//                               color: Colors.white,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(4))),
//                           alignment: Alignment.centerLeft,
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: Row(
//                             children: <Widget>[
//                               Container(width: 15),
//                               Expanded(
//                                 child: TextField(
//                                   onTap: () {
//                                     _selectDate(
//                                         context, _fromController, 'from');
//                                   },
//                                   readOnly: true,
//                                   onChanged: (value) {
//                                     setState(() {});
//                                   },
//                                   maxLines: 1,
//                                   style: MyText.body2(context)!
//                                       .copyWith(color: MyColors.grey_40),
//                                   keyboardType: TextInputType.datetime,
//                                   controller: _fromController,
//                                   decoration: InputDecoration(
//                                       contentPadding: const EdgeInsets.all(-12),
//                                       border: InputBorder.none,
//                                       hintText: "Starting Date(dd-mm-yyyy)",
//                                       hintStyle: MyText.body1(context)!
//                                           .copyWith(color: MyColors.grey_40)),
//                                 ),
//                               ),
//                               IconButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       _selectDate(
//                                           context, _fromController, 'from');
//                                     });
//                                   },
//                                   icon: const Icon(Icons.calendar_today,
//                                       color: MyColors.grey_40))
//                             ],
//                           ),
//                         ),
//                         _validateFrom
//                             ? const Text('Please select a date',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.red))
//                             : const SizedBox(),
//                         const Text('To:',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: MyColors.grey_95)),
//                         Container(height: 10),
//                         Container(
//                           height: 45,
//                           decoration: const BoxDecoration(
//                               color: Colors.white,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(4))),
//                           alignment: Alignment.centerLeft,
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: Row(
//                             children: <Widget>[
//                               Container(width: 15),
//                               Expanded(
//                                 child: TextField(
//                                   onTap: () {
//                                     _selectDate(context, _toController, 'to');
//                                   },
//                                   readOnly: true,
//                                   onChanged: (value) {},
//                                   maxLines: 1,
//                                   style: MyText.body2(context)!
//                                       .copyWith(color: MyColors.grey_40),
//                                   keyboardType: TextInputType.datetime,
//                                   controller: _toController,
//                                   decoration: InputDecoration(
//                                       contentPadding: const EdgeInsets.all(-12),
//                                       border: InputBorder.none,
//                                       hintText: "Ending Date(dd-mm-yyyy)",
//                                       hintStyle: MyText.body1(context)!
//                                           .copyWith(color: MyColors.grey_40)),
//                                 ),
//                               ),
//                               IconButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       _selectDate(context, _toController, 'to');
//                                     });
//                                   },
//                                   icon: const Icon(Icons.calendar_today,
//                                       color: MyColors.grey_40))
//                             ],
//                           ),
//                         ),
//                         _validateTo
//                             ? const Text('Please select a date',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.red))
//                             : const SizedBox(),
//                         Container(height: 10),
//                         Row(
//                           children: [
//                             const Text('Staff to Visit:',
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: MyColors.grey_95)),
//                             IconButton(
//                                 onPressed: () {
//                                   _selectStaff();
//                                 },
//                                 icon: const Icon(
//                                   Icons.add,
//                                   color: Color(0xFF8A2724),
//                                 ))
//                           ],
//                         ),
//                         GetBuilder<SchoolController>(
//                             builder: (schoolController) {
//                           return ListBody(
//                             children: schoolController.selectedStaff
//                                 .map((items2) => Row(
//                                       children: [
//                                         Text(
//                                           items2,
//                                           style: const TextStyle(
//                                             color: Color(0xFF8A2724),
//                                           ),
//                                         ),
//                                       ],
//                                     ))
//                                 .toList(),
//                           );
//                         }),
//                         _validateStaff
//                             ? const Text('Please select a staff',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.red))
//                             : const SizedBox(),
//                         Container(height: 10),
//                         Row(
//                           children: [
//                             const Text('Add School Details:',
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: MyColors.grey_95)),
//                             IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     schoolController
//                                         .filterdata(dropdownValue2!);

//                                     displayPopup2(context, 'Add School');
//                                   });
//                                 },
//                                 icon: const Icon(
//                                   Icons.add,
//                                   color: Color(0xFF8A2724),
//                                 ))
//                           ],
//                         ),
//                         GetBuilder<SchoolController>(
//                             init: SchoolController(),
//                             builder: (_schoolController) {
//                               return _schoolController.schoolData == null
//                                   ? const SizedBox()
//                                   : ListBody(
//                                       children: _schoolController.schoolData!
//                                           .map((items2) => Row(
//                                                 children: [
//                                                   Text(
//                                                     items2.schoolName!,
//                                                     style: const TextStyle(
//                                                       color: Color(0xFF8A2724),
//                                                     ),
//                                                   ),
//                                                   // IconButton(
//                                                   //     onPressed: () {
//                                                   //       setState(() {
//                                                   //         displayPopup2(
//                                                   //           context,
//                                                   //           'Edit School',
//                                                   //         );
//                                                   //       });
//                                                   //     },
//                                                   //     icon: const Icon(
//                                                   //       Icons.edit,
//                                                   //       size: 20,
//                                                   //     )),
//                                                   const Spacer(),
//                                                   IconButton(
//                                                       onPressed: () {
//                                                         setState(() {
//                                                           schoolController
//                                                               .schoolData!
//                                                               .remove(items2);
//                                                         });
//                                                       },
//                                                       icon: const Icon(
//                                                         Icons.delete,
//                                                         size: 20,
//                                                         color: Colors.red,
//                                                       ))
//                                                 ],
//                                               ))
//                                           .toList(),
//                                     );
//                             }),
//                         _validateSchool
//                             ? const Text('Please select a school',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.red))
//                             : const SizedBox(),
//                         Container(height: 10),
//                         Row(
//                           children: [
//                             const Text('Transport: ',
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: MyColors.grey_95)),
//                             IconButton(
//                                 onPressed: () {
//                                   schoolController.selectMainTransport(context);
//                                 },
//                                 icon: const Icon(
//                                   Icons.add,
//                                   color: Color(0xFF8A2724),
//                                 ))
//                           ],
//                         ),
//                         GetBuilder<SchoolController>(
//                             init: SchoolController(),
//                             builder: (schoolController) {
//                               return ListBody(
//                                 children: schoolController.selectedMainTransport
//                                     .map(
//                                       (items2) => Column(
//                                         children: [
//                                           Row(children: [
//                                             Text(items2,
//                                                 style: const TextStyle(
//                                                     fontSize: 12,
//                                                     fontWeight:
//                                                         FontWeight.normal,
//                                                     color: MyColors.grey_95)),
//                                             IconButton(
//                                                 onPressed: () {
//                                                   displayPopup1(
//                                                     context,
//                                                     items2.tr,
//                                                   );
//                                                 },
//                                                 icon: const Icon(Icons.add))
//                                           ]),
//                                           items2 == 'Staff Transport'
//                                               ? ListBody(
//                                                   children:
//                                                       schoolController
//                                                           .staffData!
//                                                           .map(
//                                                             (items2) => Column(
//                                                               children: [
//                                                                 Row(children: [
//                                                                   Text(
//                                                                       items2
//                                                                           .modeofTransport
//                                                                           .toString(),
//                                                                       style: const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight: FontWeight
//                                                                               .normal,
//                                                                           color:
//                                                                               MyColors.grey_95)),
//                                                                   const Spacer(),
//                                                                   IconButton(
//                                                                       onPressed:
//                                                                           () {
//                                                                         setState(
//                                                                             () {
//                                                                           schoolController
//                                                                               .staffData!
//                                                                               .remove(items2);

//                                                                           schoolController
//                                                                               .car!
//                                                                               .add(items2.selectedVehicle!);
//                                                                         });
//                                                                       },
//                                                                       icon:
//                                                                           const Icon(
//                                                                         Icons
//                                                                             .delete,
//                                                                         color: Colors
//                                                                             .red,
//                                                                       ))
//                                                                 ]),
//                                                               ],
//                                                             ),
//                                                           )
//                                                           .toList(),
//                                                 )
//                                               : ListBody(
//                                                   children:
//                                                       schoolController
//                                                           .goodsData!
//                                                           .map(
//                                                             (items2) => Column(
//                                                               children: [
//                                                                 Row(children: [
//                                                                   Text(
//                                                                       items2
//                                                                           .modeofTransport
//                                                                           .toString(),
//                                                                       style: const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight: FontWeight
//                                                                               .normal,
//                                                                           color:
//                                                                               MyColors.grey_95)),
//                                                                   const Spacer(),
//                                                                   IconButton(
//                                                                       onPressed:
//                                                                           () {
//                                                                         setState(
//                                                                             () {
//                                                                           schoolController
//                                                                               .goodsData!
//                                                                               .remove(items2);
//                                                                           schoolController
//                                                                               .car!
//                                                                               .add(items2.selectedVehicle!);
//                                                                         });
//                                                                       },
//                                                                       icon:
//                                                                           const Icon(
//                                                                         Icons
//                                                                             .delete,
//                                                                         color: Colors
//                                                                             .red,
//                                                                       ))
//                                                                 ]),
//                                                               ],
//                                                             ),
//                                                           )
//                                                           .toList(),
//                                                 )
//                                         ],
//                                       ),
//                                     )
//                                     .toList(),
//                               );
//                             }),
//                         Container(height: 10),
//                         _validateTransport
//                             ? const Text(
//                                 'Please select atleast one transport Mode',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.red))
//                             : const SizedBox(),
//                         _validateGoodsT
//                             ? const Text(
//                                 'Please select atleast one transport for Goods',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.red))
//                             : const SizedBox(),
//                         Container(height: 10),
//                         _validateStaffT
//                             ? const Text(
//                                 'Please select atleast one transport for Staff',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.red))
//                             : const SizedBox(),
//                         Container(height: 20),
//                         const Text('DA (Daily Allowance):',
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                                 color: MyColors.grey_95)),
//                         Container(height: 10),
//                         Container(
//                           height: 45,
//                           decoration: const BoxDecoration(
//                               color: Colors.white,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(4))),
//                           alignment: Alignment.centerLeft,
//                           padding: const EdgeInsets.symmetric(horizontal: 25),
//                           child: TextField(
//                             textInputAction: TextInputAction.next,
//                             onSubmitted: (value) {},
//                             maxLines: 1,
//                             controller: _daController,
//                             decoration: InputDecoration(
//                                 contentPadding: const EdgeInsets.all(-12),
//                                 border: InputBorder.none,
//                                 hintText: "DA",
//                                 hintStyle: MyText.body1(context)!
//                                     .copyWith(color: MyColors.grey_40)),
//                           ),
//                         ),
//                         _validateDA
//                             ? const Text('Please fill DA',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.red))
//                             : const SizedBox(),
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         SizedBox(
//                           width: double.infinity,
//                           height: 45,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 primary: const Color(0xFF8A2724), elevation: 0),
//                             child: Text("Create TourBudget",
//                                 style: MyText.subhead(context)!
//                                     .copyWith(color: Colors.white)),
//                             onPressed: () async {
//                               setState(() {
//                                 schoolController.teamleader != null
//                                     ? _validateLeader = false
//                                     : _validateLeader = true;
//                                 dropdownValue != null
//                                     ? _validatestate = false
//                                     : _validatestate = true;
//                                 dropdownValue1 != null
//                                     ? _validateDistrict = false
//                                     : _validateDistrict = true;

//                                 dropdownValue2 != null
//                                     ? _validateblock = false
//                                     : _validateblock = true;

//                                 _fromController.text.isNotEmpty
//                                     ? _validateFrom = false
//                                     : _validateFrom = true;

//                                 _toController.text.isNotEmpty
//                                     ? _validateTo = false
//                                     : _validateTo = true;

//                                 schoolController.staffData!.isNotEmpty
//                                     ? _validateStaff = false
//                                     : _validateStaff = true;

//                                 schoolController.schoolData!.isNotEmpty
//                                     ? _validateSchool = false
//                                     : _validateSchool = true;

//                                 schoolController
//                                         .selectedMainTransport.isNotEmpty
//                                     ? _validateTransport = false
//                                     : _validateTransport = true;

//                                 if (!_validateTransport) {
//                                   schoolController.goodsData!.isNotEmpty
//                                       ? _validateGoodsT = false
//                                       : _validateGoodsT = true;

//                                   schoolController.staffData!.isNotEmpty
//                                       ? _validateStaffT = false
//                                       : _validateStaffT = true;
//                                 }
//                                 _daController.text.isNotEmpty
//                                     ? _validateDA = false
//                                     : _validateDA = true;
//                               });

//                               if (!_validateLeader &&
//                                   !_validatestate &&
//                                   !_validateDistrict &&
//                                   !_validateblock &&
//                                   !_validateFrom &&
//                                   //  !_validatePaymentApprovedBy &&
//                                   !_validateTo &&
//                                   !_validateStaff &&
//                                   !_validateSchool &&
//                                   !_validateTransport &&
//                                   //  !_validateExpenseApprovedBy &&
//                                   !_validateStaffT &&
//                                   !_validateGoodsT &&
//                                   !_validateDA) {
//                                 isLoading.value = true;

//                                 for (int i = 0;
//                                     i < schoolController.schoolData!.length;
//                                     i++) {
//                                   List<String> programm = [];
//                                   for (int k = 0;
//                                       k <
//                                           schoolController
//                                               .schoolData![i].programme!.length;
//                                       k++) {
//                                     programm.add(schoolController
//                                         .schoolData![i].programme![k].program!);
//                                   }
//                                   var rsp = await insertTourData(
//                                       schoolController.teamleader!,
//                                       dropdownValue!,
//                                       dropdownValue1!,
//                                       dropdownValue2!,
//                                       programm,
//                                       schoolController.from.toString(),
//                                       schoolController.to.toString(),
//                                       schoolController
//                                           .schoolData![i].schoolName!,
//                                       schoolController
//                                           .schoolData![i].visitDate!,
//                                       schoolController.selectedStaff,
//                                       schoolController.selectedMainTransport,
//                                       schoolController.gmode,
//                                       schoolController.gvehicleNo,
//                                       schoolController.gSelectCar,
//                                       schoolController.goods,
//                                       schoolController.gdistance,
//                                       schoolController.gamount,
//                                       schoolController.smode,
//                                       schoolController.samount,
//                                       schoolController.svehicleNo,
//                                       schoolController.sdistance,
//                                       schoolController.sSelectCar,
//                                       schoolController.schoolData![i].activity!,
//                                       schoolController
//                                           .schoolData![i].distribution!,
//                                       schoolController.schoolData![i].setup!,
//                                       schoolController
//                                           .schoolData![i].collection!,
//                                       _daController.text,
//                                       '');
//                                   print(rsp);
//                                   if (rsp['status'].toString() == '1') {}
//                                   setState(() {
//                                     dropdownValue = null;
//                                     dropdownValue1 = null;
//                                     dropdownValue2 = null;
//                                     programm.clear();

//                                     _daController.clear();
//                                     schoolController.clearTour();

//                                     isLoading.value = false;
//                                     showDialog(
//                                         context: context,
//                                         builder: (_) =>
//                                             const CustomEventDialog());
//                                   });
//                                 }
//                               }
//                             },
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//           //  ),
//         ));
//   }
// }

// void displayPopup2(
//   BuildContext context,
//   String title,
// ) {
//   List<AddSchool> addSchools = [];
//   ProgrammeMaster valurrr = ProgrammeMaster(
//       programId: "6",
//       program: "other",
//       remarks: null,
//       createdAt: DateFormat('yyyy-MM-dd').parse("2022-03-19"),
//       updateAt: null);

//   showModalBottomSheet<void>(
//     context: context,
//     backgroundColor: Colors.white,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(24), topRight: Radius.circular(24)),
//     ),
//     builder: (BuildContext context) {
//       return GetBuilder<SchoolController>(builder: (schoolController) {
//         return LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints constraints) {
//             return SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minHeight: constraints.minHeight,
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                         child: SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Center(
//                               child: Text(
//                                 title,
//                                 textAlign: TextAlign.center,
//                                 style: const TextStyle(
//                                   color: Color(0xff353535),
//                                   fontSize: 18,
//                                   fontFamily: "Poppins",
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             const Text('School Name:',
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: MyColors.grey_95)),
//                             Container(height: 10),

//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                       color: Colors.white,
//                                       spreadRadius: 1,
//                                       blurRadius: 5)
//                                 ],
//                               ),
//                               child: Stack(children: [
//                                 DropdownButton<String>(
//                                   value: schoolController.schoolName,
//                                   iconSize: 14,
//                                   hint: Text(
//                                     'Select School'.tr,
//                                     style: const TextStyle(color: Colors.grey),
//                                   ),
//                                   items: schoolController.filterd.map((value) {
//                                     return DropdownMenuItem<String>(
//                                         value: value.schoolName.toString(),
//                                         child: Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Text(
//                                               value.schoolName.toString(),
//                                               style:
//                                                   const TextStyle(fontSize: 12),
//                                             )
//                                           ],
//                                         ));
//                                   }).toList(),
//                                   onChanged: (data) {
//                                     schoolController.setValue(data!);
//                                   },
//                                 ),
//                               ]),
//                             ),
//                             schoolController.validateName!
//                                 ? const Text(
//                                     'Please Select a School',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.red),
//                                   )
//                                 : const SizedBox(),

//                             Container(height: 10),
//                             const Text('Visit Date:',
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: MyColors.grey_95)),
//                             Container(height: 10),
//                             Container(
//                               height: 45,
//                               decoration: const BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(4))),
//                               alignment: Alignment.centerLeft,
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: Row(
//                                 children: <Widget>[
//                                   Container(width: 15),
//                                   Expanded(
//                                     child: TextField(
//                                       onTap: () {
//                                         schoolController.selectDate(
//                                             context,
//                                             schoolController
//                                                 .visitDataController);
//                                       },
//                                       readOnly: true,
//                                       onChanged: (value) {},
//                                       maxLines: 1,
//                                       style: MyText.body2(context)!
//                                           .copyWith(color: MyColors.grey_40),
//                                       keyboardType: TextInputType.datetime,
//                                       controller:
//                                           schoolController.visitDataController,
//                                       decoration: InputDecoration(
//                                           contentPadding:
//                                               const EdgeInsets.all(-12),
//                                           border: InputBorder.none,
//                                           hintText: "Visit Date(dd-mm-yyyy)",
//                                           hintStyle: MyText.body1(context)!
//                                               .copyWith(
//                                                   color: MyColors.grey_40)),
//                                     ),
//                                   ),
//                                   IconButton(
//                                       onPressed: () {
//                                         schoolController.selectDate(
//                                             context,
//                                             schoolController
//                                                 .visitDataController);
//                                       },
//                                       icon: const Icon(Icons.calendar_today,
//                                           color: MyColors.grey_40))
//                                 ],
//                               ),
//                             ),
//                             schoolController.validateDate!
//                                 ? const Text(
//                                     'Please Select a Date',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.red),
//                                   )
//                                 : const SizedBox(),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               children: [
//                                 const Text('Select Programme',
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                         color: MyColors.grey_95)),
//                                 IconButton(
//                                     onPressed: () {
//                                       schoolController.selectProgram(context);
//                                     },
//                                     icon: const Icon(
//                                       Icons.add,
//                                       color: Color(0xFF8A2724),
//                                     ))
//                               ],
//                             ),
//                             ListBody(
//                               children: schoolController.selectedProgramme
//                                   .map((items2) => Row(
//                                         children: [
//                                           Text(
//                                             items2.program!,
//                                             style: const TextStyle(
//                                               color: Color(0xFF8A2724),
//                                             ),
//                                           ),
//                                         ],
//                                       ))
//                                   .toList(),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             schoolController.validateProgramme!
//                                 ? const Text(
//                                     'Please Select atleast one Programme',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.red),
//                                   )
//                                 : const SizedBox(),
//                             Container(height: 10),
//                             schoolController.checkOther('other')
//                                 ? const Text('Other:',
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold,
//                                         color: MyColors.grey_95))
//                                 : const SizedBox(),
//                             Container(height: 10),
//                             schoolController.checkOther('other')
//                                 ? Container(
//                                     height: 45,
//                                     decoration: const BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(4))),
//                                     alignment: Alignment.centerLeft,
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 25),
//                                     child: TextField(
//                                       textInputAction: TextInputAction.next,
//                                       onSubmitted: (value) {},
//                                       maxLines: 1,
//                                       controller: schoolController.vehicle,
//                                       decoration: InputDecoration(
//                                           contentPadding:
//                                               const EdgeInsets.all(-12),
//                                           border: InputBorder.none,
//                                           hintText:
//                                               "Enter Programme Details".tr,
//                                           hintStyle: MyText.body1(context)!
//                                               .copyWith(
//                                                   color: MyColors.grey_40)),
//                                     ),
//                                   )
//                                 : const SizedBox(),
//                             // schoolController.checkOther('other')
//                             //     ? const Text('Please enter a Vehicle No.',
//                             //         style: TextStyle(
//                             //             fontSize: 12,
//                             //             fontWeight: FontWeight.bold,
//                             //             color: Colors.red))
//                             //     : const SizedBox(),

//                             Row(
//                               children: [
//                                 const Text('Select Activity',
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                         color: MyColors.grey_95)),
//                                 IconButton(
//                                     onPressed: () {
//                                       schoolController.selectActivity(context);
//                                     },
//                                     icon: const Icon(
//                                       Icons.add,
//                                       color: Color(0xFF8A2724),
//                                     ))
//                               ],
//                             ),
//                             ListBody(
//                               children: schoolController.selectedActivity
//                                   .map((items2) => Row(
//                                         children: [
//                                           Text(
//                                             items2,
//                                             style: const TextStyle(
//                                               color: Color(0xFF8A2724),
//                                             ),
//                                           ),
//                                         ],
//                                       ))
//                                   .toList(),
//                             ),
//                             schoolController.validateActivity!
//                                 ? const Text(
//                                     'Please Select atleast one Activity',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.red),
//                                   )
//                                 : const SizedBox(),
//                             Container(height: 20),

//                             schoolController.selectedActivity
//                                     .contains('Distribution')
//                                 ? Row(
//                                     children: [
//                                       const Text('Select Distribution',
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                               color: MyColors.grey_95)),
//                                       IconButton(
//                                           onPressed: () {
//                                             schoolController
//                                                 .selectDistribution(context);
//                                           },
//                                           icon: const Icon(
//                                             Icons.add,
//                                             color: Color(0xFF8A2724),
//                                           ))
//                                     ],
//                                   )
//                                 : const SizedBox(),
//                             ListBody(
//                               children: schoolController.selectedDistribution
//                                   .map((items2) => Row(
//                                         children: [
//                                           Text(
//                                             items2,
//                                             style: const TextStyle(
//                                               color: Color(0xFF8A2724),
//                                             ),
//                                           ),
//                                         ],
//                                       ))
//                                   .toList(),
//                             ),
//                             schoolController.selectedActivity
//                                         .contains('Distribution') &&
//                                     schoolController.validateActivity!
//                                 ? const Text(
//                                     'Please Select atleast one Activity',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.red),
//                                   )
//                                 : const SizedBox(),

//                             Container(height: 10),
//                             schoolController.selectedActivity.contains('Setup')
//                                 ? Row(
//                                     children: [
//                                       const Text('Setup',
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                               color: MyColors.grey_95)),
//                                       IconButton(
//                                           onPressed: () {
//                                             schoolController
//                                                 .selectSetup(context);
//                                           },
//                                           icon: const Icon(
//                                             Icons.add,
//                                             color: Color(0xFF8A2724),
//                                           ))
//                                     ],
//                                   )
//                                 : const SizedBox(),
//                             ListBody(
//                               children: schoolController.selectedSetup
//                                   .map((items2) => Row(
//                                         children: [
//                                           Text(
//                                             items2,
//                                             style: const TextStyle(
//                                               color: Color(0xFF8A2724),
//                                             ),
//                                           ),
//                                         ],
//                                       ))
//                                   .toList(),
//                             ),
//                             schoolController.selectedActivity
//                                         .contains('Setup') &&
//                                     schoolController.validateSetup!
//                                 ? const Text(
//                                     'Please Select atleast one Setup',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.red),
//                                   )
//                                 : const SizedBox(),
//                             // _validateProgram
//                             //     ? const Text('Please select a programme',
//                             //         style: TextStyle(
//                             //             fontSize: 12,
//                             //             fontWeight: FontWeight.bold,
//                             //             color: Colors.red))
//                             //     : const SizedBox(),
//                             Container(height: 10),
//                             schoolController.selectedActivity
//                                     .contains('Data Collection')
//                                 ? Row(
//                                     children: [
//                                       const Text('Collection',
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                               color: MyColors.grey_95)),
//                                       IconButton(
//                                           onPressed: () {
//                                             schoolController
//                                                 .selectCollection(context);
//                                           },
//                                           icon: const Icon(
//                                             Icons.add,
//                                             color: Color(0xFF8A2724),
//                                           ))
//                                     ],
//                                   )
//                                 : const SizedBox(),
//                             ListBody(
//                               children: schoolController.selectedCollection
//                                   .map((items2) => Row(
//                                         children: [
//                                           Text(
//                                             items2,
//                                             style: const TextStyle(
//                                               color: Color(0xFF8A2724),
//                                             ),
//                                           ),
//                                         ],
//                                       ))
//                                   .toList(),
//                             ),
//                             schoolController.selectedActivity
//                                         .contains('Data Collection') &&
//                                     schoolController.validateActivity!
//                                 ? const Text(
//                                     'Please Select atleast one Collection',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.red),
//                                   )
//                                 : const SizedBox(),
//                             Container(height: 10),

//                             SizedBox(
//                               width: double.infinity,
//                               height: 45,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     primary: const Color(0xFF8A2724),
//                                     elevation: 0),
//                                 child: Text("Add School",
//                                     style: MyText.subhead(context)!
//                                         .copyWith(color: Colors.white)),
//                                 onPressed: () async {
//                                   AddSchool data = AddSchool(
//                                       schoolName: schoolController.schoolName,
//                                       visitDate: schoolController
//                                           .visitDataController.text,
//                                       collection:
//                                           schoolController.selectedCollection,
//                                       programme:
//                                           schoolController.selectedProgramme,
//                                       activity:
//                                           schoolController.selectedActivity,
//                                       distribution:
//                                           schoolController.selectedDistribution,
//                                       setup: schoolController.selectedSetup);
//                                   addSchools.add(data);
//                                   schoolController.validateSchool();

//                                   if (!schoolController.validateName! &&
//                                       !schoolController.validateDate! &&
//                                       !schoolController.validateProgramme! &&
//                                       !schoolController.validateActivity! &&
//                                       !schoolController.validateDistribution! &&
//                                       !schoolController.validateSetup! &&
//                                       !schoolController.validateCollection!) {
//                                     print('testinomial(@Afjal@)');

//                                     schoolController.addSchoolData(
//                                       addSchools,
//                                     );
//                                     Navigator.of(context).pop();

//                                     schoolController.distribution!.clear();
//                                     schoolController.schoolName1 = "";
//                                     schoolController.clearData();
//                                   }
//                                 },
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                           ],
//                         ),
//                       ),
//                     ))
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       });
//       // );
//     },
//   );
// }

// //programme name ->  Setup and Distribution

// class MultiSelect extends StatefulWidget {
//   final List<SchoolData>? items;
//   final String? title;
//   final List<Datum>? items2;
//   final List<ProgrammeMaster>? programme;
//   final List<String>? activity;
//   final List<String>? collection;
//   final List<ProgrammeMaster>? setup;
//   final List<String>? officeCar;
//   final List<String>? items4;
//   final List<String>? mode;
//   final List<String>? goods;
//   final List<Data1>? distribution;

//   const MultiSelect(
//       {Key? key,
//       this.items,
//       this.items2,
//       this.programme,
//       this.title,
//       this.items4,
//       this.mode,
//       this.goods,
//       this.activity,
//       this.collection,
//       this.setup,
//       this.officeCar,
//       this.distribution})
//       : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _MultiSelectState();
// }

// class _MultiSelectState extends State<MultiSelect> {
//   // this variable holds the selected items
//   final List<String> _selectedItems = [];

// // This function is triggered when a checkbox is checked or unchecked
//   void _itemChange(String itemValue, bool isSelected) {
//     setState(() {
//       if (isSelected) {
//         if (!schoolController.selectedStaff.contains(itemValue)) {
//           _selectedItems.add(itemValue);
//         }
//       } else {
//         _selectedItems.remove(itemValue);
//       }
//     });
//   }

//   String? help;

//   // this function is called when the Cancel button is pressed
//   void _cancel() {
//     Navigator.pop(context);
//   }

// // this function is called when the Submit button is tapped
//   void _submit() {
//     setState(() {
//       Navigator.pop(context, _selectedItems);
//     });
//   }

//   // var value = true;
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(widget.title!),
//       content: GetBuilder<SchoolController>(
//           init: SchoolController(),
//           builder: (schoolController) {
//             return SingleChildScrollView(
//                 child: widget.distribution == null
//                     ? widget.officeCar == null
//                         ? widget.goods == null
//                             ? widget.collection == null
//                                 ? widget.setup == null
//                                     ? widget.activity == null
//                                         ? widget.items4 == null
//                                             ? widget.programme == null
//                                                 ? widget.items == null
//                                                     ? ListBody(
//                                                         children: widget.items2!
//                                                             .map((items2) {
//                                                           return Column(
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             mainAxisSize:
//                                                                 MainAxisSize
//                                                                     .min,
//                                                             children: [
//                                                               CheckboxListTile(
//                                                                   subtitle: Text(items2
//                                                                       .location!),
//                                                                   activeColor:
//                                                                       const Color(
//                                                                           0xFF8A2724),
//                                                                   value: widget.title == 'Issue Resolved By'
//                                                                       ? issueTracker.resolvedBy.contains(items2.firstName! +
//                                                                           " " +
//                                                                           items2
//                                                                               .lastName!)
//                                                                       : schoolController.selectedStaff.contains(items2.firstName! +
//                                                                           " " +
//                                                                           items2
//                                                                               .lastName!),
//                                                                   title: Text(
//                                                                       items2.firstName! +
//                                                                           " " +
//                                                                           items2
//                                                                               .lastName!),
//                                                                   controlAffinity:
//                                                                       ListTileControlAffinity
//                                                                           .leading,
//                                                                   onChanged:
//                                                                       (isChecked) =>
//                                                                           setState(
//                                                                               () {
//                                                                             // _itemChange(
//                                                                             //     items2.firstName! +
//                                                                             //         " " +
//                                                                             //         items2.lastName!,
//                                                                             //     isChecked!);

//                                                                             if (widget.title ==
//                                                                                 'Issue Resolved By') {
//                                                                               issueTracker.checkStaff(
//                                                                                 items2.firstName! + " " + items2.lastName!,
//                                                                               );
//                                                                             } else {
//                                                                               schoolController.checkStaff(
//                                                                                 items2.firstName! + " " + items2.lastName!,
//                                                                               );
//                                                                             }
//                                                                           })),
//                                                             ],
//                                                           );
//                                                         }).toList(),
//                                                       )
//                                                     : ListBody(
//                                                         children: widget.items!
//                                                             .map((item) =>
//                                                                 CheckboxListTile(
//                                                                     activeColor:
//                                                                         const Color(
//                                                                             0xFF8A2724),
//                                                                     value: _selectedItems
//                                                                         .contains(item
//                                                                             .schoolName!),
//                                                                     title: Text(item
//                                                                         .schoolName!),
//                                                                     controlAffinity:
//                                                                         ListTileControlAffinity
//                                                                             .leading,
//                                                                     onChanged: (isChecked) =>
//                                                                         setState(
//                                                                             () {
//                                                                           // _itemChange(item.schoolName!,
//                                                                           //     isChecked!);
//                                                                         })))
//                                                             .toList(),
//                                                       )
//                                                 : ListBody(
//                                                     children: widget.programme!
//                                                         .map((item) =>
//                                                             CheckboxListTile(
//                                                                 activeColor:
//                                                                     const Color(
//                                                                         0xFF8A2724),
//                                                                 value: schoolController
//                                                                     .selectedProgramme
//                                                                     .contains(
//                                                                         item),
//                                                                 title: Text(item
//                                                                     .program!),
//                                                                 controlAffinity:
//                                                                     ListTileControlAffinity
//                                                                         .leading,
//                                                                 onChanged:
//                                                                     (isChecked) =>
//                                                                         setState(
//                                                                             () {
//                                                                           if (item.program ==
//                                                                               'other') {
//                                                                             showDialog(
//                                                                               context: context,
//                                                                               builder: (context) => AlertDialog(
//                                                                                 actions: [
//                                                                                   FlatButton(
//                                                                                     child: const Text('Cancel'),
//                                                                                     onPressed: () => Navigator.pop(context),
//                                                                                   ),
//                                                                                   FlatButton(
//                                                                                     child: const Text('Submit'),
//                                                                                     onPressed: () {
//                                                                                       setState(() {
//                                                                                         ProgrammeMaster valurrr = ProgrammeMaster(programId: "34", program: schoolController.otherProgramController.text, remarks: null, createdAt: DateTime.now(), updateAt: null);

//                                                                                         schoolController.checkProgramme(valurrr);
//                                                                                       });

//                                                                                       Navigator.pop(context);
//                                                                                     },
//                                                                                   ),
//                                                                                 ],
//                                                                                 title: const Text('Other'),
//                                                                                 content: TextField(
//                                                                                   controller: schoolController.otherProgramController,
//                                                                                   onChanged: (value) {
//                                                                                     // setState(() {
//                                                                                     //   ProgrammeMaster valurrr = ProgrammeMaster(programId: "6", program: value, remarks: null, createdAt: DateFormat('yyyy-MM-dd').parse("2022-03-19"), updateAt: null);

//                                                                                     //   schoolController.checkProgramme(valurrr);
//                                                                                     // });
//                                                                                   },
//                                                                                 ),
//                                                                               ),
//                                                                             );
//                                                                           } else {
//                                                                             schoolController.checkProgramme(item);
//                                                                           } //   _itemChange(item, isChecked!);
//                                                                         })))
//                                                         .toList(),
//                                                   )
//                                             : ListBody(
//                                                 children: widget.items4!
//                                                     .map((item4) =>
//                                                         CheckboxListTile(
//                                                             activeColor:
//                                                                 const Color(
//                                                                     0xFF8A2724),
//                                                             value: schoolController
//                                                                 .selectedMainTransport
//                                                                 .contains(
//                                                                     item4),
//                                                             title: Text(item4),
//                                                             controlAffinity:
//                                                                 ListTileControlAffinity
//                                                                     .leading,
//                                                             onChanged:
//                                                                 (isChecked) =>
//                                                                     setState(
//                                                                         () {
//                                                                       schoolController
//                                                                           .checkMainTransport(
//                                                                               item4);
//                                                                     })))
//                                                     .toList(),
//                                               )
//                                         // : ListBody(
//                                         //     children: widget.mode!
//                                         //         .map((item) =>
//                                         //             CheckboxListTile(
//                                         //                 activeColor:
//                                         //                     const Color(
//                                         //                         0xFF8A2724),
//                                         //                 value: schoolController
//                                         //                     .selectedVehicle
//                                         //                     .contains(item),
//                                         //                 title: Text(item),
//                                         //                 controlAffinity:
//                                         //                     ListTileControlAffinity
//                                         //                         .leading,
//                                         //                 onChanged:
//                                         //                     (isChecked) =>
//                                         //                         setState(
//                                         //                             () {
//                                         //                           schoolController
//                                         //                               .checkTransport(
//                                         //                                   item);
//                                         //                         })))
//                                         //         .toList(),
//                                         //   )
//                                         : ListBody(
//                                             children: widget.activity!
//                                                 .map((item) => CheckboxListTile(
//                                                     activeColor:
//                                                         const Color(0xFF8A2724),
//                                                     value: schoolController
//                                                         .selectedActivity
//                                                         .contains(item),
//                                                     title: Text(item),
//                                                     controlAffinity:
//                                                         ListTileControlAffinity
//                                                             .leading,
//                                                     onChanged: (isChecked) =>
//                                                         setState(() {
//                                                           schoolController
//                                                               .checkActivity(
//                                                                   item);
//                                                         })))
//                                                 .toList(),
//                                           )
//                                     : ListBody(
//                                         children: widget.setup!
//                                             .map((item) => CheckboxListTile(
//                                                 activeColor:
//                                                     const Color(0xFF8A2724),
//                                                 // ignore: iterable_contains_unrelated_type
//                                                 value: schoolController
//                                                     .selectedSetup
//                                                     .toList()
//                                                     .contains(item.program),
//                                                 title: Text(item.program!),
//                                                 controlAffinity:
//                                                     ListTileControlAffinity
//                                                         .leading,
//                                                 onChanged: (isChecked) =>
//                                                     setState(() {
//                                                       schoolController
//                                                           .checkSetup(
//                                                               item.program!);
//                                                       //   _itemChange(item, isChecked!);
//                                                     })))
//                                             .toList(),
//                                       )
//                                 : ListBody(
//                                     children: widget.collection!
//                                         .map((item) => CheckboxListTile(
//                                             activeColor:
//                                                 const Color(0xFF8A2724),
//                                             value: schoolController
//                                                 .selectedCollection
//                                                 .contains(item),
//                                             title: Text(item),
//                                             controlAffinity:
//                                                 ListTileControlAffinity.leading,
//                                             onChanged: (isChecked) =>
//                                                 setState(() {
//                                                   schoolController
//                                                       .checkCollection(item);
//                                                   //   _itemChange(item, isChecked!);
//                                                 })))
//                                         .toList(),
//                                   )
//                             : ListBody(
//                                 children: widget.goods!
//                                     .map((item) => CheckboxListTile(
//                                         activeColor: const Color(0xFF8A2724),
//                                         value: schoolController.selectedGoods
//                                             .contains(item),
//                                         title: Text(item),
//                                         controlAffinity:
//                                             ListTileControlAffinity.leading,
//                                         onChanged: (isChecked) => setState(() {
//                                               schoolController.checkGoods(item);
//                                               //   _itemChange(item, isChecked!);
//                                             })))
//                                     .toList(),
//                               )
//                         : ListBody(
//                             children: widget.officeCar!
//                                 .map((item) => CheckboxListTile(
//                                     activeColor: const Color(0xFF8A2724),
//                                     value: schoolController.selectedSCar
//                                         .contains(item),
//                                     title: Text(item),
//                                     controlAffinity:
//                                         ListTileControlAffinity.leading,
//                                     onChanged: (isChecked) => setState(() {
//                                           schoolController.checkVehicle(item);
//                                           //   _itemChange(item, isChecked!);
//                                         })))
//                                 .toList(),
//                           )
//                     : ListBody(
//                         children: widget.distribution!
//                             .map((item) => CheckboxListTile(
//                                 activeColor: const Color(0xFF8A2724),
//                                 value: schoolController.selectedDistribution
//                                     .contains(item.itemName!),
//                                 title: Text(item.itemName!),
//                                 controlAffinity:
//                                     ListTileControlAffinity.leading,
//                                 onChanged: (isChecked) => setState(() {
//                                       schoolController
//                                           .checkDistribution(item.itemName!);
//                                       //   _itemChange(item, isChecked!);
//                                     })))
//                             .toList(),
//                       ));
//           }),
//       actions: [
//         TextButton(
//           child: const Text(
//             'Cancel',
//             style: TextStyle(
//               color: Color(0xFF8A2724),
//             ),
//           ),
//           onPressed: _cancel,
//         ),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             primary: const Color(0xFF8A2724),
//           ),
//           child: const Text('Submit'),
//           onPressed: _submit,
//         ),
//       ],
//     );
//   }
// }

// Future insertTourData(
//   String tour_leader,
//   String state_name,
//   String dist_name,
//   String block_name,
//   List<String> program_name,
//   String datefrom,
//   String dateto,
//   String school_name,
//   String vist_date,
//   List<String> vist_staff,
//   List<String> tb_transport,
//   List<String> gmode_transport,
//   List<String> gvehicle_no,
//   List<String> gofficeCar,
//   List<String> type_goods,
//   List<String> goods_transport_km,
//   List<String> goods_transport_amount,
//   List<String> smode_transport,
//   List<String> staff_transport_amount,
//   List<String> svehicle_no,
//   List<String> staff_transport_km,
//   List<String> sofficeCar,
//   List<String> activity,
//   List<String> distribution,
//   List<String> program_setup,
//   List<String> data_collection,
//   String daily_allowance,
//   String vehicle_no,
// ) async {
//   print(tour_leader);
//   print(state_name);
//   print(dist_name);
//   print(block_name);
//   print(program_name);
//   print(datefrom);
//   print(dateto);
//   print(school_name);
//   print(vist_date);
//   print(vist_staff);
//   print(tb_transport);
//   print(gmode_transport);
//   print(gvehicle_no);
//   print(gofficeCar);
//   print(type_goods);
//   print(goods_transport_km);
//   print(goods_transport_amount);
//   print(smode_transport);
//   print(staff_transport_amount);
//   print(svehicle_no);
//   print(staff_transport_km);
//   print(sofficeCar);
//   print(activity);
//   print(distribution);
//   print(program_setup);
//   print(data_collection);
//   print(daily_allowance);

//   print(vehicle_no);

//   var response =
//       await http.post(Uri.parse(MyColors.baseUrl + 'tour_budget'), headers: {
//     "Accept": "Application/json"
//   }, body: {
//     "tour_leader_name":
//         tour_leader.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//     "state_name":
//         state_name.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//     "dist_name":
//         dist_name.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//     "block_name":
//         block_name.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//     "program_name":
//         program_name.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//     "datefrom":
//         datefrom.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//     "dateto": dateto.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//     "school_name":
//         school_name.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//     "vist_date":
//         vist_date.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//     "vist_staff":
//         vist_staff.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//     "tb_transport":
//         tb_transport.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//     "gmode_transport": gmode_transport
//         .toString()
//         .replaceAll('[', '')
//         .replaceAll(']', ' replace'),
//     "gvehicel_no":
//         gvehicle_no.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//     "gvehicle_drop":
//         gofficeCar.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//     "type_goods":
//         type_goods.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//     "goods_transport_km": goods_transport_km
//         .toString()
//         .replaceAll('[', '')
//         .replaceAll(']', ' replace'),
//     "goods_transport_amount": goods_transport_amount
//         .toString()
//         .replaceAll('[', '')
//         .replaceAll(']', ' replace'),
//     "smode_transport": smode_transport
//         .toString()
//         .replaceAll('[', '')
//         .replaceAll(']', ' replace'),
//     "svehicel_no":
//         svehicle_no.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//     "staff_transport_km": staff_transport_km
//         .toString()
//         .replaceAll('[', '')
//         .replaceAll(']', ' replace'),
//     "staff_transport_amount": staff_transport_amount
//         .toString()
//         .replaceAll('[', '')
//         .replaceAll(']', ' replace'),
//     "svehicle_drop":
//         sofficeCar.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//     "activity":
//         activity.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//     "distribution":
//         distribution.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//     "program_setup": program_setup
//         .toString()
//         .replaceAll('[', '')
//         .replaceAll(']', ' replace'),
//     "data_collection": data_collection
//         .toString()
//         .replaceAll('[', '')
//         .replaceAll(']', ' replace'),
//     "daily_allowance": daily_allowance
//         .toString()
//         .replaceAll('[', '')
//         .replaceAll(']', ' replace'),
//     "tour_id": ''.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//     "vehicle_no":
//         vehicle_no.toString().replaceAll('[', '').replaceAll(']', ' replace'),
//   });
//   var convertedDatatoJson = jsonDecode(response.body);
//   return convertedDatatoJson;
// }
