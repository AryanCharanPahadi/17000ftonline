// ignore_for_file: deprecated_member_use, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:multiselect/multiselect.dart';
import 'package:old17000ft/Controllers/school_Controller.dart';
import 'package:old17000ft/Model/distribution.dart';
import '../Controllers/state_Controller.dart';
import '../Controllers/stockAllocationController.dart';
import '../Controllers/stockSchoolRecievedController.dart';
import '../Model/blockModel.dart';
import '../colors.dart';
import '../custom_dialog.dart';
import '../my_text.dart';
import 'da.dart';

StockRecievedController stockRecievedController =
    Get.put(StockRecievedController());

class StockSchoolReceived extends StatefulWidget {
  const StockSchoolReceived({super.key});

  @override
  State<StockSchoolReceived> createState() => _StockSchoolReceivedState();
}

class _StockSchoolReceivedState extends State<StockSchoolReceived> {
  var isLoading = false.obs;
  bool isLoadingg = false;
  String? stateValue;
  String? blockValue;
  String? districtValue;
  String? schoolValue;
  String? dropdownValue4;
  String? itemValue;
  String? itemId;
  int? allocateQty;

  String? receiverCommonId;

  bool _validateState = false;
  bool _validateSchool = false;
  bool _validateDistrict = false;
  bool _validateBlock = false;
  bool _validateDistributionDate = false;
  bool _validateReceiverName = false;
  bool _validateDesignation = false;
  bool _validatePhone = false;
  bool _validateItem = false;
  bool _validateQty = false;
  bool _validateAllocateQty = false;

  bool _validateRemarks = false;

  final TextEditingController _distributionDateController =
      TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _recieverController = TextEditingController();

  List<String> itemNames = [];
  List<String> uniqueId = [];
  List<String> itemQty = [];
  List<String> receiveCommonId = [];
    List<String> remarksList = [];
  
  String? itemnameString;
  String? itemqtyString;
  String? receiveCommonIdString;
  String? uniqueIdString;
  String? remarksString;
  
  List<String> selected = [];
  List<String> selectedBlock = [];

  final StockAllocationController _stockAllocationController =
      Get.put(StockAllocationController());

  DateTime selectedDate = DateTime.now(), initialDate = DateTime.now();

  _selectDate(BuildContext context, TextEditingController date) async {
    final DateTime? selectedd = await showDatePicker(
      locale: const Locale('en', 'IN'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
      builder: (context, picker) {
        return Theme(data: theme, child: picker!);
      },
    );
    if (selectedd != null) {
      setState(() {
        selectedDate = selectedd;
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        date.text = formattedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _stockAllocationController
        .fetchStockAllocation()
        .then((_) => _stockAllocationController.filterList());
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Stock Distribution',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF8A2724),
        ),
        body: GetBuilder<StateInfoController>(
            init: StateInfoController(),
            builder: (stateInfoController) {
              var seen = <String>{};
              List<StateInfo> uniqueState = [];
              List<StateInfo> uniqueDistrict = [];
              List<StateInfo> uniqueBlock = [];
              List<StateInfo> uniqueBlock2 = [];

              uniqueState = stateInfoController.stateInfo
                  .where((student) => student.stateName != 'GURUGRAM')
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

              if (selected.isNotEmpty) {
                for (int i = 0; i < selected.length; i++) {
                 
                  uniqueBlock = stateInfoController.stateInfo
                      .where((student) => student.districtName == selected[i])
                      .toList();

                  uniqueBlock2 = uniqueBlock2 + uniqueBlock;
                  // .where((student) => seen.add(student.blockName!))
                  // .toList();
                }
              }
              return GetBuilder<StockAllocationController>(
                  init: StockAllocationController(),
                  builder: (stockAllocationController) {
                    stockAllocationController.filterList();
                    return stockAllocationController.isLoading ||
                            isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : stockAllocationController.allocateList.isEmpty
                            ? Center(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 300,
                                    ),
                                    const Center(
                                        child: Text(
                                      'No Data Found',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                    TextButton(
                                        onPressed: () async {
                                          stockAllocationController
                                              .fetchStockAllocation();
                                        },
                                        child: const Text('Tap to Refresh',
                                            style: TextStyle(
                                                color: Color(0xFF8A2724))))
                                  ],
                                ),
                              )
                            : SingleChildScrollView(
                                padding: const EdgeInsets.all(20),
                                scrollDirection: Axis.vertical,
                                child: Align(
                                  child: Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          text('State'),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                                                items: uniqueState.map((value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value.stateName
                                                        .toString(),
                                                    child: Text(value.stateName
                                                        .toString()),
                                                  );
                                                }).toList(),

                                                onChanged: (data) {
                                                  setState(() {
                                                    stateValue = data;
                                                    districtValue = null;
                                                    blockValue = null;
                                                    selected.clear();
                                                    selectedBlock.clear();
                                                  });
                                                },
                                              ),
                                            ]),
                                          ),
                                          _validateState
                                              ? const Text(
                                                  'Please select State',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red))
                                              : const SizedBox(),

                                          //district field
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          text('Select District'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.white,
                                                    spreadRadius: 1,
                                                    blurRadius: 5)
                                              ],
                                            ),
                                            child: Stack(children: [
                                              DropDownMultiSelect(
                                                onChanged: (List<String> x) {
                                                  setState(() {
                                                    selected = x;
                                                    selectedBlock.clear();
                                                   
                                                  });
                                                },
                                               
                                                options: uniqueDistrict
                                                    .map((e) => e.districtName!)
                                                    .toList(),
                                                
                                                selectedValues: selected,
                                                selectedValuesStyle: const TextStyle(fontSize: 12,color: Colors.transparent),
                                               hint: const Text( 'Select District'),
                                              ),
                                            ]),
                                          ),
                                          _validateDistrict
                                              ? const Text(
                                                  'Please select District',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red))
                                              : const SizedBox(),

                                          //block Value
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          text('Select Block'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Stack(children: [
                                            DropDownMultiSelect(
                                              onChanged: (List<String> x) {
                                                setState(() {
                                                  selectedBlock = x;
                                                  Get.find<
                                                          StockAllocationController>()
                                                      .filterSchoolName(
                                                          selectedBlock);
                                                  schoolValue = null;
                                                  
                                                });
                                              },
                                             
                                                
                                              options: uniqueBlock2
                                                  .map((e) => e.blockName!)
                                                  .toList(),
                                              selectedValues: selectedBlock,
                                               selectedValuesStyle: const TextStyle(fontSize: 12,color: Colors.transparent),
                                              hint: const Text( 'Select Block'),
                                            ),
                                          ]),
                                          _validateBlock
                                              ? const Text(
                                                  'Please select Block ',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red))
                                              : const SizedBox(),

                                          const SizedBox(
                                            height: 10,
                                          ),
                                          //school Value
                                          text('Select School'),

                                          const SizedBox(
                                            height: 10,
                                          ),
                                          GetBuilder<SchoolController>(
                                              init: SchoolController(),
                                              builder: (schoolController) {
                                                return Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.9,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color: Colors.white,
                                                          spreadRadius: 1,
                                                          blurRadius: 5)
                                                    ],
                                                  ),
                                                  child: Stack(children: [
                                                    DropdownButton<String>(
                                                      value: schoolValue,
                                                      iconSize: 24,
                                                      elevation: 2,
                                                      isExpanded: true,
                                                      hint: Text(
                                                        'Select School'.tr,
                                                        style: const TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                      // ignore: can_be_null_after_null_aware
                                                      items: Get.find<
                                                              StockAllocationController>()
                                                          .finalallocateSchool1
                                                          .map((value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value
                                                              .schoolName
                                                              .toString(),
                                                          child: (Text(value
                                                              .schoolName
                                                              .toString())),
                                                        );
                                                      }).toList(),
                                                      onChanged: (data) {
                                                        setState(() {
                                                          schoolValue = data;
                                                          stockAllocationController
                                                              .getItemsName(
                                                                  data);
                                                          // dropdownValue4 = null;
                                                        });
                                                      },
                                                    ),
                                                  ]),
                                                );
                                              }),
                                          _validateSchool
                                              ? const Text(
                                                  'Please select School',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red))
                                              : const SizedBox(),
                                          text('Distribution Date'),
                                          Container(height: 10),
                                          Container(
                                            height: 45,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4))),
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              children: <Widget>[
                                                Container(width: 15),
                                                Expanded(
                                                  child: TextFormField(
                                                    onChanged: (value) =>
                                                        setState(() {}),
                                                    readOnly: true,
                                                    onTap: () {
                                                      _selectDate(context,
                                                          _distributionDateController);
                                                    },
                                                    maxLines: 1,
                                                    keyboardType:
                                                        TextInputType.datetime,
                                                    controller:
                                                        _distributionDateController,
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(-12),
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "Distribution Date(dd-mm-yyyy)",
                                                        hintStyle: MyText.body1(
                                                                context)!
                                                            .copyWith(
                                                                color: MyColors
                                                                    .grey_40)),
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      FocusScopeNode
                                                          currentFocus =
                                                          FocusScope.of(
                                                              context);

                                                      if (!currentFocus
                                                          .hasPrimaryFocus) {
                                                        currentFocus.unfocus();
                                                      }
                                                      _selectDate(context,
                                                          _distributionDateController);
                                                    },
                                                    icon: const Icon(
                                                        Icons.calendar_today,
                                                        color:
                                                            MyColors.grey_40))
                                              ],
                                            ),
                                          ),
                                          _validateDistributionDate
                                              ? const Text('Please select date',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red))
                                              : const SizedBox(),
                                          Container(height: 15),
                                          text('Reciever Name'),
                                          TextFormField(
                                            controller: _recieverController,
                                            // keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        top: -12, left: 6),
                                                // border: new OutlineInputBorder(
                                                //     borderSide: new BorderSide(
                                                //         color: Colors.teal)),
                                                hintText: "Enter Reciever Name",
                                                hintStyle:
                                                    MyText.body1(context)!
                                                        .copyWith(
                                                            color: MyColors
                                                                .grey_40)),
                                          ),
                                          _validateReceiverName
                                              ? const Text(
                                                  'Please fill Receiver Name',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red))
                                              : const SizedBox(),
                                          Container(height: 10),
                                          text('Reciever Designation'),
                                          TextFormField(
                                            controller: _designationController,
                                            // keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        top: -12, left: 6),
                                                // border: new OutlineInputBorder(
                                                //     borderSide: new BorderSide(
                                                //         color: Colors.teal)),
                                                hintText: "Enter Designation",
                                                hintStyle:
                                                    MyText.body1(context)!
                                                        .copyWith(
                                                            color: MyColors
                                                                .grey_40)),
                                          ),
                                          _validateDesignation
                                              ? const Text(
                                                  'Please fill Receiver Designation',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red))
                                              : const SizedBox(),
                                          Container(height: 10),

                                          text('Reciever Phone'),
                                          TextFormField(
                                            controller: _phoneController,
                                            maxLength: 10,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        top: -12, left: 6),
                                                // border: new OutlineInputBorder(
                                                //     borderSide: new BorderSide(
                                                //         color: Colors.teal)),
                                                hintText:
                                                    "Enter Reciever Phone Number",
                                                hintStyle:
                                                    MyText.body1(context)!
                                                        .copyWith(
                                                            color: MyColors
                                                                .grey_40)),
                                          ),
                                          _validatePhone
                                              ? const Text(
                                                  'Please fill Receiver Phone',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red))
                                              : const SizedBox(),

                                          Container(height: 10),
                                          schoolValue != null
                                              ? Row(
                                                  children: [
                                                    const Text(
                                                        'Distribute Items to School :',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: MyColors
                                                                .grey_95)),
                                                    IconButton(
                                                        onPressed: () {
                                                          showHouseSheet(
                                                            context: context,
                                                            title:
                                                                'Distribute Items to School',
                                                            uniqueId:
                                                                'uniqueId',
                                                          );
                                                          // stockAllocationController
                                                          //     .getItemsName(
                                                          //         schoolValue);
                                                        },
                                                        icon: const Icon(
                                                          Icons.add,
                                                          color:
                                                              Color(0xFF8A2724),
                                                        ))
                                                  ],
                                                )
                                              : const SizedBox(),

                                          GetBuilder<StockAllocationController>(
                                              init: StockAllocationController(),
                                              builder:
                                                  (stockAllocationController) {
                                                return ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      stockAllocationController
                                                          .stockDistributionItem
                                                          .length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var textStyle =
                                                        const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold);

                                                    return ListTile(
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                              bottom: 8),
                                                      title: Text(
                                                        "Item Name: ${stockAllocationController.stockDistributionItem[index].itemName}",
                                                        style: const TextStyle(
                                                            fontSize: 14.0,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      // subtitle: RichText(
                                                      //     text: TextSpan(
                                                      //   // ignore: prefer_const_constructors
                                                      //   style: TextStyle(
                                                      //     fontSize: 14.0,
                                                      //     color: Colors.black,
                                                      //   ),
                                                      //   children: <TextSpan>[
                                                      //     //ignore: unnecessary_new
                                                      //     new TextSpan(
                                                      //         text: stockAllocationController
                                                      //             .stockDistributionItem[
                                                      //                 index]
                                                      //             .itemName,
                                                      //         style: textStyle),
                                                      //     TextSpan(
                                                      //         text: stockAllocationController
                                                      //             .stockDistributionItem[
                                                      //                 index]
                                                      //             .itemQty,
                                                      //         style: textStyle),
                                                      //   ],
                                                      // )),
                                                      subtitle: Text(
                                                        "Item Qty: ${stockAllocationController.stockDistributionItem[index].itemQty}",
                                                        style: const TextStyle(
                                                            fontSize: 14.0,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      leading: Text(
                                                        '(${index + 1})',
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      trailing: IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              stockAllocationController
                                                                  .removeStockDistribution(
                                                                      stockAllocationController
                                                                              .stockDistributionItem[
                                                                          index]);
                                                            });
                                                          },
                                                          icon: const Icon(
                                                            Icons.delete,
                                                            size: 20,
                                                            color: Colors.red,
                                                          )),
                                                      // selectedTileColor:
                                                      //     Colors.green[400],
                                                      // onTap: () {
                                                      //   setState(() {});
                                                      // },
                                                    );
                                                  },
                                                );
                                              }),

                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                              width: double.infinity,
                                              height: 45,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              const Color(
                                                                  0xFF8A2724),
                                                          elevation: 0),
                                                  child: Text("Submit",
                                                      style: MyText.subhead(
                                                              context)!
                                                          .copyWith(
                                                              color: Colors
                                                                  .white)),
                                                  onPressed: () async {
                                                    setState(() {
                                                      isLoadingg = true;
                                                      isLoadingg == true
                                                          ? const CircularProgressIndicator()
                                                          : const SizedBox();
                                                      stateValue!.isEmpty
                                                          ? _validateState =
                                                              true
                                                          : _validateState =
                                                              false;
                                                      selected.isEmpty
                                                          ? _validateDistrict =
                                                              true
                                                          : _validateDistrict =
                                                              false;
                                                      schoolValue!.isEmpty
                                                          ? _validateSchool =
                                                              true
                                                          : _validateSchool =
                                                              false;
                                                      selectedBlock.isEmpty
                                                          ? _validateBlock =
                                                              true
                                                          : _validateBlock =
                                                              false;
                                                      _distributionDateController
                                                              .text.isEmpty
                                                          ? _validateDistributionDate =
                                                              true
                                                          : _validateDistributionDate =
                                                              false;
                                                      _recieverController
                                                              .text.isEmpty
                                                          ? _validateReceiverName =
                                                              true
                                                          : _validateReceiverName =
                                                              false;
                                                      _designationController
                                                              .text.isEmpty
                                                          ? _validateDesignation =
                                                              true
                                                          : _validateDesignation =
                                                              false;
                                                      _phoneController
                                                              .text.isEmpty
                                                          ? _validatePhone =
                                                              true
                                                          : _validatePhone =
                                                              false;
                                                    });
                                                    if (!_validateState &&
                                                        !_validateDistrict &&
                                                        !_validateBlock &&
                                                        !_validateSchool &&
                                                        !_validateDistributionDate &&
                                                        !_validateReceiverName &&
                                                        !_validateDesignation &&
                                                        !_validatePhone) {
                                                      isLoading.value = true;
                                                      for (int i = 0;
                                                          i <
                                                              _stockAllocationController
                                                                  .stockDistributionItem
                                                                  .length;
                                                          i++) {
                                                            print("IDS ");
                                                            
                                                        itemNames.add(
                                                            _stockAllocationController
                                                                .stockDistributionItem[
                                                                    i]
                                                                .itemName!);

                                                       itemnameString =
                                                            itemNames
                                                                .toString()
                                                                .replaceAll(
                                                                    "[", "")
                                                                .replaceAll(
                                                                    "]", "");

                                                        itemQty.add(
                                                            _stockAllocationController
                                                                .stockDistributionItem[
                                                                    i]
                                                                .itemQty!);
                                                        itemqtyString =
                                                            itemQty
                                                                .toString()
                                                                .replaceAll(
                                                                    "[", "")
                                                                .replaceAll(
                                                                    "]", "");
                                                        uniqueId.add(
                                                            _stockAllocationController
                                                                .stockDistributionItem[
                                                                    i]
                                                                .itemUniqueId!);
                                                        uniqueIdString =
                                                            uniqueId
                                                                .toString()
                                                                .replaceAll(
                                                                    "[", "")
                                                                .replaceAll(
                                                                    "]", "");
                                                                    
                                                           remarksList.add(
                                                            _stockAllocationController
                                                                .stockDistributionItem[
                                                                    i]
                                                                .remarks!);
                                                        remarksString =
                                                            remarksList
                                                                .toString()
                                                                .replaceAll(
                                                                    "[", "")
                                                                .replaceAll(
                                                                    "]", "");

                                                        receiveCommonId.add(
                                                            _stockAllocationController
                                                                .stockDistributionItem[
                                                                    i]
                                                                .recievedCommonId!);
                                                        receiveCommonIdString =
                                                            receiveCommonId
                                                                .toString()
                                                                .replaceAll(
                                                                    "[", "")
                                                                .replaceAll(
                                                                    "]", "");

                                                                    // print("IDS ");
                                                                    // print(uniqueIdString);
                                                                    // print(receiveCommonIdString
                                                                      
                                                                   // );


                                                          }       

                                                        var rsp =
                                                            await insert_StockDistribution(
                                                          _stockAllocationController
                                                              .stockDistributionItem[
                                                                  0]
                                                              .stateName!,
                                                          _stockAllocationController
                                                              .stockDistributionItem[
                                                                  0]
                                                              .districtName!,
                                                          _stockAllocationController
                                                              .stockDistributionItem[
                                                                  0]
                                                              .blockName!,
                                                          _stockAllocationController
                                                              .stockDistributionItem[
                                                                  0]
                                                              .schoolName!,
                                                          _stockAllocationController
                                                              .stockDistributionItem[
                                                                  0]
                                                              .distributionDate!,
                                                          _stockAllocationController
                                                              .stockDistributionItem[
                                                                  0]
                                                              .receiverName!,
                                                          _stockAllocationController
                                                              .stockDistributionItem[
                                                                  0]
                                                              .receiverDesignation!,
                                                          _stockAllocationController
                                                              .stockDistributionItem[
                                                                  0]
                                                              .receiverPhone,
                                                          itemnameString,
                                                          itemqtyString,
                                                          remarksString,
                                                          // _stockAllocationController
                                                          //     .stockDistributionItem[
                                                          //         i]
                                                          //     .itemUniqueId,
                                                          uniqueIdString,
                                                        receiveCommonIdString,
                                                        );

                                                        if (rsp['status'] ==
                                                            '1') {
                                                          // if (i ==
                                                          //     _stockAllocationController
                                                          //             .stockDistributionItem
                                                          //             .length -
                                                          //         1) {
                                                          //           print('last record is going to be insert $i');
                                                          //   // This is the last record, apply your condition here
                                                          //   // For example:

                                                            if (rsp['status'] ==
                                                                '1') {
                                                              isLoading.value =
                                                                  false;
                                                              _stockAllocationController
                                                                  .stockDistributionItem
                                                                  .clear();
                                                              print(
                                                                  'Inserted Successfully');
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (_) =>
                                                                      const CustomEventDialog(
                                                                        title:
                                                                            'Home',
                                                                        //head: 'Submit',
                                                                        desc:
                                                                            'Data Submit Successfully',
                                                                      ));
                                                            } else {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      title: const Text(
                                                                          'Something Went Wrong'),
                                                                      content:
                                                                          const Text(
                                                                              'Try Again!!'),
                                                                      actions: <Widget>[
                                                                        ElevatedButton(
                                                                          child:
                                                                              const Text('OK'),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        )
                                                                      ],
                                                                    );
                                                                  });
                                                            }
                                                          }
                                                        } else{
                                                          showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      title: const Text(
                                                                          'Something Went Wrong'),
                                                                      content:
                                                                          const Text(
                                                                              'Try Again!!'),
                                                                      actions: <Widget>[
                                                                        ElevatedButton(
                                                                          child:
                                                                              const Text('OK'),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        )
                                                                      ],
                                                                    );
                                                                  });
                                                        }
                                                      // }
                                                    // }
                                                  })),
                                        ],
                                      )),
                                ));
                  });
            }));
  }

  void showHouseSheet(
      {required BuildContext context,
      required String title,
      required String uniqueId}) {
    // List<String> _itemName = ['solar Panel', 'Library Rack'];

    showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        builder: (BuildContext context) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: GetBuilder<StockAllocationController>(
              init: StockAllocationController(),
              builder: (stockAllocationController) {
                return StatefulBuilder(
                    builder: (BuildContext context, setState) {
                  return LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
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
                              const SizedBox(
                                height: 10,
                              ),
                              text('Select Item'),
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
                                    value: itemValue,
                                    iconSize: 24,
                                    elevation: 2,
                                    hint: Text(
                                      'Select Item'.tr,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    // ignore: can_be_null_after_null_aware
                                    items: _stockAllocationController
                                        .filteritemsName
                                        .map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value.toString(),
                                        child: Text(value.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (data) {
                                      setState(() {
                                        _stockAllocationController
                                            .getUniqueId(data);
                                        itemValue = data;
                                        itemId =
                                            _stockAllocationController.itemsId;
                                        allocateQty = int.parse(
                                            _stockAllocationController
                                                .allocateQty!);
                                        receiverCommonId =
                                            _stockAllocationController
                                                .receiverCommonId;
                                      });
                                    },
                                  ),
                                ]),
                              ),
                              _validateItem
                                  ? const Text('Please select an Item',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red))
                                  : const SizedBox(),
                              const SizedBox(
                                height: 10,
                              ),
                              text('Enter Quantity'),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _qtyController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        top: -12, left: 6),
                                    // border: new OutlineInputBorder(
                                    //     borderSide: new BorderSide(
                                    //         color: Colors.teal)),
                                    hintText: "Enter recieved quantity",
                                    hintStyle: MyText.body1(context)!
                                        .copyWith(color: MyColors.grey_40)),
                              ),
                              _validateQty
                                  ? const Text('Please fill item Quantity',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red))
                                  : _validateAllocateQty
                                      ? Text(
                                          'Available Qty is ${allocateQty.toString()}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red))
                                      : const SizedBox(),
                              text('Remarks '),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _remarksController,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        top: -12, left: 6),
                                    // border: new OutlineInputBorder(
                                    //     borderSide: new BorderSide(
                                    //         color: Colors.teal)),
                                    hintText: "Enter remarks",
                                    hintStyle: MyText.body1(context)!
                                        .copyWith(color: MyColors.grey_40)),
                              ),
                              _validateRemarks
                                  ? const Text('Please fill remarks',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red))
                                  : const SizedBox(),
                              SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF8A2724),
                                        elevation: 0),
                                    child: Text("Add",
                                        style: MyText.subhead(context)!
                                            .copyWith(color: Colors.white)),
                                    onPressed: () async {
                                      setState(() {
                                        itemValue!.isEmpty
                                            ? _validateItem = true
                                            : _validateItem = false;
                                        _qtyController.text.isEmpty
                                            ? _validateQty = true
                                            : _validateQty = false;
                                        int.parse(_qtyController.text) >
                                                allocateQty!
                                            ? _validateAllocateQty = true
                                            : _validateAllocateQty = false;
                                        int.parse(_qtyController.text) >
                                                allocateQty!
                                            ? _qtyController.text =
                                                allocateQty.toString()
                                            : _validateAllocateQty = false;
                                        _remarksController.text.isEmpty
                                            ? _validateRemarks = true
                                            : _validateRemarks = false;
                                      });
                                      if (!_validateItem &&
                                          !_validateQty &&
                                          !_validateRemarks &&
                                          !_validateAllocateQty) {
                                        final blockString = selectedBlock
                                            .toString()
                                            .replaceAll("[", "")
                                            .replaceAll("]", "");
                                        final districtString = selected
                                            .toString()
                                            .replaceAll("[", "")
                                            .replaceAll("]", "");
                                        StockDistributionModel
                                            stockDistributionItemObj =
                                            StockDistributionModel(
                                          officeId:
                                              GetStorage().read('officeId'),
                                          stateName: stateValue.toString(),
                                          districtName:
                                              districtString.toString(),
                                          blockName: blockString.toString(),
                                          schoolName: schoolValue.toString(),
                                          receiverName: _recieverController.text
                                              .toString(),
                                          receiverDesignation:
                                              _designationController.text
                                                  .toString(),
                                          receiverPhone:
                                              _phoneController.text.toString(),
                                          itemName: itemValue.toString(),
                                          itemQty:
                                              _qtyController.text.toString(),
                                          distributedBy:
                                              GetStorage().read('userId'),
                                          distributionDate:
                                              _distributionDateController.text
                                                  .toString(),
                                          remarks: _remarksController.text
                                              .toString(),
                                          recievedCommonId:
                                              receiverCommonId.toString(),
                                          itemUniqueId: itemId.toString(),
                                        );
                                        _stockAllocationController
                                            .addStockDistribution(
                                                stockDistributionItemObj);
                                        setState(() {});
                                        _qtyController.clear();
                                        itemValue = null;
                                        _remarksController.clear();
                                        // _designationController.clear();
                                        // _distributionDateController.clear();

                                        Navigator.pop(context);
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
            ),
          );
        });
  }

  RichText text(String value) {
    return RichText(
        text: TextSpan(
            text: '',
            style: const TextStyle(
                //letterSpacing: 3,
                color: Colors.black,
                fontWeight: FontWeight.w400),
            children: [
          TextSpan(
              text: value,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: MyColors.grey_95)),
          const TextSpan(
              text: '  *',
              style: TextStyle(
                  fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold))
        ]));
  }

  Future insert_StockDistribution(
    String? state,
    String? district,
    String? block,
    String? school,
    String? distributionDate,
    String? receiverName,
    String? recevierDesignation,
    String? receiverPhone,
    String? itemName,
    String? itemQty,
    String? remarks,
    String? itemuniqueId,
    String? receiveCommonId,
    // String? dispatchCommonId,
    // String? purchaseId,
  ) async {
    // print('this is insertion of stock distribution');
    // print(state);
    // print(district);
    // print(block);
    // print(school);
    // print(distributionDate);
    // print(receiverName);
    // print(recevierDesignation);
    // print(receiverPhone);
    // print(itemName);
    // print(itemQty);
    // print(remarks);
    // print(itemuniqueId);
    // print(receiveCommonId);

    var response = await http.post(
        Uri.parse('${MyColors.baseUrl}insert_distribution.php'),
        headers: {
          "Accept": "Application/json"
        },
        body: {
          'office_id': GetStorage().read('officeId'),
          'office_name': GetStorage().read('office'),
          'state_name': state.toString(),
          'dist_name': district.toString(),
          'block_name': block.toString(),
          'school_name': school.toString(),
          'facilitator_id': GetStorage().read('userId'),
          'distribution_date': distributionDate.toString(),
          'receiver_name': receiverName.toString(),
          'receiver_designation': recevierDesignation.toString(),
          'receiver_phone': receiverPhone.toString(),
          'item_name': itemName.toString(),
          'item_qty': itemQty.toString(),
          'remarks': remarks.toString(),
          'item_unique_id': itemuniqueId.toString(),
          'recieved_common_id': receiveCommonId.toString(),
        });
    print('this is response i got ffrom ${response.body}');
    var convertedDatatoJson = jsonDecode(response.body);
    return convertedDatatoJson;
  }
}// $_POST['office_id'] = '2';
// $_POST['office_name'] = 'Leh';
// $_POST['school_name'] = 'P\/S BUK';
// $_POST['recieved_common_id'] = ['LE/24-11-2022/001'];
// $_POST['item_unique_id'] = ['PG006'];
// $_POST['block_name'] = 'Durbuk';
// $_POST['dist_name'] = 'Leh';
// $_POST['state_name'] = 'Ladakh';
// $_POST['item_name'] = ['SINGLE SLIDE WITH DOUBLE WAVE'];
// $_POST['item_qty'] = ['3'];
// $_POST['facilitator_id'] = '1';
// $_POST['distribution_date'] = '2022-11-24';
// $_POST['remarks'] = 'hey its remarks';
// $_POST['receiver_name'] = 'Priya';
// $_POST['receiver_designation'] = 'Dev';
// $_POST['receiver_phone'] = '9870543417';
