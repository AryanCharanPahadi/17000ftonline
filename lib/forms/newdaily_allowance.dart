import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:old17000ft/Controllers/school_Controller.dart';
import 'package:old17000ft/Model/blockModel.dart';
import 'package:old17000ft/Model/tour.dart';
import 'package:old17000ft/custom_dialog.dart';
import 'package:old17000ft/da_form.dart';
import '../colors.dart';
import '../home_screen.dart';
import '../my_text.dart';


final StaffController staffController = Get.put(StaffController());

class NewDaForm extends StatefulWidget {
  const NewDaForm({Key? key}) : super(key: key);

  @override
  _NewDaFormState createState() => _NewDaFormState();
}

class _NewDaFormState extends State<NewDaForm> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _daController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _nightController = TextEditingController();
  final TextEditingController _visitController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  List<TourId> _minetour = [];

  bool _validatestate = false;
  bool _validateTourId = false;

  bool _validateblock = false;
  bool _validateDistrict = false;
  bool _validateFrom = false;
  bool _validateTo = false;
  bool _validateDA = false;
  bool _validateDays = false;
  bool _validateNights = false;

  bool _validateVisit = false;
  bool _validatePurpose = false;
  String? _districtName;
  String? _state;
  String? _blockName;
  String? _programName;
  String? _fromDate;
  String? _toDate;

  String? stateValue;
  String? districtValue;
  String? blockValue;
  String? dropdownValue3;
  String? dropdownValue4;
  String? dropdownValue5;
  String? dropdownValue6;
  String? dropdownValue7;
  String? tourValue;

  int? from;
  int? to;

  var isLoading = false.obs;
  getNumber(int a) {
    return a;
  }

  //bool _validateState = false;

  DateTime selectedDate = DateTime.now(), initialDate = DateTime.now();

  _selectDate(
    BuildContext context,
    TextEditingController date,
    String title,
  ) async {
    final DateTime? selected = await showDatePicker(
      locale: const Locale('en', 'IN'),
      context: context,
      initialDate: title == 'to' ? schoolController.from! : DateTime.now(),
      firstDate: title == 'to' ? schoolController.from! : DateTime(2017),
      lastDate: DateTime(2040),
      builder: (context, picker) {
        return Theme(data: theme, child: picker!);
      },
    );
    if (selected != null) {
      setState(() {
        selectedDate = selected;
        schoolController.setDate(selected, title);
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        date.text = formattedDate;
        if (title == 'from') {
          _toController.clear();
        }
        //    (getNumber(int.parse(DateFormat('dd').format(selectedDate))));
      });
    }
  }

  // int daysBetween(DateTime from, DateTime to) {
  //   from = DateTime(from.day);
  //   to = DateTime(to.day);
  //   return (to.difference(from).inHours / 24).round();
  // }

  @override
  void initState() {
    super.initState();

    //  _districtController.fetchDistrict('LADAKH');

    // for (int i = 0; i <= stateController.stateList.data!.length; i++) {
    //   state.add(stateController.stateList.data![i].state!);
    // }
  }
  @override
  Widget build(BuildContext context) {
       var seen = <String>{};
          List<StateInfo> _uniqueState = [];
          List<StateInfo> _uniqueDistrict = [];
          List<StateInfo> _uniqueBlock = [];

          _uniqueState = stateInfoController.stateInfo
              .where((student) => seen.add(student.stateName!))
              .toList();

          if (stateValue != null) {
            _uniqueDistrict = stateInfoController.stateInfo
                .where((student) => student.stateName == stateValue)
                .toList();
            _uniqueDistrict = _uniqueDistrict
                .where((student) => seen.add(student.districtName!))
                .toList();
          }

          if (districtValue != null) {
            _uniqueBlock = stateInfoController.stateInfo
                .where((student) => student.districtName == districtValue)
                .toList();
            _uniqueBlock = _uniqueBlock
                .where((student) => seen.add(student.blockName!))
                .toList();
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
                          valueColor:
                              AlwaysStoppedAnimation<Color>(MyColors.primary),
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
              backgroundColor: const Color(0xFF8A2724),
              title: const Text(
                'Daily Allowance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            body:SingleChildScrollView(
              child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('Tour ID',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.grey_95)),
                                Container(height: 10),
                                GetBuilder<SchoolController>(
                                  init: SchoolController(),
                                  builder: (schoolController) {
                                    schoolController
                                        .filterList(GetStorage().read('office'));
            
                                    return Container(
                                      height: 45,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: InkWell(
                                        splashColor: Colors.grey,
                                        child: DropdownButton<String>(
                                          value: tourValue,
                                          iconSize: 24,
                                          elevation: 2,
                                          hint: Text(
                                            'Select Tour Id'.tr,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                          // ignore: can_be_null_after_null_aware
                                          items: schoolController.schoolTourList!
                                              .map((value) {
                                            return DropdownMenuItem<String>(
                                              value: value.tourId.toString(),
                                              child:
                                                  Text(value.tourId.toString()),
                                            );
                                          }).toList(),
                                          onChanged: (data) {
                                            setState(() {
                                              tourValue = data;
                                              _minetour = schoolController
                                                  .mytour(tourValue.toString());
                                              _fromController.text = _minetour[0]
                                                  .datefrom
                                                  .toString();
                                              _toController.text =
                                                  _minetour[0].dateto.toString();
                                              print("minetouur value" +
                                                  _minetour[0]
                                                      .datefrom
                                                      .toString());
            
                                              final birthday =
                                                  DateFormat('yyyy-MM-dd')
                                                      .parse(_toController.text);
                                              final date2 =
                                                  DateFormat('yyyy-MM-dd').parse(
                                                      _fromController.text);
                                              final difference = birthday
                                                  .difference(date2)
                                                  .inDays;
            
                                              // setState(() {
                                                _daysController.text =
                                                    (difference + 1).toString();
                                                // _daController.text =
                                                //     ((difference + 1) * 250)
                                                //         .toString();
                                              // });
                                            });
                                          },
                                        ),
                                        onTap: () {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                        },
                                      ),
                                    );
                                  },
                                ),
                                _validateTourId
                                    ? const Text('Please select a Tour Id',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 10,
                                ),
                                tourValue != 'NA'
                                    ? const SizedBox()
                                    : const Text('State',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.grey_95)),
                                Container(height: 10),
                                tourValue != 'NA'
                                    ? const SizedBox()
                                    : Container(
                                        width: MediaQuery.of(context).size.width *
                                            0.9,
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
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                            // ignore: can_be_null_after_null_aware
                                            items: _uniqueState.map((value) {
                                              return DropdownMenuItem<String>(
                                                value: value.stateName.toString(),
                                                child: Text(
                                                    value.stateName.toString()),
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
                                    ? const Text('Please select State',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                tourValue == 'NA'
                                    ? Container(height: 10)
                                    : const SizedBox(),
                                tourValue != 'NA'
                                    ? const SizedBox()
                                    : const SizedBox(
                                        height: 10,
                                      ),
                                tourValue != 'NA'
                                    ? const SizedBox()
                                    : const Text('District',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.grey_95)),
                                tourValue != 'NA'
                                    ? const SizedBox()
                                    : Container(height: 10),
                                tourValue != 'NA'
                                    ? const SizedBox()
                                    : Container(
                                        width: MediaQuery.of(context).size.width *
                                            0.9,
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
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                            // ignore: can_be_null_after_null_aware
                                            items: _uniqueDistrict.map((value) {
                                              return DropdownMenuItem<String>(
                                                value:
                                                    value.districtName.toString(),
                                                child: Text(value.districtName
                                                    .toString()),
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
                                    ? const Text('Please select District',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                tourValue == 'NA'
                                    ? Container(height: 10)
                                    : const SizedBox(),
                                tourValue != 'NA'
                                    ? const SizedBox()
                                    : const Text('Block Name',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.grey_95)),
                                tourValue != 'NA'
                                    ? const SizedBox()
                                    : Container(height: 10),
                                tourValue != 'NA'
                                    ? const SizedBox()
                                    : Container(
                                        width: MediaQuery.of(context).size.width *
                                            0.9,
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
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                            // ignore: can_be_null_after_null_aware
                                            items: _uniqueBlock.map((value) {
                                              return DropdownMenuItem<String>(
                                                value: value.blockName.toString(),
                                                child: Text(
                                                    value.blockName.toString()),
                                              );
                                            }).toList(),
                                            onChanged: (data) {
                                              setState(() {
                                                blockValue = data;
                                                dropdownValue4 = null;
                                              });
                                            },
                                          ),
                                        ]),
                                      ),
                                _validateblock
                                    ? const Text('Please select a Block',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                Container(height: 10),
                                const Text('From',
                                    style: TextStyle(
                                        fontSize: 16,
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Container(width: 15),
                                      Expanded(
                                        child: TextField(
                                          onTap: () {
                                            _selectDate(
                                                context, _fromController, 'from');
                                          },
                                          readOnly: true,
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                          maxLines: 1,
                                          style: MyText.body2(context)!
                                              .copyWith(color: MyColors.grey_40),
                                          keyboardType: TextInputType.datetime,
                                          controller: _fromController,
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
                                            // setState(() {
                                            //   _selectDate(context,
                                            //       _fromController, 'from');
                                            // });
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
                                const Text('To',
                                    style: TextStyle(
                                        fontSize: 16,
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Container(width: 15),
                                      Expanded(
                                        child: TextField(
                                          onTap: () async {
                                            await _selectDate(
                                                context, _toController, 'to');
            
                                            String formattedToDate = DateFormat(
                                                    'dd')
                                                .format(DateFormat('yyyy-MM-dd')
                                                    .parse(_toController.text));
                                            String formattedFromDate = DateFormat(
                                                    'dd')
                                                .format(DateFormat('yyyy-MM-dd')
                                                    .parse(_fromController.text));
            
                                            setState(() {
                                              _daysController.text = ((int.parse(
                                                              formattedToDate) -
                                                          int.parse(
                                                              formattedFromDate)) +
                                                      1)
                                                  .toString();
                                              // _daController.text = ((int.parse(
                                              //                 formattedToDate) -
                                              //             int.parse(
                                              //                 formattedFromDate) +
                                              //             1) *
                                              //         250)
                                              //     .toString();
                                            });
                                          },
                                          readOnly: true,
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                          maxLines: 1,
                                          style: MyText.body2(context)!
                                              .copyWith(color: MyColors.grey_40),
                                          keyboardType: TextInputType.datetime,
                                          controller: _toController,
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
                                            // await _selectDate(
                                            //     context, _toController, 'to');
            
                                            // final birthday =
                                            //     DateFormat('yyyy-MM-dd')
                                            //         .parse(_toController.text);
                                            // final date2 = DateFormat('yyyy-MM-dd')
                                            //     .parse(_fromController.text);
                                            // final difference =
                                            //     birthday.difference(date2).inDays;
            
                                            // setState(() {
                                            //   _daysController.text =
                                            //       (difference + 1).toString();
                                            //   // _daController.text =
                                            //   //     ((difference + 1) * 250)
                                            //   //         .toString();
                                            // });
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
                                Container(height: 10),
                                Container(height: 20),
                                const Text('No of Days',
                                    style: TextStyle(
                                        fontSize: 15,
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 25),
                                  child: TextField(
                                    readOnly: true,
                                    textInputAction: TextInputAction.next,
                                    onSubmitted: (value) {},
                                    maxLines: 1,
                                    controller: _daysController,
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(-12),
                                        border: InputBorder.none,
                                        hintText: "No of days",
                                        hintStyle: MyText.body1(context)!
                                            .copyWith(color: MyColors.grey_40)),
                                  ),
                                ),
                                _validateDays
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
                                        fontSize: 15,
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 25),
                                  child: TextField(
                                    //readOnly: true,
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) {
                                      _daController.text =
                                          ((int.parse(_daysController.text) +
                                                      int.parse(value)) *
                                                  int.parse(
                                                      GetStorage().read("empda")))
                                              .toString();
                                    },
                                    maxLines: 1,
                                    controller: _nightController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(-12),
                                        border: InputBorder.none,
                                        hintText: "No of Nights",
                                        hintStyle: MyText.body1(context)!
                                            .copyWith(color: MyColors.grey_40)),
                                  ),
                                ),
                                _validateDays
                                    ? const Text('Please fill No of nights',
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
                                        fontSize: 15,
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 25),
                                  child: TextField(
                                    readOnly: true,
                                    textInputAction: TextInputAction.next,
                                    onSubmitted: (value) {},
                                    maxLines: 1,
                                    controller: _daController,
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(-12),
                                        border: InputBorder.none,
                                        hintText: "DA",
                                        hintStyle: MyText.body1(context)!
                                            .copyWith(color: MyColors.grey_40)),
                                  ),
                                ),
                                _validateDA
                                    ? const Text('Please fill DA',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(height: 20),
                                const Text('Remarks',
                                    style: TextStyle(
                                        fontSize: 15,
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 25),
                                  child: TextField(
                                    //readOnly: true,
                                    textInputAction: TextInputAction.next,
                                    onSubmitted: (value) {},
                                    maxLines: 1,
                                    controller: _remarksController,
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(-12),
                                        border: InputBorder.none,
                                        hintText: "Remarks ",
                                        hintStyle: MyText.body1(context)!
                                            .copyWith(color: MyColors.grey_40)),
                                  ),
                                ),
                                tourValue != 'NA'
                                    ? const SizedBox()
                                    : const Text('Place of Visit:',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.grey_95)),
                                Container(height: 10),
                                tourValue != 'NA'
                                    ? const SizedBox()
                                    : Container(
                                        height: 45,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: TextField(
                                          textInputAction: TextInputAction.next,
                                          onSubmitted: (value) {},
                                          maxLines: 1,
                                          controller: _visitController,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(-12),
                                              border: InputBorder.none,
                                              hintText: "Place of visit",
                                              hintStyle: MyText.body1(context)!
                                                  .copyWith(
                                                      color: MyColors.grey_40)),
                                        ),
                                      ),
                                _validateVisit
                                    ? const Text('Please fill place of visit',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                tourValue != 'NA'
                                    ? const SizedBox()
                                    : const SizedBox(
                                        height: 15,
                                      ),
                                tourValue != 'NA'
                                    ? const SizedBox()
                                    : const Text('Purpose of Visit',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.grey_95)),
                                tourValue != 'NA'
                                    ? const SizedBox()
                                    : Container(height: 10),
                                tourValue != 'NA'
                                    ? const SizedBox()
                                    : Container(
                                        height: 45,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: TextField(
                                          textInputAction: TextInputAction.next,
                                          onSubmitted: (value) {},
                                          maxLines: 1,
                                          controller: _purposeController,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(-12),
                                              border: InputBorder.none,
                                              hintText: "Purpose of visit",
                                              hintStyle: MyText.body1(context)!
                                                  .copyWith(
                                                      color: MyColors.grey_40)),
                                        ),
                                      ),
                                _validatePurpose
                                    ? const Text('Please fill purpose of visit',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 45,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF8A2724),
                                        elevation: 0),
                                    child: Text("Submit",
                                        style: MyText.subhead(context)!
                                            .copyWith(color: Colors.white)),
                                    onPressed: () async {
                                      setState(() {
                                        tourValue != null
                                            ? _validateTourId = false
                                            : _validateTourId = true;
            
                                        _fromController.text.isNotEmpty
                                            ? _validateFrom = false
                                            : _validateFrom = true;
                                        _toController.text.isNotEmpty
                                            ? _validateTo = false
                                            : _validateTo = true;
                                        _daController.text.isNotEmpty
                                            ? _validateDA = false
                                            : _validateDA = true;
                                        _daysController.text.isNotEmpty
                                            ? _validateDays = false
                                            : _validateDays = true;
                                        _nightController.text.isNotEmpty
                                            ? _validateNights = false
                                            : _validateNights = true;
            
                                        if (tourValue == 'NA') {
                                          _visitController.text.isNotEmpty
                                              ? _validateVisit = false
                                              : _validateVisit = true;
                                          _purposeController.text.isNotEmpty
                                              ? _validatePurpose = false
                                              : _validatePurpose = true;
                                          stateValue != null
                                              ? _validatestate = false
                                              : _validatestate = true;
                                          districtValue != null
                                              ? _validateDistrict = false
                                              : _validateDistrict = true;
                                          blockValue != null
                                              ? _validateblock = false
                                              : _validateblock = true;
                                        }
                                      });
                                      if (!_validatestate &&
                                          !_validateDA &&
                                          !_validateDistrict &&
                                          !_validateFrom &&
                                          !_validateTo &&
                                          !_validatePurpose &&
                                          !_validateVisit &&
                                          !_validateblock) {
                                        isLoading.value = true;
                                        var rsp = await insert_da(
                                          stateValue.toString(),
                                          districtValue.toString(),
                                          blockValue.toString(),
                                          _fromController.text,
                                          _toController.text,
                                          _daController.text,
                                          _visitController.text,
                                          _purposeController.text,
                                          tourValue.toString(),
                                          GetStorage().read('userId').toString(),
                                          _remarksController.text,
                                          _daysController.text,
                                          _nightController.text,
                                        );
                                        if (rsp['status'].toString() == '1') {
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
                                            tourValue = null;
                                            _fromController.clear();
                                            _toController.clear();
                                            _daController.clear();
                                            _visitController.clear();
                                            _purposeController.clear();
                                            _daysController.clear();
                                            _nightController.clear();
                                            _remarksController.clear();
                                          });
                                        } else {
                                          print('something went wrong');
                                        }
                                       }},
                                  ),
                                )
                              ],
                            ),
                          ),
            ),
            
          ));
  }

  
}

//*********************Bottom sheet to add staff da***************************



//*************dropdown for staff *************************************


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
    print(tourid);
    print(userid);
    print(remarks);
    print(nodays);
    print(nonights);

    var response =
        await http.post(Uri.parse(MyColors.baseUrl + 'da.php'), headers: {
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
    var convertedDatatoJson = jsonDecode(response.body);
    return convertedDatatoJson;
  }
