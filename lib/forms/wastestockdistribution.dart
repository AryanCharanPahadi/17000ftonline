// ignore_for_file: unnecessary_null_comparison, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:old17000ft/Controllers/pendingExpenses_Controller.dart';
import 'package:old17000ft/Controllers/school_Controller.dart';
import 'package:old17000ft/Controllers/stockdispatch_controller.dart';
import 'package:old17000ft/Model/school_data.dart';
import 'package:old17000ft/custom_dialog.dart';
import 'dart:convert';
import '../Controllers/stockAllocationController.dart';
import '../Model/newStock_dispatch.dart';
import '../colors.dart';
import '../home_screen.dart';
import '../my_text.dart';
import 'da.dart';

final StateController _stateController = Get.put(StateController());
final DistrictController _districtController = Get.put(DistrictController());
final BlockController _blockController = Get.put(BlockController());
final StaffController staffController = Get.put(StaffController());
final SchoolController schoolController = Get.put(SchoolController());

class StockDistribution extends StatefulWidget {
  const StockDistribution({Key? key}) : super(key: key);

  @override
  _StockDistributionState createState() => _StockDistributionState();
}

class _StockDistributionState extends State<StockDistribution> {
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _noOfDayController = TextEditingController();

  final bool _validatestate = false;
  final bool _validateTourId = false;

  final bool _validateblock = false;
  final bool _validateDistrict = false;
  final bool _validateFrom = false;
  final bool _validateTo = false;
  final bool _validateDA = false;
  final bool _validateDays = false;

  final bool _validateVisit = false;
  final bool _validatePurpose = false;
  String? _districtName;
  String? _state;
  String? _blockName;
  String? _programName;
  String? _fromDate;
  String? _toDate;

  String? stateValue;
  String? districtValue;
  String? blockValue;
  String? itemqtyValue;
  String? schoolValue;

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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF8A2724),
          title: const Text(
            'Stock Distribution jkj',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        body: GetBuilder<StockAllocationController>(
            init: StockAllocationController(),
            builder: (stockAllocationController) {
              stockAllocationController.filterList();
              return Obx(
                () => staffController.isLoading.value || isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('State:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_95)),
                              GetBuilder<StateController>(
                                  init: StateController(),
                                  builder: (stateController) {

                                    return Container(
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
                                          items: stateInfoController.stateInfo
                                              .map((value) {
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
                                    );
                                  }),
                              _validatestate
                                  ? const Text('Please select State',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red))
                                  : const SizedBox(),
                              const Text('District:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_95)),
                              GetBuilder<DistrictController>(
                                  init: DistrictController(),
                                  builder: (districtController) {

                                    return Container(
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
                                          items: stateInfoController.stateInfo
                                              .where((element) =>
                                                  element.stateName ==
                                                  stateValue)
                                              .map((value) {
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
                                    );
                                  }),
                              _validateDistrict
                                  ? const Text('Please select District',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red))
                                  : const SizedBox(),
                              const Text('Block Name:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_95)),
                              GetBuilder<BlockController>(
                                  init: BlockController(),
                                  builder: (blockController) {
                                    return Container(
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
                                          items: stateInfoController.stateInfo
                                              .where((element) =>
                                                  element.districtName ==
                                                  districtValue)
                                              .map((value) {
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
                                              // Get.find<
                                              //         StockAllocationController>()
                                              //     .filterSchoolName(data!);
                                            });
                                          },
                                        ),
                                      ]),
                                    );
                                  }),
                              _validateblock
                                  ? const Text('Please select a Block',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red))
                                  : const SizedBox(),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text('School name:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_95)),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                // width: 350,
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
                                  DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButton<String>(
                                        value: schoolValue,
                                        isExpanded: true,

                                        iconSize: 24,
                                        elevation: 2,

                                        hint: Text(
                                          'Select Schools',
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                        // ignore: can_be_null_after_null_aware
                                        items: Get.find<
                                                StockAllocationController>()
                                            .allocateSchool
                                            .map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value.schoolName,
                                            child: Text(value.schoolName!),
                                          );
                                        }).toList(),
                                        onChanged: (data) {
                                          setState(() {
                                            schoolValue = data;
                                          });
                                          // issueTrackerController.schoolSetter(data!);
                                        },
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                              Row(
                                children: <Widget>[
                                  const Text('Distribute Items',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.grey_95)),
                                  IconButton(
                                      onPressed: () {
                                        showDistributeSheet(
                                            context: context,
                                            title: 'Distibute Items');
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.green,
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              schoolController.itemsData!.isEmpty
                                  ? const SizedBox()
                                  : ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          schoolController.itemsData!.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          contentPadding:
                                              EdgeInsets.only(bottom: 8),
                                          title: Text(schoolValue == null
                                              ? ''
                                              : schoolValue!),
                                          subtitle: RichText(
                                              text: TextSpan(
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              new TextSpan(
                                                  text: schoolController
                                                          .itemsData![index]
                                                          .itemsName! +
                                                      "\n"),
                                              new TextSpan(
                                                  text: "Quantity: " +
                                                      schoolController
                                                          .itemsData![index]
                                                          .itemQty!,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
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
                                                  schoolController.itemsData!
                                                      .remove(schoolController
                                                          .itemsData![index]);
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
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: SizedBox(
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
                                      print("this is from data list");

                                      print(schoolController.itemsData);

                                      for (int i = 0;
                                          i <
                                              schoolController
                                                  .itemsData!.length;
                                          i++) {
                                        var rsp = await insert_distribution(
                                            stateValue!,
                                            districtValue!,
                                            blockValue!,
                                            schoolValue!,
                                            schoolController
                                                .itemsData![i].itemsName!,
                                            schoolController
                                                .itemsData![i].itemQty!,
                                            GetStorage()
                                                .read('username')
                                                .toString());
                                        if (i ==
                                            schoolController.itemsData!.length -
                                                1) {
                                          if (rsp['status'].toString() == '1') {
                                            isLoading.value = false;
                                            schoolController.itemsData!.clear();
                                            schoolValue = null;
                                            showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    const CustomEventDialog(
                                                        title: 'Home'));
                                            setState(() {
                                              schoolController.itemsData!
                                                  .clear();
                                              stateValue = null;
                                              districtValue = null;
                                              blockValue = null;
                                              tourValue = null;
                                              schoolValue = null;
                                              _qtyController.clear();
                                            });
                                          } else {
                                            print('something went wrong');
                                          }
                                        }
                                      }
                                      // var rsp = await insert_distribution(
                                      //   stateValue!,
                                      //   districtValue!,
                                      //   blockValue!,
                                      //   schoolValue!,
                                      //   itemnameValue!,
                                      //   _qtyController.text,
                                      //   GetStorage().read('username').toString(),
                                      // );

                                      // _stateController.toString(),
                                      // _districtController.toString(),
                                      // _blockController.toString(),
                                      // _fromController.text,
                                      // _toController.text,
                                      // _daController.text,
                                      // _visitController.text,
                                      // _purposeController.text

                                      // setState(() {
                                      //   _daController.clear();
                                      // });

                                      //     }
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                //  ),
              );
            }));
  }

  Future insert_distribution(
    String state,
    String dist,
    String block,
    String school,
    String itemname,
    String qty,
    String distributedBy,
  ) async {
    print('insert_distribution is called');
    print(state);
    print(dist);
    print(block);
    print(school);
    print(itemname);
    print(qty);

    var response = await http
        .post(Uri.parse(MyColors.baseUrl + 'insert_distribution.php'), headers: {
      "Accept": "Application/json"
    }, body: {
      'state': state,
      'district': dist,
      'block': block,
      'school': school,
      'items': itemname,
      'qty': qty,
      'distributed_by': distributedBy,
    });
    var convertedDatatoJson = jsonDecode(response.body);
    return convertedDatatoJson;
  }

  Container distributeqty(
    BuildContext context,
    String name,
    List<StockDispatch> data,
    int index,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(color: Colors.white, spreadRadius: 1, blurRadius: 5)
        ],
      ),
      child: Stack(children: [
        DropdownButton<String>(
          value: itemqtyValue,
          // stockdispatchController.dispatchList[0].itemQty.toString(),
          iconSize: 20,
          elevation: 2,
          hint: Text(
            name,
            style: const TextStyle(color: Colors.grey),
          ),
          // ignore: can_be_null_after_null_aware
          items: data.map((value) {
            print("this is value");
            print(value.itemQty.toString());
            return DropdownMenuItem<String>(
              value: value.itemQty.toString(),
              child: Text(value.itemQty.toString()),
            );
          }).toList(),
          onChanged: (data) {
            setState(() {
              itemqtyValue = data;
              //itemqtyValue = null;
            });

            // print("this is qty value");
            // print(itemqtyValue);
            // //issueTrackerController.schoolSetter(data!);
            // stockdispatchController.qtySetter(data!);
          },
        ),
      ]),
    );
  }

  Container distributeitems(
    BuildContext context,
    String name,
    List<StockDispatch> data,
    int index,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(color: Colors.white, spreadRadius: 1, blurRadius: 5)
        ],
      ),
      child: GetBuilder<StockDispatchController>(
          init: StockDispatchController(),
          builder: (stockDispatchController) {
            return Stack(children: [
              DropdownButton<String>(
                value: stockDispatchController.itemnameValue,
                iconSize: 20,
                elevation: 2,
                isExpanded: true,
                hint: Text(
                  name,
                  style: const TextStyle(color: Colors.grey),
                ),
                // ignore: can_be_null_after_null_aware
                items: data.map((value) {
                  return DropdownMenuItem<String>(
                    value: value.itemName,
                    child: Text(value.itemName!),
                  );
                }).toList(),
                onChanged: (data) {
                  stockDispatchController.setValue(data!);

                  //issueTrackerController.schoolSetter(data!);
                  // stockdispatchController.itemSetter(data!);
                },
              ),
            ]);
          }),
    );
  }

  Container dropSchool(
    BuildContext context,
    String name,
    List<SchoolData> data,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(color: Colors.white, spreadRadius: 1, blurRadius: 5)
        ],
      ),
      child: Stack(children: [
        DropdownButton<String>(
          value: schoolValue,

          iconSize: 24,
          elevation: 2,
          hint: Text(
            name,
            style: const TextStyle(color: Colors.grey),
          ),
          // ignore: can_be_null_after_null_aware
          items: data.map((value) {
            return DropdownMenuItem<String>(
              value: value.schoolName,
              child: Text(value.schoolName!),
            );
          }).toList(),
          onChanged: (data) {
            setState(() {
              schoolValue = data;
            });
            // issueTrackerController.schoolSetter(data!);
          },
        ),
      ]),
    );
  }

  void showDistributeSheet(
      {required BuildContext context, required String title}) {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        builder: (BuildContext context) {
          // ignore: prefer_const_constructors
          return GetBuilder<SchoolController>(
            init: schoolController,
            builder: (schoolController) {
              return Column(
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
                  // SizedBox(
                  //   width: 400,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       // ignore: unnecessary_const
                  //       SizedBox(
                  //         // width: 466,
                  //         child: dropSchool(context, 'Select Schools',
                  //             Get.find<SchoolController>().filterd),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 200,
                          child: distributeitems(
                              context,
                              'Select Items',
                              Get.find<StockDispatchController>().dispatchList,
                              2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {},
                              maxLines: 1,
                              controller: _qtyController,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(-12),
                                  border: InputBorder.none,
                                  hintText: "Quantity",
                                  hintStyle: MyText.body1(context)!
                                      .copyWith(color: MyColors.grey_40)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8A2724), elevation: 0),
                        child: Text("Add",
                            style: MyText.subhead(context)!
                                .copyWith(color: Colors.white)),
                        onPressed: () async {
                          AddItems data = AddItems(
                            // itemRecievedId: ,
                            itemsName: Get.find<StockDispatchController>()
                                .itemnameValue!,
                            itemQty: _qtyController.text,
                          );

                          schoolController.addItemsData(data);
                          setState(() {
                            Get.find<StockDispatchController>().setValue('');
                            _qtyController.clear();
                          });

                          Navigator.of(context).pop();
                        }),
                  ),
                ],
              );
            },
          );
        });
  }
}
