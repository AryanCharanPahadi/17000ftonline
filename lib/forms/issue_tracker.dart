import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:old17000ft/Controllers/issue_tracker_Controller.dart';
import 'package:old17000ft/Controllers/school_Controller.dart';
import 'package:old17000ft/Controllers/state_Controller.dart';
import 'package:old17000ft/Model/issue.dart';
import 'package:old17000ft/Model/school_data.dart';
import 'package:old17000ft/Model/staff_data.dart';
import 'package:old17000ft/colors.dart';
import '../Model/blockModel.dart';
import '../image_view.dart';
import '../my_text.dart';
import 'package:http/http.dart' as http;

final SchoolController schoolController = Get.put(SchoolController());
final IssueTrackerController _issueTrackerController =
    Get.put(IssueTrackerController());

String? _imagePicked;
File? _image;

final TextEditingController _imageController = TextEditingController();

final StaffController staffController = Get.put(StaffController());
final IssueTrackerController issueTrackerController =
    Get.put(IssueTrackerController());

class IssueTracker extends StatefulWidget {
  @override
  State<IssueTracker> createState() => _IssueTrackerState();
}

class _IssueTrackerState extends State<IssueTracker> {
  XFile? _imageFile;
  var isLoading = false.obs;
  String? stateValue;
  String? districtValue;
  String? blockValue;
  String? dropdownValue4;
  String? schoolValue;

  final ImagePicker _picker = ImagePicker();

  Future<String> takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 10,
    );
    _imageFile = pickedFile.obs();

    _image = File(_imageFile!.path);
    final bytes = _image!.readAsBytesSync();

    String status = base64Encode(_image!.readAsBytesSync());

    return status;
  }

  final bool _validateState = false;
  bool _validateDate = false;
  bool _validateName = false;
  final bool _validateDistrict = false;
  final bool _validateBlock = false;
  final bool _validateSchool = false;
  bool _validateIssueList = false;
  bool _validateGeneralComments = false;

  Widget bottomSheet(BuildContext context) {
    return Container(
      color: MyColors.primary,
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Select Image",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () async {
                  _imagePicked = await takePhoto(
                    ImageSource.camera,
                  );

                  // uploadFile(userdata.read('customerID'));
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.camera,
                  color: Colors.white,
                ),
                label: const Text(
                  'Camera',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  _imagePicked = await takePhoto(ImageSource.gallery);

                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.image,
                  color: Colors.white,
                ),
                label: const Text(
                  'Gallery',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // void _selectStaff() async {

  //   List<String>? results = await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Multiselect(
  //           title: 'Issue Resolved By',
  //           items2: staffController.staffList[0].data);
  //     },
  //   );

  //   // Update UI
  // }

  @override
  void initState() {
    super.initState();
  }

  bool value3 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        title: const Text("Issue Tracker"),
      ),
      body: GetBuilder<StateInfoController>(
          init: StateInfoController(),
          builder: (stateInfoController) {
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

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    text('Date-Time'),
                    const SizedBox(height: 10),
                    dateWidget(context, _issueTrackerController.datetime),
                    _validateDate
                        ? const Text('Please select a Date',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.red))
                        : const SizedBox(),
                    const SizedBox(height: 10),
                    // Obx(() => staffController.isLoading.value
                    //     ? const Center(
                    //         child: CircularProgressIndicator(
                    //         valueColor:
                    //             AlwaysStoppedAnimation<Color>(MyColors.primary),
                    //       ))
                    //     : text('Select the Facilitator Name')),
                    // const SizedBox(height: 10),
                    // Obx(
                    //   () => staffController.isLoading.value
                    //       ? const Center(
                    //           child: CircularProgressIndicator(
                    //           valueColor: AlwaysStoppedAnimation<Color>(
                    //               MyColors.primary),
                    //         ))
                    //       : dropDown11(context, 'Select a name',
                    //           staffController.staffList[0].data!),
                    // ),
                    // _validateName
                    //     ? const Text('Please select a Facilitator Name',
                    //         style: TextStyle(
                    //             fontSize: 12,
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.red))
                    //     : const SizedBox(),

                    const SizedBox(height: 10),
                    text('Select State'),
                    const SizedBox(
                      height: 10,
                    ),
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
                          value: stateValue,
                          iconSize: 24,
                          elevation: 2,
                          hint: Text(
                            'Select State'.tr,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          // ignore: can_be_null_after_null_aware
                          items: _uniqueState.map((value) {
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
                    text('Select District'),
                    const SizedBox(
                      height: 10,
                    ),
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
                          value: districtValue,
                          iconSize: 24,
                          elevation: 2,
                          hint: Text(
                            'Select District'.tr,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          // ignore: can_be_null_after_null_aware
                          items: _uniqueDistrict.map((value) {
                            return DropdownMenuItem<String>(
                              value: value.districtName.toString(),
                              child: Text(value.districtName.toString()),
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
                    text('Select Block'),
                    const SizedBox(
                      height: 10,
                    ),
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
                          value: blockValue,
                          iconSize: 24,
                          elevation: 2,
                          hint: Text(
                            'Select Block'.tr,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          // ignore: can_be_null_after_null_aware
                          items: _uniqueBlock.map((value) {
                            return DropdownMenuItem<String>(
                              value: value.blockName
                                  .toString()
                                  .replaceAll(',', ''),
                              child: Text(
                                value.blockName.toString().replaceAll(',', ''),
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
                    text('Select School'),

                    const SizedBox(
                      height: 10,
                    ),
                    GetBuilder<SchoolController>(
                        init: SchoolController(),
                        builder: (_schoolController) {
                          return Container(
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
                                value: schoolValue,
                                iconSize: 24,
                                elevation: 2,
                                isExpanded: true,
                                hint: Text(
                                  'Select School'.tr,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                // ignore: can_be_null_after_null_aware
                                items: schoolController.schoolList
                                    .where((element) =>
                                        element.blockName == blockValue)
                                    .map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value.schoolName.toString(),
                                    child: (Text(value.schoolName.toString())),
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
                    const SizedBox(height: 20),
                    text('Select the Issue Type'),
                    _validateIssueList
                        ? const Text('Please Fill atleast One Issue',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.red))
                        : const SizedBox(),
                    const SizedBox(height: 20),
                    !_issueTrackerController.isLoading.value
                        ? Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(12, 26),
                                      blurRadius: 50,
                                      spreadRadius: 0,
                                      color: Colors.grey.withOpacity(.1)),
                                ]),
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    _issueTrackerController.issueList!.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit),
                                            onPressed: () {
                                              _issueTrackerController
                                                  .fetchIssueComponents(
                                                      _issueTrackerController
                                                          .issueList![index]
                                                          .componentId!);
                                              print(_issueTrackerController
                                                  .issueList![index]
                                                  .componentId!);

                                              displayPopup(
                                                  context,
                                                  _issueTrackerController
                                                      .issueList![index]
                                                      .nameOfIssue!,
                                                  _issueTrackerController
                                                      .issueList![index]
                                                      .componentId!);
                                            },
                                          ),
                                          Flexible(
                                            flex: 6,
                                            child: SizedBox(
                                              child: Text(
                                                  _issueTrackerController
                                                      .issueList![index]
                                                      .componentName!,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                      issueTrackerController.getVerified(
                                              _issueTrackerController
                                                  .issueList![index]
                                                  .componentId!)
                                          ? const Positioned(
                                              right: 10,
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.green,
                                              ))
                                          : const SizedBox(),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  );
                                }),
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(MyColors.primary),
                          )),
                    const SizedBox(height: 20),
                    const Text(
                      'Describe the issue in details if "Other" is choosen in any of the categories',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: issueTrackerController.otherController,
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
                    text('  General Comments '),
                    const SizedBox(height: 10),
                    TextField(
                      controller:
                          issueTrackerController.generalCommentController,
                      decoration: const InputDecoration(
                          hintText: 'Type Something.....',
                          border: OutlineInputBorder()),
                      maxLines: 6,
                    ),
                    _validateGeneralComments
                        ? const Text('Please type Something',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.red))
                        : const SizedBox(),
                    const SizedBox(height: 20),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF8A2724),
                                  elevation: 0),
                              child: Text("Save",
                                  style: MyText.subhead(context)!
                                      .copyWith(color: Colors.white)),
                              onPressed: () async {},
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          SizedBox(
                            height: 45,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF8A2724),
                                    elevation: 0),
                                child: Text("Submit",
                                    style: MyText.subhead(context)!
                                        .copyWith(color: Colors.white)),
                                onPressed: () async {
                                  // for (int i = 0;
                                  //     i < issueTrackerController.issueType.length;
                                  //     i++) {

                                  setState(() {
                                    issueTrackerController.facilitatorName !=
                                            null
                                        ? _validateName = false
                                        : _validateName = true;
                                    issueTrackerController
                                            .datetime.text.isNotEmpty
                                        ? _validateDate = false
                                        : _validateDate = true;
                                    // issueTrackerController.district != null
                                    //     ? _validateDistrict = false
                                    //     : _validateDistrict = true;
                                    // issueTrackerController.block != null
                                    //     ? _validateBlock = false
                                    //     : _validateBlock = true;
                                    // issueTrackerController.school != null
                                    //     ? _validateSchool = false
                                    //     : _validateSchool = true;
                                    issueTrackerController.issueType != null
                                        ? _validateIssueList = false
                                        : _validateIssueList = true;
                                    issueTrackerController
                                            .generalCommentController
                                            .text
                                            .isNotEmpty
                                        ? _validateGeneralComments = false
                                        : _validateGeneralComments = true;
                                  });
                                  List<String> DigiCgsi = [
                                    '1',
                                    '2143',
                                    'Learn Zone',
                                    'Grade 5',
                                    'Computer Science',
                                    '2nd Chapter'
                                        'Open'
                                        '16 May 2022'
                                        'Afjal'
                                  ];
                                  List<String> DigiCgslate = [
                                    '2',
                                    ...[
                                      'App Not Configured',
                                      'App not loading'
                                    ],
                                    'Open',
                                    '16 May 2022',
                                    'Afjal'
                                  ];
                                  List<String> DigiConnectorBox = [
                                    '3',
                                    ...[
                                      'Light Not Coming',
                                      'Not Discharging electricity'
                                    ],
                                    'Open',
                                    '16 May 2022',
                                    'Afjal'
                                  ];
                                  List<String> DigiEarphone = [
                                    '4',
                                    ...['Earphone not working'],
                                    'Open',
                                    '16 May 2022',
                                    'Afjal'
                                  ];
                                  List<String> DigiFacilitator = [
                                    '5',
                                    ...[
                                      'Get School Data Showing Red cross',
                                      'Facilitator App - UI'
                                    ],
                                    'Open',
                                    '16 May 2022',
                                    'Afjal'
                                  ];
                                  List<String> DigiGeneral = [
                                    '6',
                                    ...[
                                      'Sponsor board broken',
                                      'Room Paint required'
                                    ],
                                    'Open',
                                    '16 May 2022',
                                    'Afjal'
                                  ];
                                  List<String> DigiHdmi = [
                                    '7',
                                    ...[
                                      'HDMI Cable not working',
                                    ],
                                    'Open',
                                    '16 May 2022',
                                    'Afjal'
                                  ];
                                  List<String> DigiKeyboard = [
                                    '8',
                                    ...[
                                      'Keyboard not working',
                                      'Keyboard broken'
                                    ],
                                    'Open',
                                    '16 May 2022',
                                    'Afjal'
                                  ];

                                  List<String> DigiMouse = [
                                    '9',
                                    ...['Mouse not working', 'other'],
                                    'Open',
                                    '16 May 2022',
                                    'Afjal'
                                  ];
                                  List<String> DigiRasberry = [
                                    '10',
                                    ...[
                                      'Light not coming on',
                                      'Light is Green in color'
                                    ],
                                    'Open',
                                    '16 May 2022',
                                    'Afjal'
                                  ];

                                  List<String> DigiTv = [
                                    '11',
                                    ...[
                                      'TV not switching on',
                                      'TV Volume not working'
                                    ],
                                    'Open',
                                    '16 May 2022',
                                    'Afjal'
                                  ];
                                  List<String> DigiTablet = [
                                    '12',
                                    ...['Tablet not charging', 'Tablet Broken'],
                                    'Open',
                                    '16 May 2022',
                                    'Afjal'
                                  ];
                                  List<String> DigiTabletKeyboard = [
                                    '13',
                                    ...[
                                      'Some Keys not working',
                                      'Broken Keyboard'
                                    ],
                                    'Open',
                                    '16 May 2022',
                                    'Afjal'
                                  ];
                                  List<String> DigiCgSlateModification = [
                                    '14',
                                    ...[
                                      'ID not getting created',
                                      'Edited ID not saving'
                                    ],
                                    'Open',
                                    '16 May 2022',
                                    'Afjal'
                                  ];

                                  //different issue types
                                  List<String> Furniture = [
                                    '15',
                                    ...[
                                      'Senior Desk missing/broken',
                                      'Junior Desk missing/broken',
                                    ],
                                    'Open',
                                    '16 May 2022',
                                    'Afjal'
                                  ];
                                  List<String> LibraryRack = [];
                                  List<String> playground = [];
                                  List<String> solarBattery = [];
                                  List<String> solarPanel = [];
                                  var rsp = await insert_issue(
                                      issueTrackerController.datetime.text,
                                      issueTrackerController.facilitatorName!,
                                      issueTrackerController.district!,
                                      issueTrackerController.block!,
                                      issueTrackerController.school!,
                                      issueTrackerController
                                          .otherController.text,
                                      issueTrackerController
                                          .generalCommentController.text,
                                      DigiCgsi.toString());

                                  print(rsp);

                                  // var rsp = await insert_issue(
                                  //   issueTrackerController.facilitatorName!
                                  //       .toString(),
                                  //   issueTrackerController.hello.name!
                                  //       .toString(),
                                  //   issueTrackerController.district!.toString(),
                                  //   issueTrackerController.block!.toString(),
                                  //   'issueTrackerController.school!.toString()',
                                  //   issueTrackerController
                                  //       .generalCommentController.text,
                                  //   issueTrackerController.datetime.text,
                                  //   issueTrackerController.hello.tabletNumber!
                                  //       .toString(),
                                  //   issueTrackerController.hello.zone!
                                  //       .toString(),
                                  //   issueTrackerController.hello.grade!
                                  //       .toString(),
                                  //   issueTrackerController.hello.subject!
                                  //       .toString(),
                                  //   issueTrackerController.hello.chapter!
                                  //       .toString(),
                                  //   issueTrackerController.hello.tabName!
                                  //       .toString(),
                                  //   issueTrackerController.hello.gameIssue!
                                  //       .toString(),
                                  //   issueTrackerController.hello.gameName!
                                  //       .toString(),
                                  //   issueTrackerController.hello.describeIssue!
                                  //       .toString(),
                                  //   '',
                                  //   '',
                                  //   '',
                                  //   '',
                                  //   '',
                                  //   '',
                                  //   '',
                                  //   '',
                                  //   '',
                                  //   '',
                                  //   '',
                                  //   '',
                                  //   '',
                                  //   '',
                                  //   '',
                                  //   issueTrackerController.hello.status!
                                  //       .toString(),
                                  //   issueTrackerController.hello.resolvedBy!,
                                  //   issueTrackerController.hello.resolvedDate!,
                                  // );

                                  // if (rsp['status'] == '1') {
                                  //   print('SHKUHDKJHFSJKH');
                                  // }
                                }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  RichText text(String value) {
    return RichText(
        text: TextSpan(
            text: '',
            style: const TextStyle(
                letterSpacing: 3,
                color: Colors.black,
                fontWeight: FontWeight.w400),
            children: [
          TextSpan(
              text: value,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: MyColors.grey_95)),
          const TextSpan(
              text: '*',
              style: TextStyle(
                  fontSize: 25, color: Colors.red, fontWeight: FontWeight.bold))
        ]));
  }

  Container dropDown11(BuildContext context, String name, List<Datum>? data) {
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
          value: issueTrackerController.facilitatorName,
          iconSize: 24,
          elevation: 2,
          hint: Text(
            name,
            style: const TextStyle(color: Colors.grey),
          ),
          // ignore: can_be_null_after_null_aware
          items: data!.map((value) {
            return DropdownMenuItem<String>(
              value: value.firstName! + " " + value.lastName!,
              child: Text(value.firstName! + " " + value.lastName!),
            );
          }).toList(),
          onChanged: (data) {
            issueTrackerController.facSetter(data!);
          },
        ),
      ]),
    );
  }

//   Container dropDistrict(
//     BuildContext context,
//     String name,
//  //   List<DistrictModel> data,
//   ) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         boxShadow: const [
//           BoxShadow(color: Colors.white, spreadRadius: 1, blurRadius: 5)
//         ],
//       ),
//       child: Stack(children: [
//         DropdownButton<String>(
//           value: issueTrackerController.district,
//           iconSize: 24,
//           elevation: 2,
//           hint: Text(
//             name,
//             style: const TextStyle(color: Colors.grey),
//           ),
//           // ignore: can_be_null_after_null_aware
//           items: data.map((value) {
//             return DropdownMenuItem<String>(
//               value: value.district,
//               child: Text(value.district!),
//             );
//           }).toList(),
//           onChanged: (data) {
//             issueTrackerController.districtSetter(data!);
//             issueTrackerController.blockSetter(null);
//           },
//         ),
//       ]),
//     );
//   }

//   Container dropBlock(
//     BuildContext context,
//     String name,
//  //   List<BlockModel> data,
//   ) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         boxShadow: const [
//           BoxShadow(color: Colors.white, spreadRadius: 1, blurRadius: 5)
//         ],
//       ),
//       child: Stack(children: [
//         DropdownButton<String>(
//           value: issueTrackerController.block,
//           iconSize: 24,
//           elevation: 2,
//           hint: Text(
//             name,
//             style: const TextStyle(color: Colors.grey),
//           ),
//           // ignore: can_be_null_after_null_aware
//           items: data
//               .where((element) =>
//                   element.district == issueTrackerController.district)
//               .map((value) {
//             return DropdownMenuItem<String>(
//               value: value.block,
//               child: Text(value.block!),
//             );
//           }).toList(),
//           onChanged: (data) {
//             issueTrackerController.blockSetter(data!);
//             Get.find<SchoolController>().filterdata(data);
//           },
//         ),
//       ]),
//     );
//   }

  Container dropDown(
    BuildContext context,
    String name,
    List<String> data,
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
          value: issueTrackerController.issueStatus,
          iconSize: 24,
          elevation: 2,
          hint: Text(
            name,
            style: const TextStyle(color: Colors.grey),
          ),
          // ignore: can_be_null_after_null_aware
          items: data.map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (data) {},
        ),
      ]),
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
          value: issueTrackerController.school,
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
            issueTrackerController.schoolSetter(data!);
          },
        ),
      ]),
    );
  }

  Container dropDownSubject(
    BuildContext context,
    String name,
    List<GradeComponents> data,
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
          value: issueTrackerController.zoneComponentId,
          iconSize: 24,
          elevation: 2,
          hint: Text(
            name,
            style: const TextStyle(color: Colors.grey),
          ),
          //  ignore: can_be_null_after_null_aware
          items: data
              .where((element) =>
                  element.gradeId == issueTrackerController.zoneGradeId)
              .map((value) {
            return DropdownMenuItem<String>(
              onTap: () {
                issueTrackerController.setDropValSubject(
                    value.gradeCompId!, value.gradeComponentName!);
              },
              value: value.gradeCompId,
              child: Text(value.gradeComponentName!),
            );
          }).toList(),
          onChanged: (data) {},
        ),
      ]),
    );
  }

  Container dropDownGrade(
    BuildContext context,
    String name,
    List<ZoneGrade> data,
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
          value: issueTrackerController.zoneGradeId,
          iconSize: 24,
          elevation: 2,
          hint: Text(
            name,
            style: const TextStyle(color: Colors.grey),
          ),
          // ignore: can_be_null_after_null_aware
          items: data
              .where((element) =>
                  element.zoneId == issueTrackerController.cgiZoneId)
              .map((value) {
            return DropdownMenuItem<String>(
              onTap: () {
                issueTrackerController.setDropValGrade(
                    value.gradeId!, value.gradeName!);
              },
              value: value.gradeId,
              child: Text(value.gradeName!),
            );
          }).toList(),
          onChanged: (data) {},
        ),
      ]),
    );
  }

  Container dropDownCgi(
    BuildContext context,
    String name,
    List<CgiappZones> data,
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
          value: issueTrackerController.cgiZoneId,
          iconSize: 24,
          elevation: 2,
          hint: Text(
            name,
            style: const TextStyle(color: Colors.grey),
          ),
          // ignore: can_be_null_after_null_aware
          items: data.map((value) {
            return DropdownMenuItem<String>(
              onTap: () {
                issueTrackerController.setDropVal(
                    value.zoneId!, value.zoneName!);
              },
              value: value.zoneId,
              child: Text(value.zoneName!),
            );
          }).toList(),
          onChanged: (data) {},
        ),
      ]),
    );
  }

  Container dateWidget(BuildContext context, TextEditingController controller) {
    return Container(
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
                issueTrackerController.selectDate(context, controller);
              },
              readOnly: true,
              onChanged: (value) {},
              maxLines: 1,
              style: MyText.body2(context)!.copyWith(color: MyColors.grey_40),
              keyboardType: TextInputType.datetime,
              controller: controller,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(-12),
                  border: InputBorder.none,
                  hintText: "dd-mm-yyyy",
                  hintStyle:
                      MyText.body1(context)!.copyWith(color: MyColors.grey_40)),
            ),
          ),
          IconButton(
              onPressed: () {
                issueTrackerController.selectDate(context, controller);
              },
              icon: const Icon(Icons.calendar_today, color: MyColors.grey_40))
        ],
      ),
    );
  }

//img uploading
//textarea
//checkbox

  void displayPopup(
    BuildContext context,
    String title,
    String id,
  ) {
    TextEditingController _controller = TextEditingController();
    TextEditingController _funController = TextEditingController();
    TextEditingController _chapterController = TextEditingController();
    TextEditingController _datecontroller = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();
    TextEditingController _issueController = TextEditingController();

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return GetBuilder<IssueTrackerController>(
            init: IssueTrackerController(),
            builder: (issueTrackerController) {
              CheckData? data;
              if (issueTrackerController.checkList.isNotEmpty) {
                data = issueTrackerController.filterData(title);
              }

              return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return !issueTrackerController.isLoading.value
                    ? CustomScrollView(
                        slivers: [
                          SliverFillRemaining(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Text(
                                      title,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.grey_95),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(24),
                                            topRight: Radius.circular(24))),
                                    child: ListView.builder(
                                      primary: true,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: issueTrackerController
                                          .issueTypeList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return issueTrackerController
                                                    .issueTypeList[index]
                                                    .fieldType ==
                                                'img uploading'
                                            ? Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(
                                                      issueTrackerController
                                                          .issueTypeList[index]
                                                          .issueComponentName!,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 45,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            4))),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(width: 15),
                                                        Expanded(
                                                          child: TextField(
                                                            readOnly: true,
                                                            onTap: () {
                                                              showModalBottomSheet(
                                                                  backgroundColor:
                                                                      MyColors
                                                                          .primary,
                                                                  context:
                                                                      context,
                                                                  builder: ((builder) =>
                                                                      bottomSheet(
                                                                          context)));
                                                            },
                                                            maxLines: 1,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            controller:
                                                                _imageController,
                                                            decoration: InputDecoration(
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        -12),
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    "Upload Image",
                                                                hintStyle: MyText
                                                                        .body1(
                                                                            context)!
                                                                    .copyWith(
                                                                        color: MyColors
                                                                            .grey_40)),
                                                          ),
                                                        ),
                                                        CircleAvatar(
                                                            radius: 55,
                                                            backgroundColor:
                                                                Colors.white,
                                                            child: _image !=
                                                                    null
                                                                ? InkWell(
                                                                    onTap: () {
                                                                      Get.to(() =>
                                                                          ImageView(
                                                                              image: _image!));
                                                                    },
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      child: Image
                                                                          .file(
                                                                        _image!,
                                                                        width:
                                                                            100,
                                                                        height:
                                                                            100,
                                                                        fit: BoxFit
                                                                            .fitHeight,
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container()),
                                                        IconButton(
                                                            icon: const Icon(
                                                                Icons.camera,
                                                                color: MyColors
                                                                    .grey_40),
                                                            onPressed: () {
                                                              showModalBottomSheet(
                                                                  backgroundColor:
                                                                      MyColors
                                                                          .primary,
                                                                  context:
                                                                      context,
                                                                  builder: ((builder) =>
                                                                      bottomSheet(
                                                                          context)));
                                                            }),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : issueTrackerController
                                                        .issueTypeList[index]
                                                        .fieldType ==
                                                    'select box'
                                                ? Column(
                                                    children: [
                                                      ListTile(
                                                        title: Text(
                                                          issueTrackerController
                                                              .issueTypeList[
                                                                  index]
                                                              .issueComponentName!,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 18.0),
                                                        child: dropDownCgi(
                                                          context,
                                                          'Select',
                                                          issueTrackerController
                                                              .cgiAppZones,
                                                        ),
                                                      ),
                                                      issueTrackerController
                                                                  .cgiZone !=
                                                              null
                                                          ? ListTile(
                                                              title: Text(
                                                                'Select the Grade (${issueTrackerController.cgiZone})',
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      issueTrackerController
                                                                  .cgiZone !=
                                                              null
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          18.0),
                                                              child:
                                                                  dropDownGrade(
                                                                context,
                                                                'Select',
                                                                issueTrackerController
                                                                    .cgiZoneGrade,
                                                              ),
                                                            )
                                                          // zoneGrade
                                                          : const SizedBox(),
                                                      issueTrackerController
                                                                      .zoneGrade !=
                                                                  null &&
                                                              issueTrackerController
                                                                      .cgiZone !=
                                                                  'Fun zone'
                                                          ? ListTile(
                                                              title: Text(
                                                                '${issueTrackerController.zoneGrade} - Subject',
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      issueTrackerController
                                                                      .zoneGrade !=
                                                                  null &&
                                                              issueTrackerController
                                                                      .cgiZone !=
                                                                  'Fun zone'
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          18.0),
                                                              child:
                                                                  dropDownSubject(
                                                                context,
                                                                'Select',
                                                                issueTrackerController
                                                                    .cgiGradeComponents,
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      issueTrackerController
                                                                  .cgiZone ==
                                                              'Fun zone'
                                                          ? const ListTile(
                                                              title: Text(
                                                                'Select Fun Zone -Tab Name *',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      issueTrackerController
                                                                  .cgiZone ==
                                                              'Fun zone'
                                                          ? ListBody(
                                                              children: [
                                                                'Featured Games',
                                                                'Featured Videos',
                                                                'Recent'
                                                              ]
                                                                  .map((item) => CheckboxListTile(
                                                                      activeColor: const Color(0xFF8A2724),
                                                                      value: schoolController.selectedActivity.contains(item),
                                                                      title: Text(item),
                                                                      controlAffinity: ListTileControlAffinity.leading,
                                                                      onChanged: (isChecked) => setState(() {
                                                                            schoolController.checkActivity(item);
                                                                          })))
                                                                  .toList(),
                                                            )
                                                          : const SizedBox(),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      issueTrackerController
                                                                  .cgiZone ==
                                                              'Fun zone'
                                                          ? const ListTile(
                                                              title: Text(
                                                                'Select Game/Activity Issue *',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      issueTrackerController
                                                                  .cgiZone ==
                                                              'Fun zone'
                                                          ? ListBody(
                                                              children: [
                                                                'Game/Video not loading or playing',
                                                                'Game/Video stopped playing midway',
                                                                'Other'
                                                              ]
                                                                  .map((item) => CheckboxListTile(
                                                                      activeColor: const Color(0xFF8A2724),
                                                                      value: schoolController.selectedActivity.contains(item),
                                                                      title: Text(item),
                                                                      controlAffinity: ListTileControlAffinity.leading,
                                                                      onChanged: (isChecked) => setState(() {
                                                                            schoolController.checkActivity(item);
                                                                          })))
                                                                  .toList(),
                                                            )
                                                          : const SizedBox(),
                                                      issueTrackerController
                                                                  .cgiZone ==
                                                              'Fun zone'
                                                          ? const ListTile(
                                                              title: Text(
                                                                'Enter the Fun Zone - Game/Video Name',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      issueTrackerController
                                                                  .cgiZone ==
                                                              'Fun zone'
                                                          ? TextField(
                                                              controller:
                                                                  _funController,
                                                              decoration: InputDecoration(
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              1)),
                                                                  hintText:
                                                                      "Type..."),
                                                            )
                                                          : const SizedBox(),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      issueTrackerController
                                                                  .cgiZone ==
                                                              'Fun zone'
                                                          ? const ListTile(
                                                              title: Text(
                                                                'Describe the Fun Zone-Game/Video related issue ',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      issueTrackerController
                                                                  .cgiZone ==
                                                              'Fun zone'
                                                          ? TextField(
                                                              controller:
                                                                  _descriptionController,
                                                              decoration: InputDecoration(
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              1)),
                                                                  hintText:
                                                                      "Type..."),
                                                            )
                                                          : const SizedBox(),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      issueTrackerController
                                                                      .zoneGrade !=
                                                                  null &&
                                                              issueTrackerController
                                                                      .cgiZone ==
                                                                  'Practice zone'
                                                          ? text(
                                                              'Describe the Practice Zone related issue')
                                                          : const SizedBox(),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      issueTrackerController
                                                                      .zoneGrade !=
                                                                  null &&
                                                              issueTrackerController
                                                                      .cgiZone ==
                                                                  'Practice zone'
                                                          ? TextField(
                                                              controller:
                                                                  _issueController,
                                                              maxLines: 1,
                                                              decoration: InputDecoration(
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              1)),
                                                                  hintText:
                                                                      "Type..."))
                                                          : const SizedBox(),
                                                      issueTrackerController
                                                                      .zoneGrade !=
                                                                  null &&
                                                              issueTrackerController
                                                                      .cgiZone !=
                                                                  'Practice zone'
                                                          ? text(
                                                              'Enter the Chapter Number-Name')
                                                          : const SizedBox(),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      issueTrackerController
                                                                      .zoneGrade !=
                                                                  null &&
                                                              issueTrackerController
                                                                      .cgiZone !=
                                                                  'Practice zone'
                                                          ? TextField(
                                                              controller:
                                                                  _chapterController,
                                                              maxLines: 1,
                                                              decoration: InputDecoration(
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              1)),
                                                                  hintText:
                                                                      "Type..."))
                                                          : const SizedBox(),
                                                    ],
                                                  )
                                                : issueTrackerController
                                                            .issueTypeList[
                                                                index]
                                                            .fieldType ==
                                                        'textfield'
                                                    ? Column(
                                                        children: [
                                                          ListTile(
                                                            title: Text(
                                                              issueTrackerController
                                                                  .issueTypeList[
                                                                      index]
                                                                  .issueComponentName!,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                          TextField(
                                                            controller:
                                                                _controller,
                                                            decoration: InputDecoration(
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            1)),
                                                                hintText:
                                                                    "Type..."),
                                                          ),
                                                        ],
                                                      )
                                                    : Column(
                                                        children: [
                                                          ListTile(
                                                            selectedTileColor:
                                                                const Color(
                                                                    0xFF8A2724),
                                                            leading: Checkbox(
                                                              value: issueTrackerController
                                                                  .issue
                                                                  .contains(issueTrackerController
                                                                      .issueTypeList[
                                                                          index]
                                                                      .issueComponentName!),
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  issueTrackerController.addDaata(
                                                                      issueTrackerController
                                                                          .issueTypeList[
                                                                              index]
                                                                          .issueComponentName!,
                                                                      index);

                                                                  issueTrackerController.filterList(
                                                                      issueTrackerController
                                                                          .issueTypeList[
                                                                              index]
                                                                          .id!,
                                                                      issueTrackerController.issue.contains(issueTrackerController
                                                                          .issueTypeList[
                                                                              index]
                                                                          .issueComponentName!),
                                                                      issueTrackerController
                                                                          .issueTypeList[
                                                                              index]
                                                                          .issueComponentName!);
                                                                });
                                                              },
                                                            ),
                                                            title: Text(
                                                              issueTrackerController
                                                                  .issueTypeList[
                                                                      index]
                                                                  .issueComponentName!,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                      },
                                    ),
                                  ),
                                  title == 'Connector Box - Related Issues' ||
                                          title ==
                                              'Furniture - Related Issues' ||
                                          title ==
                                              'Library Rack - Related Issues' ||
                                          title == 'Playground - Related Issues'
                                      ? issueTrackerController
                                              .checkList.isNotEmpty
                                          ? SingleChildScrollView(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      data!.issues!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return data!.issues![index]
                                                                .fieldType ==
                                                            'img uploading'
                                                        ? Column(
                                                            children: [
                                                              ListTile(
                                                                title: Text(
                                                                  data
                                                                      .issues![
                                                                          index]
                                                                      .attributeName!,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 45,
                                                                decoration: const BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(4))),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                        width:
                                                                            15),
                                                                    Expanded(
                                                                      child:
                                                                          TextField(
                                                                        readOnly:
                                                                            true,
                                                                        onTap:
                                                                            () {
                                                                          showModalBottomSheet(
                                                                              backgroundColor: MyColors.primary,
                                                                              context: context,
                                                                              builder: ((builder) => bottomSheet(context)));
                                                                        },
                                                                        maxLines:
                                                                            1,
                                                                        keyboardType:
                                                                            TextInputType.text,
                                                                        controller:
                                                                            _imageController,
                                                                        decoration: InputDecoration(
                                                                            contentPadding: const EdgeInsets.all(
                                                                                -12),
                                                                            border: InputBorder
                                                                                .none,
                                                                            hintText:
                                                                                "Upload Image",
                                                                            hintStyle:
                                                                                MyText.body1(context)!.copyWith(color: MyColors.grey_40)),
                                                                      ),
                                                                    ),
                                                                    CircleAvatar(
                                                                        radius:
                                                                            55,
                                                                        backgroundColor:
                                                                            Colors
                                                                                .white,
                                                                        child: _image !=
                                                                                null
                                                                            ? InkWell(
                                                                                onTap: () {
                                                                                  Get.to(() => ImageView(image: _image!));
                                                                                },
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(50),
                                                                                  child: Image.file(
                                                                                    _image!,
                                                                                    width: 100,
                                                                                    height: 100,
                                                                                    fit: BoxFit.fitHeight,
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            : Container()),
                                                                    IconButton(
                                                                        icon: const Icon(
                                                                            Icons
                                                                                .camera,
                                                                            color: MyColors
                                                                                .grey_40),
                                                                        onPressed:
                                                                            () {
                                                                          showModalBottomSheet(
                                                                              backgroundColor: MyColors.primary,
                                                                              context: context,
                                                                              builder: ((builder) => bottomSheet(context)));
                                                                        }),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : Column(
                                                            children: [
                                                              ListTile(
                                                                title: Text(
                                                                  data
                                                                      .issues![
                                                                          index]
                                                                      .attributeName!,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                              TextField(
                                                                controller:
                                                                    _controller,
                                                                decoration: InputDecoration(
                                                                    border: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                1)),
                                                                    hintText:
                                                                        "Type..."),
                                                              ),
                                                            ],
                                                          );
                                                  },
                                                ),
                                              ),
                                            )
                                          : const SizedBox()
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: text('  Select the Issue Status '),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
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
                                          value:
                                              issueTrackerController.dropValue,
                                          iconSize: 24,
                                          elevation: 2,
                                          hint: const Text(
                                            'Select the Issue Status',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          // ignore: can_be_null_after_null_aware
                                          items:
                                              ['Open', 'Resolved'].map((value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (data) {
                                            setState(() {
                                              issueTrackerController
                                                  .setVlaue(data!);
                                            });
                                          },
                                        ),
                                      ]),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: text('Date of Resolution '),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: dateWidget(context, _datecontroller),
                                  ),
                                  const SizedBox(height: 10),
                                  Obx(() => staffController.isLoading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  MyColors.primary),
                                        ))
                                      : text('Issue Resolved By')),
                                  const SizedBox(height: 10),
                                  Obx(
                                    () => staffController.isLoading.value
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    MyColors.primary),
                                          ))
                                        : dropDown11(context, 'Select a name',
                                            staffController.staffList[0].data!),
                                  ),
                                  _validateName
                                      ? const Text(
                                          'Please select a Facilitator Name',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red))
                                      : const SizedBox(),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: ListBody(
                                      children: _issueTrackerController
                                          .resolvedBy
                                          .map((items2) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(items2),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 45,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF8A2724),
                                            elevation: 0),
                                        child: Text("Save",
                                            style: MyText.subhead(context)!
                                                .copyWith(color: Colors.white)),
                                        onPressed: () async {
                                          List<String> issue1 = [];

                                          issue1.addAll(
                                              issueTrackerController.issue);

                                          if (title ==
                                              'CGSlate App zones - Related Issues') {
                                            final CgSlateApp data = CgSlateApp(
                                                id: id,
                                                tabletNumber: _controller.text,
                                                zone: issueTrackerController
                                                    .cgiZone,
                                                grade: issueTrackerController
                                                    .zoneGrade,
                                                tabName: '',
                                                gameIssue: '',
                                                gameName: '',
                                                describeIssue: '',
                                                subject: '',
                                                chapter: '',
                                                status: issueTrackerController
                                                    .dropValue,
                                                resolvedBy:
                                                    issueTrackerController
                                                        .resolvedBy,
                                                resolvedDate:
                                                    _datecontroller.text);
                                          } else {
                                            final Digilab data = Digilab(
                                              id: id,
                                              issues: issue1,
                                              name: title,
                                              status: issueTrackerController
                                                  .dropValue,
                                              resolvedBy: issueTrackerController
                                                  .resolvedBy,
                                              resolvedDate: _controller.text,
                                            );
                                            issueTrackerController
                                                .addMainData(data);
                                          }

                                          Navigator.of(context).pop();
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : const Center(child: CircularProgressIndicator());
              });
            });
      },
    );
  }

  Future insert_issue(
    String time,
    String facilitator,
    String district,
    String block,
    String school,
    String others,
    String generalComments,
    String nameOfIssue,
  ) async {
    nameOfIssue = {
      '"component_id"': '"1"',
      '"tablet_number"': '"476760"',
    }.toString();
    String demo = nameOfIssue;
    print("'$demo'");
    String test = demo;
    print(test);
    var response = await http
        .post(Uri.parse(MyColors.baseUrl + 'insert_issue_record.php'), headers: {
      "Accept": "Application/json"
    }, body: {
      'created_at': time,
      'facilitator': facilitator,
      'district': district,
      'block': block,
      'school': school,
      'other': others,
      'general_comments': generalComments,
      'digi_lab': test
    });
    var convertedDatatoJson = jsonDecode(response.body);
    return convertedDatatoJson;
  }


//dailog box with text fields

// class DialogFb1 extends StatelessWidget {
//   final List<IssueTypeComponent>? list;
//   const DialogFb1({Key? key, this.list}) : super(key: key);
//   final primaryColor = const Color(0xff4338CA);
//   final accentColor = const Color(0xffffffff);

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       elevation: 1,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Container(
//         width: MediaQuery.of(context).size.width / 1.4,
//         height: MediaQuery.of(context).size.height / 4,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15.0),
//             boxShadow: [
//               BoxShadow(
//                   offset: const Offset(12, 26),
//                   blurRadius: 50,
//                   spreadRadius: 0,
//                   color: Colors.grey.withOpacity(.1)),
//             ]),
//         child: ListView.builder(
//             itemCount: list!.length,
//             itemBuilder: (context, index) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   Text(list![index].issueComponentName!,
//                       style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold)),
//                   const SizedBox(
//                     height: 3.5,
//                   ),
//                   const Text("This is a sub text, use it to clarify",
//                       style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w300)),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                 ],
//               );
//             }),
//       ),
//     );
//   }
// }
}



