// ignore_for_file: unnecessary_null_comparison, unused_local_variable

import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:old17000ft/Controllers/school_Controller.dart';
import 'package:old17000ft/Controllers/state_Controller.dart';
import 'package:old17000ft/Model/blockModel.dart';
import '../Controllers/pendingExpenses_Controller.dart';
import '../colors.dart';
import 'package:http/http.dart' as http;
import '../custom_dialog.dart';
import '../home_screen.dart';
import '../my_text.dart';

final staffController = Get.put(StaffController());
final _stateController = Get.put(StateController());
final _schoolController = Get.put(StateController());
final TextEditingController _boyController = TextEditingController();
final TextEditingController _girlController = TextEditingController();
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
bool _validateState = false;
bool _validateDistrict = false;
bool _validateBlock = false;
bool _validateSchool = false;
bool _validateBoys = false;
bool _validateGirls = false;

List<GradeRow> graderowList = [
  GradeRow(
      grade: 'Nursery',
      boyController: TextEditingController(),
      girlController: TextEditingController()),
  GradeRow(
      grade: 'L.K.G',
      boyController: TextEditingController(),
      girlController: TextEditingController()),
  GradeRow(
      grade: 'U.K.G',
      boyController: TextEditingController(),
      girlController: TextEditingController()),
  GradeRow(
      grade: '1st',
      boyController: TextEditingController(),
      girlController: TextEditingController()),
  GradeRow(
      grade: '2nd',
      boyController: TextEditingController(),
      girlController: TextEditingController()),
  GradeRow(
      grade: '3rd',
      boyController: TextEditingController(),
      girlController: TextEditingController()),
  GradeRow(
      grade: '4th',
      boyController: TextEditingController(),
      girlController: TextEditingController()),
  GradeRow(
      grade: '5th',
      boyController: TextEditingController(),
      girlController: TextEditingController()),
  GradeRow(
      grade: '6th',
      boyController: TextEditingController(),
      girlController: TextEditingController()),
  GradeRow(
      grade: '7th',
      boyController: TextEditingController(),
      girlController: TextEditingController()),
  GradeRow(
      grade: '8th',
      boyController: TextEditingController(),
      girlController: TextEditingController()),
  GradeRow(
      grade: '9th',
      boyController: TextEditingController(),
      girlController: TextEditingController()),
  GradeRow(
      grade: '10th',
      boyController: TextEditingController(),
      girlController: TextEditingController()),
  GradeRow(
      grade: '11th',
      boyController: TextEditingController(),
      girlController: TextEditingController()),
  GradeRow(
      grade: '12th',
      boyController: TextEditingController(),
      girlController: TextEditingController()),
];

class SchoolEnrollment extends StatefulWidget {
  const SchoolEnrollment({Key? key}) : super(key: key);

  @override
  _SchoolEnrollmentState createState() => _SchoolEnrollmentState();
}

class _SchoolEnrollmentState extends State<SchoolEnrollment> {
  var isLoading = false.obs;
  String? stateValue;
  String? districtValue;
  String? blockValue;
  String? dropdownValue4;
  String? schoolValue;

  final TextEditingController _facilitatorController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  int grandTotalBoy = 0;
  int grandTotalGirl = 0;
  int grandTotal = 0;

  void totalGet() {
    grandTotalBoy = 0;
    grandTotalGirl = 0;
    grandTotal = 0;
    for (var element in graderowList) {
      if (element.boyController!.text.isNotEmpty) {
        grandTotalBoy += int.parse(element.boyController!.text);
      }
      if (element.girlController!.text.isNotEmpty) {
        grandTotalGirl += int.parse(element.girlController!.text);
      }

      grandTotal = grandTotalBoy + grandTotalGirl;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _facilitatorController.text = GetStorage().read('username');
    return GetBuilder<StateInfoController>(
        init: StateInfoController(),
        builder: (stateInfoController) {
          var seen = <String>{};
          List<StateInfo> uniqueState = [];
          List<StateInfo> uniqueDistrict = [];
          List<StateInfo> uniqueBlock = [];

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
            uniqueBlock = uniqueBlock
                .where((student) => seen.add(student.blockName!))
                .toList();
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF8A2724),
              title: const Text(
                'School Enrollment Form',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            body: Obx(
              () => staffController.isLoading.value || isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        height: 1000,
                        child: CustomScrollView(slivers: [
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(height: 10),
                                const Text(
                                  'Facilitator',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_95),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 45,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: TextField(
                                    textInputAction: TextInputAction.next,
                                    onSubmitted: (value) {},
                                    maxLines: 1,
                                    controller: _facilitatorController,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(-12),
                                        border: InputBorder.none,
                                        hintStyle: MyText.body1(context)!
                                            .copyWith(color: MyColors.grey_40)),
                                  ),
                                ),
                                //state field
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'State',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_95),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
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
                                          child:
                                              Text(value.stateName.toString()),
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
                                _validateState
                                    ? const Text('Please select State',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),

                                //district field
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'District',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_95),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
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
                                          child: Text(
                                              value.districtName.toString()),
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

                                //block Value
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Block',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_95),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
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
                                          value: value.blockName
                                              .toString()
                                              .replaceAll(',', ''),
                                          child: Text(
                                            value.blockName
                                                .toString()
                                                .replaceAll(',', ''),
                                          ),
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
                                _validateBlock
                                    ? const Text('Please select Block ',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),

                                const SizedBox(
                                  height: 10,
                                ),
                                //school Value
                                const Text(
                                  'School',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_95),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GetBuilder<SchoolController>(
                                    init: SchoolController(),
                                    builder: (schoolController) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                            items: schoolController.schoolList
                                                .where((element) =>
                                                    element.blockName ==
                                                    blockValue)
                                                .map((value) {
                                              return DropdownMenuItem<String>(
                                                value:
                                                    value.schoolName.toString(),
                                                child: (Text(value.schoolName
                                                    .toString())),
                                              );
                                            }).toList(),
                                            onChanged: (data) {
                                              setState(() {
                                                schoolValue = data;
                                                // dropdownValue4 = null;
                                              });
                                            },
                                          ),
                                        ]),
                                      );
                                    }),
                                _validateSchool
                                    ? const Text('Please select School',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        ' Grade',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.grey_95),
                                      ),
                                      Text(
                                        'Boys',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.grey_95),
                                      ),
                                      Text(
                                        'Girls',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.grey_95),
                                      ),
                                      Text(
                                        'Total ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.grey_95),
                                      ),
                                    ],
                                  ),
                                ),
                              

                                ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: graderowList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 30.0),
                                            child: SizedBox(
                                              width: 80,
                                              child: Text(
                                                graderowList[index].grade!,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: MyColors.grey_95),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 80,
                                            child: TextField(
                                              controller: graderowList[index]
                                                  .boyController,
                                              onChanged: (value) {
                                                totalGet();
                                                setState(() {});
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ], // Onl
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(0)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 80,
                                            child: TextField(
                                                controller: graderowList[index]
                                                    .girlController,
                                                onChanged: (value) {
                                                  totalGet();
                                                  setState(() {});
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ], // Only numbers can be entered
                                                decoration:
                                                    const InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.all(0))),
                                          ),
                                          SizedBox(
                                            child: Text(graderowList[index]
                                                            .boyController!
                                                            .text ==
                                                        '' ||
                                                    graderowList[index]
                                                            .girlController!
                                                            .text ==
                                                        ''
                                                ? '0'
                                                : (int.parse(graderowList[index]
                                                            .boyController!
                                                            .text) +
                                                        int.parse(
                                                            graderowList[index]
                                                                .girlController!
                                                                .text))
                                                    .toString()),
                                          ),
                                        ],
                                      );
                                    }),
                                const SizedBox(
                                  height: 20,
                                ),

                                //Nursery
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
              // ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Grand Total',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: MyColors.grey_95),
                      ),
                      Text(
                        '$grandTotalBoy',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: MyColors.grey_95),
                      ),
                      Text(
                        '$grandTotalGirl',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: MyColors.grey_95),
                      ),
                      Text(
                        '$grandTotal',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: MyColors.grey_95),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8A2724), elevation: 0),
                      child: Text("Submit",
                          style: MyText.subhead(context)!
                              .copyWith(color: Colors.white)),
                      onPressed: () async {
                        setState(() {
                          stateValue != null
                              ? _validateState = false
                              : _validateState = true;

                          districtValue != null
                              ? _validateDistrict = false
                              : _validateDistrict = true;

                          blockValue != null
                              ? _validateBlock = false
                              : _validateBlock = true;

                          schoolValue != null
                              ? _validateSchool = false
                              : _validateSchool = true;
                              
                        });
                        if (_validateState &&
                            _validateDistrict &&
                            _validateBlock &&
                            _validateSchool) {
                          var uniqueId = getRandomString(8);
                          isLoading.value = true;
                          if (isLoading.value) {
                            const CircularProgressIndicator(
                              semanticsLabel: 'please wait',
                            );
                          }

                          for (var i = 0; i < graderowList.length; i++) {
                            var rsp = await insertEnrollment(
                                GetStorage().read('userId'),
                                stateValue,
                                districtValue,
                                blockValue,
                                schoolValue,
                                graderowList[i].grade,
                                graderowList[i].boyController!.text,
                                graderowList[i].girlController!.text,
                                uniqueId);
                            setState(() {
                              graderowList[i].boyController!.clear();
                              graderowList[i].girlController!.clear();
                            });
                            if (i == (graderowList.length - 1)) {
                              var rsp = await insertEnrollment(
                                GetStorage().read('userId'),
                                stateValue,
                                districtValue,
                                blockValue,
                                schoolValue,
                                graderowList[i].grade,
                                graderowList[i].boyController!.text,
                                graderowList[i].girlController!.text,
                                uniqueId,
                              );

                              if (rsp['status'].toString() == '1') {
                                isLoading.value = false;
                                setState(() {
                                  graderowList[i].boyController!.clear();
                                  graderowList[i].girlController!.clear();
                                  stateValue == null;
                                  blockValue == null;
                                  districtValue == null;
                                  schoolValue == null;
                                  grandTotalBoy = 0;
                                  grandTotalGirl = 0;
                                  grandTotal = 0;
                                });
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        const CustomEventDialog(title: 'Home'));
                              } else {
                                print("something went wrong");
                              }
                            }
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future insertEnrollment(
    String? facilitatorId,
    String? state,
    String? district,
    String? block,
    String? school,
    String? grade,
    String? boys,
    String? girls,
    String? uniqueId,
    //String? i,
  ) async {
    if (kDebugMode) {
      print(uniqueId);
    }
    var response = await http
        .post(Uri.parse('${MyColors.baseUrl}insertEnrollment.php'), headers: {
      "Accept": "application/json"
    }, body: {
      'facilitatorId': facilitatorId,
      'state': state,
      'district': district,
      'block': block,
      'school': school,
      'grade': grade,
      'boys': boys,
      'girls': girls,
      'uniqueId': uniqueId,
    });
    var convertedDatatoJson = jsonDecode(response.body);
    return convertedDatatoJson;
  }
}

class GradeRow {
  String? grade;
  TextEditingController? boyController;
  TextEditingController? girlController;

  GradeRow({
    this.grade,
    this.boyController,
    this.girlController,
  });
}
