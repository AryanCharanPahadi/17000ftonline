// ignore_for_file: unused_field, override_on_non_overriding_member

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:old17000ft/Controllers/newda_controller.dart';
import 'package:old17000ft/Controllers/school_Controller.dart';
import 'package:old17000ft/Model/blockModel.dart';
import 'package:old17000ft/Model/tour.dart';
import 'package:old17000ft/custom_dialog.dart';
import '../colors.dart';
import '../home_screen.dart';
import '../my_text.dart';

ThemeData theme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF8A2724),
    onPrimary: Colors.white, // header text color
    onSurface: Colors.black, // body text color
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF8A2724), // button text color
    ),
  ),
);

class DaForm extends StatefulWidget {
  const DaForm({Key? key}) : super(key: key);

  @override
  State<DaForm> createState() => _DaFormState();
}

class _DaFormState extends State<DaForm> {
  //textEditing Controllers

  // final TextEditingController _fromController = TextEditingController();
  // final TextEditingController _toController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _naFromController = TextEditingController();
  final TextEditingController _naToController = TextEditingController();
  final TextEditingController _naDaysController = TextEditingController();
  final TextEditingController _naNightController = TextEditingController();

  // final TextEditingController _daController = TextEditingController();
  final TextEditingController _nightController = TextEditingController();
  final TextEditingController _visitController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final NewDaController _daController = Get.put(NewDaController());
  final SchoolController _schoolController = Get.put(SchoolController());

  @override
  // String? tourValue;
  String? days;
  String? da;
  double? myda;
  String? stateValue;
  String? blockValue;
  String? districtValue;
  String? tourValue;

  // double? _grandDA = 0.0;kii
  // List<int>? _grandDalist = [];

  List<TourId>? _minetour = [];
  List<TourId>? get minetour => _minetour;

//validateion variables
  final bool _validateFrom = false;
  final bool _validateTo = false;
  final bool _validateStaff = false;
  final bool _validateTour = false;
  bool _validatestate = false; //basic
  bool _validateblock = false; //basic
  bool _validateDistrict = false; //basic
  bool _validateNaDays = false; //basic
  bool _validateNaNights = false; //basic
  bool _validateNaFrom = false; //basic
  bool _validateNaTo = false; //basic
  bool _validateNaDa = false; //basic
  bool _validateVisit = false; //basic
  bool _validatePurpose = false; //basic
  final bool _validateDA = false;
  final bool _validateDays = false;
  bool _validateNoNights = false; //baisc
  final bool _validateDaNoNights = false;
  final bool _validateDaNights = false;
  final bool _validateTotalAllowance = false;

  var isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    schoolController.filterList(GetStorage().read('office'));
    var seen = <String>{};
    List<StateInfo> uniqueState = [];
    List<StateInfo> uniqueDistrict = [];
    List<StateInfo> uniqueBlock = [];
    // bool _validatestate = false;
    // bool _validateDistrict = false;
    // bool _validateblock = false;

    uniqueState = stateInfoController.stateInfo
        .where((student) => seen.add(student.stateName!))
        .toList();

    if (stateValue != null) {
      uniqueDistrict = stateInfoController.stateInfo
          .where((student) => student.stateName == stateValue)
          .toList();
      uniqueDistrict = uniqueDistrict
          .where((student) => seen.add(student.districtName!))
          .toList();
    }

    if (districtValue != null) {
      uniqueBlock = stateInfoController.stateInfo
          .where((student) => student.districtName == districtValue)
          .toList();
      // uniqueBlock =
      //     uniqueBlock.where((student) => seen.add(student.blockName!)).toList();
    }

    return Obx(() => isLoading.value
            ? Stack(
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
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  MyColors.primary),
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
              )
            : Scaffold(
                appBar: AppBar(
                  iconTheme: const IconThemeData(color: Colors.white),
                  backgroundColor: const Color(0xFF8A2724),
                  title: const Text(
                    'Daily Allowance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Tour ID:',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: MyColors.grey_95)),
                        const SizedBox(
                          height: 15,
                        ),

                        Container(
                          height: 45,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: InkWell(
                            splashColor: Colors.grey,
                            child: DropdownButton<String>(
                              value: _daController.tourValue,
                              iconSize: 24,
                              elevation: 2,
                              hint: Text(
                                'Select Tour Id'.tr,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              // ignore: can_be_null_after_null_aware
                              items:
                                  schoolController.schoolTourList!.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value.tourId.toString(),
                                  child: Text(value.tourId.toString()),
                                );
                              }).toList(),
                              onChanged: (data) {
                                setState(() {
                                  print('this is my tour value $data');
                                  tourValue = data;
                                  _daController.setTourValue(data!);
                                  // if (_daController.tourValue == 'NA') {
                                  //   setState(() {
                                  _minetour = schoolController.mytour(
                                      _daController.tourValue.toString());

                                  _daController.daNaFromController.text =
                                      _minetour![0].datefrom.toString();
                                  _daController.daNaToController.text =
                                      _minetour![0].dateto.toString();
                                  print('this is my tourvale value $tourValue');
                                  print(
                                      "minetouur value${_minetour![0].datefrom}");
                                  // });

                                  // }
                                  _daController.daNaDaysController.clear();
                                  _daController.daList.clear();
                                  if (_daController.tourValue != 'NA') {
                                    _validatestate = false;
                                    _validateDistrict = false;
                                    _validateblock = false;
                                    _validateNaNights = false;
                                    _validateNaDays = false;
                                    _validateNoNights = false;
                                    _validatePurpose = false;
                                    _validateVisit = false;
                                    _validateNaDa = false;
                                  }
                                });
                              },
                            ),
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                          ),
                        ),
                        //   },
                        // ),
                        _validateTour
                            ? const Text('* Please Select Tour ID',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red))
                            : const SizedBox(),
                        const Text('From:',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: MyColors.grey_95)),
                        Container(height: 10),
                        _daController.tourValue == 'NA'
                            ? Container(
                                height: 45,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: <Widget>[
                                    Container(width: 15),
                                    Expanded(
                                      child: TextField(
                                        onTap: () {
                                          _daController.selectDate(
                                              context,
                                              _daController.daNaFromController,
                                              'from');
                                        },
                                        readOnly: true,
                                        onChanged: (value) {},
                                        maxLines: 1,
                                        style: MyText.body2(context)!
                                            .copyWith(color: MyColors.grey_40),
                                        keyboardType: TextInputType.datetime,
                                        //controller: _fromController,
                                        controller:
                                            _daController.daNaFromController,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(-12),
                                            border: InputBorder.none,
                                            hintText:
                                                "Starting Date(yyyy-mm-dd)",
                                            hintStyle: MyText.body1(context)!
                                                .copyWith(
                                                    color: MyColors.grey_40)),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          _daController.selectDate(
                                              context,
                                              _daController.daNaFromController,
                                              'from');
                                        },
                                        icon: const Icon(Icons.calendar_today,
                                            color: MyColors.grey_40))
                                  ],
                                ),
                              )
                            : Container(
                                height: 45,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: <Widget>[
                                    Container(width: 15),
                                    Expanded(
                                      child: TextField(
                                        onTap: () {
                                          // _daController.selectDate(context,
                                          //     _daController.daNaFromController, 'from');
                                        },
                                        readOnly: true,
                                        onChanged: (value) {},
                                        maxLines: 1,
                                        style: MyText.body2(context)!
                                            .copyWith(color: MyColors.grey_40),
                                        keyboardType: TextInputType.datetime,
                                        //controller: _fromController,
                                        controller:
                                            _daController.daNaFromController,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(-12),
                                            border: InputBorder.none,
                                            hintText:
                                                "Starting Date(yyyy-mm-dd)",
                                            hintStyle: MyText.body1(context)!
                                                .copyWith(
                                                    color: MyColors.grey_40)),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          //   _daController.selectDate(context,
                                          //       _daController.daNaFromController, 'from');
                                        },
                                        icon: const Icon(Icons.calendar_today,
                                            color: MyColors.grey_40))
                                  ],
                                ),
                              ),

                        _validateFrom
                            ? const Text('Please select a date',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red))
                            : const SizedBox(),

                        const Text('To:',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: MyColors.grey_95)),

                        _daController.tourValue == 'NA'
                            ? Container(height: 10)
                            : const SizedBox(),
                        _daController.tourValue == 'NA'
                            ? Container(
                                height: 45,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: <Widget>[
                                    Container(width: 15),
                                    Expanded(
                                      child: TextField(
                                        onTap: () async {
                                          await _daController.selectDate(
                                              context,
                                              _daController.daNaToController,
                                              'to');
                                        },
                                        readOnly: true,
                                        onChanged: (value) {},
                                        maxLines: 1,
                                        style: MyText.body2(context)!
                                            .copyWith(color: MyColors.grey_40),
                                        keyboardType: TextInputType.datetime,
                                        controller:
                                            _daController.daNaToController,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(-12),
                                            border: InputBorder.none,
                                            hintText: "Ending Date(yyyy-mm-dd)",
                                            hintStyle: MyText.body1(context)!
                                                .copyWith(
                                                    color: MyColors.grey_40)),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          await _daController.selectDate(
                                              context,
                                              _daController.daNaToController,
                                              'to');
                                          final birthday =
                                              DateFormat('yyyy-MM-dd').parse(
                                                  _daController
                                                      .daNaToController.text);
                                          final date2 = DateFormat('yyyy-MM-dd')
                                              .parse(_daController
                                                  .daNaFromController.text);
                                          final difference =
                                              birthday.difference(date2).inDays;

                                          _daController
                                                  .daNaDaysController.text =
                                              (difference + 1).toString();
                                        },
                                        icon: const Icon(Icons.calendar_today,
                                            color: MyColors.grey_40))
                                  ],
                                ),
                              )
                            : Container(
                                height: 45,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: <Widget>[
                                    Container(width: 15),
                                    Expanded(
                                      child: TextField(
                                        onTap: () async {
                                          // await _daController.selectDate(context,
                                          //     _daController.daNaToController, 'to');
                                        },
                                        readOnly: true,
                                        onChanged: (value) {},
                                        maxLines: 1,
                                        style: MyText.body2(context)!
                                            .copyWith(color: MyColors.grey_40),
                                        keyboardType: TextInputType.datetime,
                                        controller:
                                            _daController.daNaToController,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(-12),
                                            border: InputBorder.none,
                                            hintText: "Ending Date(yyyy-mm-dd)",
                                            hintStyle: MyText.body1(context)!
                                                .copyWith(
                                                    color: MyColors.grey_40)),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          // await _daController.selectDate(context,
                                          //     _daController.daNaToController, 'to');
                                          // final birthday = DateFormat('yyyy-MM-dd')
                                          //     .parse(_daController.daNaToController.text);
                                          // final date2 = DateFormat('yyyy-MM-dd').parse(
                                          //     _daController.daNaFromController.text);
                                          // final difference =
                                          //     birthday.difference(date2).inDays;

                                          // _daController.daNaDaysController.text =
                                          //     (difference + 1).toString();
                                        },
                                        icon: const Icon(Icons.calendar_today,
                                            color: MyColors.grey_40))
                                  ],
                                ),
                              ),
                        _validateTo
                            ? const Text('Please select a date',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red))
                            : const SizedBox(),
                        _daController.tourValue == 'NA'
                            ? Container(height: 10)
                            : const SizedBox(),
                        _daController.tourValue != 'NA' &&
                                _daController.tourValue != null
                            ? Row(
                                children: [
                                  const Text('Add Daily Allowance:',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.grey_95)),
                                  IconButton(
                                      onPressed: () {
                                        showStaffSheet(
                                          context: context,
                                          title: 'Add Daily Allowance',
                                          validateDays: _validateDays,
                                          validateFromDa: _validateFrom,
                                          validateToDa: _validateTo,
                                          validateNightsDa: _validateDaNights,
                                          validateNoNightsDa:
                                              _validateDaNoNights,
                                          validateTotalAllowance:
                                              _validateTotalAllowance,
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        color: Color(0xFF8A2724),
                                      ))
                                ],
                              )
                            : const SizedBox(),

                        Container(height: 10),
                        _daController.tourValue != 'NA'
                            ? const SizedBox()
                            : const Text('State',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.grey_95)),
                        _daController.tourValue == 'NA'
                            ? Container(height: 10)
                            : const SizedBox(),
                        _daController.tourValue != 'NA'
                            ? const SizedBox()
                            : Container(
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
                                    value: stateValue,
                                    iconSize: 24,
                                    elevation: 2,
                                    hint: Text(
                                      'Select State'.tr,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    // ignore: can_be_null_after_null_aware
                                    items: uniqueState.map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value.stateName.toString(),
                                        child: Text(value.stateName.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (data) {
                                      setState(() {
                                        stateValue = data;
                                        districtValue = null;
                                      });
                                    },
                                  ),
                                ]),
                              ),

                        _validatestate
                            ? const Text('Please select state',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red))
                            : const SizedBox(),
                        _daController.tourValue == 'NA'
                            ? Container(height: 10)
                            : const SizedBox(),
                        _daController.tourValue != 'NA'
                            ? const SizedBox()
                            : const Text('District',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.grey_95)),

                        _daController.tourValue != 'NA'
                            ? const SizedBox()
                            : Container(
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
                                    value: districtValue,
                                    iconSize: 24,
                                    elevation: 2,
                                    hint: Text(
                                      'Select District'.tr,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    // ignore: can_be_null_after_null_aware
                                    items: uniqueDistrict.map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value.districtName.toString(),
                                        child:
                                            Text(value.districtName.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (data) {
                                      setState(() {
                                        districtValue = data;
                                        blockValue = null;
                                      });
                                    },
                                  ),
                                ]),
                              ),
                        _validateDistrict
                            ? const Text('Please select district',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red))
                            : const SizedBox(),
                        _daController.tourValue == 'NA'
                            ? Container(height: 10)
                            : const SizedBox(),
                        _daController.tourValue != 'NA'
                            ? const SizedBox()
                            : const Text('Block Name',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.grey_95)),

                        _daController.tourValue != 'NA'
                            ? const SizedBox()
                            : Container(
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
                                    value: blockValue,
                                    iconSize: 24,
                                    elevation: 2,
                                    hint: Text(
                                      'Select Block'.tr,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    // ignore: can_be_null_after_null_aware
                                    items: uniqueBlock.map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value.blockName.toString(),
                                        child: Text(value.blockName.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (data) {
                                      setState(() {
                                        blockValue = data;
                                        //dropdownValue4 = null;
                                      });
                                    },
                                  ),
                                ]),
                              ),
                        _validateblock
                            ? const Text('Please select block',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red))
                            : const SizedBox(),
                        Container(height: 10),
                        _daController.tourValue == 'NA'
                            ? const Text('No of Days',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.grey_95))
                            : const SizedBox(),
                        _daController.tourValue == 'NA'
                            ? Container(height: 10)
                            : const SizedBox(),
                        _daController.tourValue == 'NA'
                            ? Container(
                                height: 45,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: TextField(
                                  readOnly: true,
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (value) {},
                                  maxLines: 1,
                                  controller: _daController.daNaDaysController,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(-12),
                                      border: InputBorder.none,
                                      hintText: "No of days",
                                      hintStyle: MyText.body1(context)!
                                          .copyWith(color: MyColors.grey_40)),
                                ),
                              )
                            : const SizedBox(),
                        _validateNaDays
                            ? const Text('Please fill No of days',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red))
                            : const SizedBox(),
                        _daController.tourValue == 'NA'
                            ? Container(height: 10)
                            : const SizedBox(),

                        _daController.tourValue == 'NA'
                            ? const Text('No of nights',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.grey_95))
                            : const SizedBox(),
                        _daController.tourValue == 'NA'
                            ? Container(height: 10)
                            : const SizedBox(),
                        _daController.tourValue == 'NA'
                            ? Container(
                                height: 45,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: TextField(
                                  //readOnly: true,
                                  textInputAction: TextInputAction.next,
                                  onChanged: (value) {
                                    _daController.calculateNaDa(value);
                                  },
                                  maxLines: 1,
                                  controller:
                                      _daController.daNaNightsController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(-12),
                                      border: InputBorder.none,
                                      hintText: "No of Nights",
                                      hintStyle: MyText.body1(context)!
                                          .copyWith(color: MyColors.grey_40)),
                                ),
                              )
                            : const SizedBox(),
                        _validateNaNights
                            ? const Text('Please fill No of nights',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red))
                            : _validateNoNights
                                ? const Text('Invalid',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red))
                                : const SizedBox(),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(height: 20),
                        _daController.tourValue == 'NA'
                            ? const Text('DA (Daily Allowance)',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.grey_95))
                            : const SizedBox(),
                        _daController.tourValue == 'NA'
                            ? Container(height: 10)
                            : const SizedBox(),
                        _daController.tourValue == 'NA'
                            ? Container(
                                height: 45,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: TextField(
                                  readOnly: true,
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (value) {},
                                  maxLines: 1,
                                  controller: _daController.daNaTotalController,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(-12),
                                      border: InputBorder.none,
                                      hintText: "DA",
                                      hintStyle: MyText.body1(context)!
                                          .copyWith(color: MyColors.grey_40)),
                                ),
                              )
                            : const SizedBox(),
                        _validateNaDa
                            ? const Text('Please fill DA',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red))
                            : const SizedBox(),
                        _daController.tourValue == 'NA'
                            ? Container(height: 10)
                            : const SizedBox(),
                        _daController.tourValue != 'NA'
                            ? const SizedBox()
                            : const Text('Place of Visit:',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.grey_95)),
                        _daController.tourValue == 'NA'
                            ? Container(height: 10)
                            : const SizedBox(),
                        _daController.tourValue != 'NA'
                            ? const SizedBox()
                            : Container(
                                height: 45,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: TextField(
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (value) {},
                                  maxLines: 1,
                                  controller:
                                      _daController.daVisitPlaceController,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(-12),
                                      border: InputBorder.none,
                                      hintText: "Place of visit",
                                      hintStyle: MyText.body1(context)!
                                          .copyWith(color: MyColors.grey_40)),
                                ),
                              ),
                        _validateVisit
                            ? const Text('Please fill place of visit',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red))
                            : const SizedBox(),
                        _daController.tourValue != 'NA'
                            ? const SizedBox()
                            : const SizedBox(
                                // height: 15,
                                ),
                        _daController.tourValue != 'NA'
                            ? const SizedBox()
                            : const Text('Purpose of Visit',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.grey_95)),
                        _daController.tourValue != 'NA'
                            ? const SizedBox()
                            : Container(height: 10),
                        _daController.tourValue != 'NA'
                            ? const SizedBox()
                            : Container(
                                height: 45,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: TextField(
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (value) {},
                                  maxLines: 1,
                                  controller:
                                      _daController.daVisitPurposeController,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(-12),
                                      border: InputBorder.none,
                                      hintText: "Purpose of visit",
                                      hintStyle: MyText.body1(context)!
                                          .copyWith(color: MyColors.grey_40)),
                                ),
                              ),
                        _validatePurpose
                            ? const Text('Please fill purpose of visit',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red))
                            : const SizedBox(),

                        _daController.tourValue == 'NA'
                            ? Container(height: 10)
                            : const SizedBox(),
                        _daController.tourValue == 'NA'
                            ? const Text('Remarks:',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.grey_95))
                            : const SizedBox(),
                        _daController.tourValue == 'NA'
                            ? Container(height: 10)
                            : const SizedBox(),
                        _daController.tourValue == 'NA'
                            ? TextField(
                                textInputAction: TextInputAction.done,
                                controller: _daController.daNaRemarksController,
                                decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    hintText: 'Type Something.....',
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    )),
                                maxLines: 6,
                              )
                            : const SizedBox(),

                        GetBuilder<NewDaController>(
                            init: NewDaController(),
                            builder: (daController) {
                              return daController.daList.isEmpty
                                  ? const SizedBox()
                                  : ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: daController.daList.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        var textStyle = const TextStyle(
                                            fontWeight: FontWeight.bold);

                                        return ListTile(
                                          contentPadding:
                                              const EdgeInsets.only(bottom: 8),

                                          // title: Text( _daController.staffDetails[index].name== null
                                          //     ? ''
                                          //     : _daController.staffDetails[index].name.toString()),
                                          subtitle: RichText(
                                              text: TextSpan(
                                            // ignore: prefer_const_constructors
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              // ignore: unnecessary_new
                                              new TextSpan(
                                                  text:
                                                      "${daController.daList[index].tourId}\n"),
                                              TextSpan(
                                                  text:
                                                      "No of Days: ${daController.daList[index].noDays}\n",
                                                  style: textStyle),
                                              TextSpan(
                                                  text:
                                                      "No of Nights: ${daController.daList[index].noNights}\n",
                                                  style: textStyle),
                                              TextSpan(
                                                  text:
                                                      "Daily Allowance: ${daController.daList[index].totalDailyAllowance}",
                                                  style: textStyle),
                                            ],
                                          )),
                                          leading: Text(
                                            '(${index + 1})',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          trailing: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  // _daController.staffDetails.remove(
                                                  //     _daController.staffDetails[index]);
                                                  daController.removeDaList(
                                                      daController
                                                          .daList[index]);

                                                  // _daController.removeDa(_daController
                                                  //     .staffDetails[index].totalda!);
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                size: 20,
                                                color: Colors.red,
                                              )),
                                          selectedTileColor: Colors.green[400],
                                          onTap: () {
                                            setState(() {});
                                          },
                                        );
                                      },
                                    );
                            }),
                        _validateStaff
                            ? const Text('Please select a staff',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red))
                            : const SizedBox(),
                        Container(height: 10),
                        _daController.tourValue == 'NA'
                            ? SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF8A2724),
                                        elevation: 0),
                                    child: Text("Submit DA",
                                        style: MyText.subhead(context)!
                                            .copyWith(color: Colors.white)),
                                    onPressed: () async {
                                      setState(() {
                                        print('onsubmit is callled chekt ');
                                        print(tourValue.toString());

                                        _daController.daNaFromController.text
                                                .isNotEmpty
                                            ? _validateNaFrom = false
                                            : _validateNaFrom = true;
                                        _daController.daNaToController.text
                                                .isNotEmpty
                                            ? _validateNaTo = false
                                            : _validateNaTo = true;
                                        stateValue != null
                                            ? _validatestate = false
                                            : _validatestate = true;
                                        blockValue != null
                                            ? _validateblock = false
                                            : _validateblock = true;
                                        districtValue != null
                                            ? _validateDistrict = false
                                            : _validateDistrict = true;
                                        _daController.daNaDaysController.text
                                                .isNotEmpty
                                            ? _validateNaDays = false
                                            : _validateNaDays = true;
                                        _daController.daNaNightsController.text
                                                .isNotEmpty
                                            ? _validateNaNights = false
                                            : _validateNaNights = true;

                                        int.parse(_daController
                                                    .daNaNightsController
                                                    .text) <=
                                                int.parse(_daController
                                                    .daNaDaysController.text)
                                            ? _validateNoNights = false
                                            : _validateNoNights = true;
                                        _daController.daNaTotalController.text
                                                .isNotEmpty
                                            ? _validateNaDa = false
                                            : _validateNaDa = true;
                                        _daController.daVisitPlaceController
                                                .text.isNotEmpty
                                            ? _validateVisit = false
                                            : _validateVisit = true;
                                        _daController.daVisitPurposeController
                                                .text.isNotEmpty
                                            ? _validatePurpose = false
                                            : _validatePurpose = true;
                                      });
                                      if (!_validateNaFrom &&
                                          !_validateNaDa &&
                                          !_validateNaTo &&
                                          !_validatestate &&
                                          !_validateblock &&
                                          !_validateDistrict &&
                                          !_validateNaDays &&
                                          !_validateNaNights &&
                                          !_validateNoNights &&
                                          !_validateVisit &&
                                          !_validatePurpose) {
                                        print('in if we r here');
                                        print(_daController.tourValue!);
                                        isLoading.value = true;
                                        var rsp = await insert_da(
                                          stateValue.toString(),
                                          districtValue.toString(),
                                          blockValue.toString(),
                                          _daController.daNaFromController.text
                                              .toString(),
                                          _daController.daNaToController.text
                                              .toString(),
                                          _daController.daNaTotalController.text
                                              .toString(),
                                          _daController
                                              .daVisitPlaceController.text
                                              .toString(),
                                          _daController
                                              .daVisitPurposeController.text
                                              .toString(),
                                          tourValue.toString(),
                                          GetStorage().read('userId'),
                                          _daController
                                              .daNaRemarksController.text,
                                          _daController.daNaDaysController.text
                                              .toString(),
                                          _daController
                                              .daNaNightsController.text
                                              .toString(),
                                        );
                                        if (rsp['status'] == 1) {
                                          isLoading.value = false;
                                          showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  const CustomEventDialog(
                                                      title: 'Home'));
                                          setState(() {
                                            stateValue = null;
                                            districtValue = null;
                                            blockValue = null;
                                            _daController.clearData();
                                            _daController.daNaFromController
                                                .clear();
                                            _daController.daNaToController
                                                .clear();
                                          });
                                        } else {
                                          print('something went wrong');
                                        }
                                      } else {
                                        print('we r out of if');
                                      }
                                    }))
                            : GetBuilder<NewDaController>(
                                init: NewDaController(),
                                builder: (daController) {
                                  return daController.daList.isNotEmpty
                                      ? SizedBox(
                                          width: double.infinity,
                                          height: 45,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xFF8A2724),
                                                  elevation: 0),
                                              child: Text("Submit DA",
                                                  style: MyText.subhead(
                                                          context)!
                                                      .copyWith(
                                                          color: Colors.white)),
                                              onPressed: () async {
                                                setState(() {
                                                  print('onsubmit is callled');
                                                  //  _daController
                                                  //           .daNaFromController.text.isNotEmpty
                                                  //       ? _validateNaFrom = false
                                                  //       : _validateNaFrom = true;
                                                  // _daController.daNaToController.text.isNotEmpty
                                                  //     ? _validateNaTo = false
                                                  //     : _validateNaTo = true;
                                                  // stateValue == null
                                                  //     ? _validatestate = true
                                                  //     : _validatestate = false;
                                                  // blockValue == null
                                                  //     ? _validateblock = false
                                                  //     : _validateblock = true;
                                                  // districtValue == null
                                                  //     ? _validateDistrict = false
                                                  //     : _validateDistrict = true;
                                                  // _daController
                                                  //         .daNaDaysController.text.isNotEmpty
                                                  //     ? _validateNaDays = false
                                                  //     : _validateNaDays = true;
                                                  // _daController
                                                  //         .daNaNightsController.text.isNotEmpty
                                                  //     ? _validateNaNights = false
                                                  //     : _validateNaNights = true;
                                                  // _daController
                                                  //         .daNaTotalController.text.isNotEmpty
                                                  //     ? _validateNaDa = false
                                                  //     : _validateNaDa = true;
                                                  // _daController.daVisitPlaceController.text
                                                  //         .isNotEmpty
                                                  //     ? _validateVisit = false
                                                  //     : _validateVisit = true;
                                                  // _daController.daVisitPurposeController.text
                                                  //         .isNotEmpty
                                                  //     ? _validatePurpose = false
                                                  //     : _validatePurpose = true;
                                                });
                                                // if (!_validateNaFrom &&

                                                //   print(
                                                //       'in if we r here with tourid');
                                                isLoading.value = true;
                                                if (daController
                                                    .daList.isNotEmpty) {
                                                  for (int i = 0;
                                                      i <
                                                          daController
                                                              .daList.length;
                                                      i++) {
                                                    var rsp = await insert_da(
                                                      stateValue.toString(),
                                                      districtValue.toString(),
                                                      blockValue.toString(),
                                                      daController
                                                          .daList[i].fromDate
                                                          .toString(),
                                                      daController
                                                          .daList[i].toDate
                                                          .toString(),
                                                      daController.daList[i]
                                                          .totalDailyAllowance
                                                          .toString(),
                                                      'NA',
                                                      'NA',
                                                      tourValue.toString(),
                                                      GetStorage()
                                                          .read('userId'),
                                                      daController
                                                          .daList[i].remarks
                                                          .toString(),
                                                      daController
                                                          .daList[i].noDays
                                                          .toString(),
                                                      daController
                                                          .daList[i].noNights
                                                          .toString(),
                                                    );
                                                    if (i ==
                                                        daController
                                                                .daList.length -
                                                            1) {
                                                      if (rsp['status'] == 1) {
                                                        isLoading.value = false;
                                                        showDialog(
                                                            context: context,
                                                            builder: (_) =>
                                                                const CustomEventDialog(
                                                                    title:
                                                                        'Home'));
                                                        setState(() {
                                                          stateValue = null;
                                                          districtValue = null;
                                                          blockValue = null;
                                                          daController
                                                              .clearData();
                                                          daController.daList
                                                              .clear();
                                                          daController
                                                              .daToController
                                                              .clear();
                                                          daController
                                                              .daFromController
                                                              .clear();
                                                          daController
                                                              .daNaToController
                                                              .clear();
                                                          daController
                                                              .daNaFromController
                                                              .clear();
                                                        });
                                                      } else {
                                                        print(
                                                            'something went wrong');
                                                      }
                                                    }
                                                  }
                                                }
                                                // } else {
                                                //   print('we r out of if from tiurid');
                                                // }
                                              }))
                                      : const SizedBox();
                                }),
                      ],
                    ),
                  ),
                ))
        // }),
        );
  }

  Future insert_da(
    String state,
    String dist,
    String block,
    String visitfrom,
    String visitto,
    String amount,
    String visitplace,
    String visitpurpose,
    String tourid,
    String userid,
    String remarks,
    String nodays,
    String nonights,
  ) async {
    print('insert da is called');
    print(state);
    print(dist);
    print(block);
    print(visitfrom);
    print(visitto);
    print(amount);
    print(visitplace);
    print(visitpurpose);
    print(userid);
    print(remarks);
    print(nodays);
    print(nonights);

    var response =
        await http.post(Uri.parse('${MyColors.baseUrl}da.php'), headers: {
      "Accept": "Application/json"
    }, body: {
      'state_name': state,
      'dist_name': dist,
      'block_name': block,
      'dateto': visitfrom,
      'datefrom': visitto,
      'amount': amount,
      'place': visitplace,
      'purpose': visitpurpose,
      'tour_id': tourid,
      'userid': userid,
      'remarks': remarks,
      'no_days': nodays,
      'no_nights': nonights
    });
    print(response.body);
    var convertedDatatoJson = jsonDecode(response.body);
    return convertedDatatoJson;
  }
}

//*********************Bottom sheet to add staff da***************************

void showStaffSheet({
  required BuildContext context,
  required String title,
  required bool validateDays,
  required bool validateFromDa,
  required bool validateToDa,
  required bool validateNightsDa,
  required bool validateNoNightsDa,
  required bool validateTotalAllowance,
}) {
  // bool _validateFrom = false;
  // bool _validateDA = false;
  // bool _validateDays = false;
  // bool _validateVisit = false;
  // bool _validatePurpose = false;
  // bool _validateNoDaNights = false;
  // bool _validateNaDaNight = false;
  showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return GetBuilder<NewDaController>(
          init: NewDaController(),
          builder: (daController) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.minHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(
                              child: Text(title,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                          ),
                          Container(height: 10),
                          const Text('From:',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.grey_95)),
                          Container(height: 10),
                          Container(
                            height: 45,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: <Widget>[
                                Container(width: 15),
                                Expanded(
                                  child: TextField(
                                    onTap: () {
                                      //              },
                                      //   _selectDate(context, _fromController, 'from');
                                    },
                                    readOnly: true,
                                    onChanged: (value) {},
                                    maxLines: 1,
                                    style: MyText.body2(context)!
                                        .copyWith(color: MyColors.grey_40),
                                    keyboardType: TextInputType.datetime,
                                    controller: daController.daFromController,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(-12),
                                        border: InputBorder.none,
                                        hintText: "Starting Date(yyyy-mm-dd)",
                                        hintStyle: MyText.body1(context)!
                                            .copyWith(color: MyColors.grey_40)),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      daController.selectDate(
                                          context,
                                          daController.daFromController,
                                          'from');
                                    },
                                    icon: const Icon(Icons.calendar_today,
                                        color: MyColors.grey_40))
                              ],
                            ),
                          ),
                          validateFromDa
                              ? const Text('Please select date',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red))
                              : const SizedBox(),
                          const Text('To:',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.grey_95)),
                          Container(height: 10),
                          Container(
                            height: 45,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: <Widget>[
                                Container(width: 15),
                                Expanded(
                                  child: TextField(
                                    onTap: () {
                                      daController.selectDate(context,
                                          daController.daToController, 'to');
                                    },
                                    readOnly: true,
                                    onChanged: (value) {},
                                    maxLines: 1,
                                    style: MyText.body2(context)!
                                        .copyWith(color: MyColors.grey_40),
                                    keyboardType: TextInputType.datetime,
                                    controller: daController.daToController,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(-12),
                                        border: InputBorder.none,
                                        hintText: "Ending Date(yyyy-mm-dd)",
                                        hintStyle: MyText.body1(context)!
                                            .copyWith(color: MyColors.grey_40)),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      await daController.selectDate(context,
                                          daController.daToController, 'to');
                                      final birthday = DateFormat('yyyy-MM-dd')
                                          .parse(
                                              daController.daToController.text);
                                      final date2 = DateFormat('yyyy-MM-dd')
                                          .parse(daController
                                              .daFromController.text);
                                      final difference =
                                          birthday.difference(date2).inDays;

                                      daController.daDaysController.text =
                                          (difference + 1).toString();
                                    },
                                    icon: const Icon(Icons.calendar_today,
                                        color: MyColors.grey_40))
                              ],
                            ),
                          ),
                          validateToDa
                              ? const Text('Please select date',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red))
                              : const SizedBox(),
                          Container(height: 20),
                          const Text('No of Days',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.grey_95)),
                          Container(height: 10),
                          Container(
                            height: 45,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextField(
                              readOnly: true,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              maxLines: 1,
                              controller: daController.daDaysController,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(-12),
                                  border: InputBorder.none,
                                  hintText: "No of days",
                                  hintStyle: MyText.body1(context)!
                                      .copyWith(color: MyColors.grey_40)),
                            ),
                          ),
                          validateDays
                              ? const Text('Please fill No of days',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red))
                              : const SizedBox(),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(height: 10),
                          Container(height: 20),
                          const Text('No of nights',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.grey_95)),
                          Container(height: 10),
                          Container(
                            height: 45,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextField(
                              //readOnly: true,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                daController.calculateDa(value);
                              },
                              maxLines: 1,
                              controller: daController.daNightsController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(-12),
                                  border: InputBorder.none,
                                  hintText: "No of Nights",
                                  hintStyle: MyText.body1(context)!
                                      .copyWith(color: MyColors.grey_40)),
                            ),
                          ),
                          validateNightsDa
                              ? const Text('Please fill No of nights',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red))
                              : validateNoNightsDa
                                  ? const Text('Invalid',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red))
                                  : const SizedBox(),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(height: 20),
                          const Text('DA (Daily Allowance)',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.grey_95)),
                          Container(height: 10),
                          Container(
                            height: 45,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextField(
                              readOnly: true,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              maxLines: 1,
                              controller: daController.daTotalController,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(-12),
                                  border: InputBorder.none,
                                  hintText: "DA",
                                  hintStyle: MyText.body1(context)!
                                      .copyWith(color: MyColors.grey_40)),
                            ),
                          ),
                          validateTotalAllowance
                              ? const Text('Please fill DA',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red))
                              : const SizedBox(),
                          const Text('Remarks:',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.grey_95)),
                          Container(height: 10),
                          TextField(
                            textInputAction: TextInputAction.done,
                            controller: daController.daRemarksController,
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                hintText: 'Type Something.....',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                )),
                            maxLines: 6,
                          ),
                          Container(height: 10),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF8A2724),
                                    elevation: 0),
                                child: Text("Add",
                                    style: MyText.subhead(context)!
                                        .copyWith(color: Colors.white)),
                                onPressed: () async {
                                  setState(() {
                                    daController
                                            .daDaysController.text.isNotEmpty
                                        ? validateDays = false
                                        : validateDays = true;
                                    daController
                                            .daFromController.text.isNotEmpty
                                        ? validateFromDa = false
                                        : validateFromDa = true;
                                    daController.daToController.text.isNotEmpty
                                        ? validateToDa = false
                                        : validateToDa = true;
                                    daController
                                            .daNightsController.text.isNotEmpty
                                        ? validateNightsDa = false
                                        : validateNightsDa = true;
                                    int.parse(daController
                                                .daNightsController.text) <=
                                            int.parse(daController
                                                .daDaysController.text)
                                        ? validateNoNightsDa = false
                                        : validateNoNightsDa = true;
                                    daController
                                            .daTotalController.text.isNotEmpty
                                        ? validateTotalAllowance = false
                                        : validateTotalAllowance = true;
                                  });

                                  // var da =0;
                                  //  da = da + int.parse( _daController.totalEmpDaController.text);
                                  //   _grandDalist.add(da);
                                  //  print(_grandDalist.length);
                                  if (!validateDays &&
                                      !validateFromDa &&
                                      !validateToDa &&
                                      !validateNightsDa &&
                                      !validateNoNightsDa &&
                                      !validateTotalAllowance) {
                                    DaList staffDa = DaList(
                                      tourId: daController.tourValue.toString(),
                                      fromDate: daController
                                          .daFromController.text
                                          .toString(),
                                      toDate: daController.daToController.text
                                          .toString(),
                                      noDays: daController.daDaysController.text
                                          .toString(),
                                      noNights: daController
                                          .daNightsController.text
                                          .toString(),
                                      totalDailyAllowance: daController
                                          .daTotalController.text
                                          .toString(),
                                      remarks: daController
                                          .daRemarksController.text
                                          .toString(),
                                    );
                                    daController.addDaList(staffDa);
                                    daController.clearData();
                                    daController.daFromController.clear();
                                    daController.daToController.clear();
                                    Navigator.of(context).pop();
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
            });
          },
        );
      });
  //*************************End bottomsheet to add Staff***************************
}

//*************dropdown for staff *************************************
