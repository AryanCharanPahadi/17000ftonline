import 'package:flutter/material.dart';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:old17000ft/Controllers/apiCalls.dart';
import 'package:old17000ft/Model/issue.dart';
import 'package:old17000ft/Model/issue_atrr.dart';

import '../da_form.dart';

class IssueTrackerController extends GetxController {
  var isLoading = false.obs;

  //Variables to store the General Data
  DateTime selectedDate = DateTime.now(), initialDate = DateTime.now();

  selectDate(
    BuildContext context,
    TextEditingController date,
  ) async {
    final DateTime? selected = await showDatePicker(
      locale: const Locale('en', 'IN'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
      builder: (context, picker) {
        return Theme(data: theme, child: picker!);
      },
    );
    if (selected != null) {
      selectedDate = selected;
      String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
      date.text = formattedDate;
      //    (getNumber(int.parse(DateFormat('dd').format(selectedDate))));
      update();
    }
  }

  

  TextEditingController _datetime = TextEditingController();
  TextEditingController get datetime => _datetime;

  TextEditingController _resolutionDate = TextEditingController();
  TextEditingController get resolutionDate => _resolutionDate;
  String? _facilitatorName;
  String? get facilitatorName => _facilitatorName;

  String? _district;
  String? get district => _district;

  String? _block;
  String? get block => _block;

  String? _school;
  String? get school => _school;

  TextEditingController _generalCommentController = TextEditingController();
  TextEditingController get generalCommentController =>
      _generalCommentController;

  TextEditingController _otherController = TextEditingController();
  TextEditingController get otherController => _otherController;

  List<String> _resolvedBy = [];
  List<String> get resolvedBy => _resolvedBy;

  String? _issueStatus;
  String? get issueStatus => _issueStatus;

  void issueSetter(String value) {
    _issueStatus = value;
    update();
  }

  void facSetter(String value) {
    _facilitatorName = value;
    update();
  }

  void schoolSetter(String value) {
    _school = value;
    update();
  }

  void districtSetter(String value) {
    _district = value;
    update();
  }

  void blockSetter(String? value) {
    _block = value;
    update();
  }

  String? _cgiZoneId;
  String? get cgiZoneId => _cgiZoneId;

  String? _cgiZone;
  String? get cgiZone => _cgiZone;

  String? _zoneGradeId;
  String? get zoneGradeId => _zoneGradeId;

  String? _zoneGrade;
  String? get zoneGrade => _zoneGrade;

  setDropVal(String id, String name) {
    _cgiZoneId = id;
    _cgiZone = name;

    _zoneGradeId = null;
    _zoneGrade = null;
    _zoneComponentId = null;
    _zoneComponent = null;

    update();
  }

  setDropValGrade(String id, String name) {
    _zoneGradeId = id;
    _zoneGrade = name;
    _zoneComponentId = null;
    _zoneComponent = null;
    update();
  }

  String? _zoneComponentId;
  String? get zoneComponentId => _zoneComponentId;

  String? _zoneComponent;
  String? get zoneComponent => _zoneComponent;

  setDropValSubject(String id, String name) {
    _zoneComponentId = id;
    _zoneComponent = name;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchIssue();
    fetchCgiAppZones();
    fetchCgiGradeComponents();
    fetchCgiZoneGrades();
    fetchCheckBoxAttr();
  }

  String? _dropValue;

  String? get dropValue => _dropValue;
  void setVlaue(
    String value,
  ) {
    _dropValue = value;
    update();
  }

  void checkStaff(String value) {
    if (!_resolvedBy.contains(value)) {
      _resolvedBy.add(value);
    } else {
      _resolvedBy.remove(value);
    }
    update();
  }

  List<IssueComponent>? _issueList;

  List<IssueComponent>? get issueList => _issueList!;

  Future<void> fetchIssue() async {
    try {
      isLoading.value = (true);
      var orders = await ApiCalls.fetchIssue();

      _issueList = null;
      _issueList = orders;
      isLoading.value = (false);

      update();
    } finally {
      isLoading.value = (false);
      update();
    }
    update();
  }

//main
  List<IssueTypeComponent> _issueTypeList = [];

  List<IssueTypeComponent> get issueTypeList => _issueTypeList;

  Future<void> fetchIssueComponents(String id) async {
    _issueTypeList = [];
    try {
      isLoading.value = (true);
      var orders = await ApiCalls.fetchComponents(id);

      _issueTypeList = [];
      _issueTypeList = orders;
      isLoading.value = (false);

      update();
    } finally {
      isLoading.value = (false);
      update();
    }
    update();
  }

//CHeckBox Attribute

  List<CheckboxAttr>? _checkBoxList;
  List<CheckboxAttr>? get checkBoxList => _checkBoxList;

  List<CheckboxAttr> _checkList = [];
  List<CheckboxAttr> get checkList => _checkList;

  List<CheckData> _data = [];
  List<CheckData> get data => _data;

  CheckData filterData(String name) {
    _data.where((element) => element.name == name);
    return _data.first;
  }

  void filterList(String id, bool hepp, String name) {
    if (hepp) {
      List<CheckboxAttr> _checkBoxList1 = [];
      _checkBoxList1 = _checkBoxList!
          .where((element) => element.issueComponentId == id)
          .toList();
      CheckData dummy = CheckData(
        name: name,
        issues: _checkBoxList1,
      );

      _data.add(dummy);

      _checkList.addAll(_checkBoxList1);
    } else {
      _checkList.removeWhere((element) => element.issueComponentId == id);
    }
    update();
  }

  Future<void> fetchCheckBoxAttr() async {
    try {
      isLoading.value = (true);
      var orders = await ApiCalls.fetchCheckBoxAtrr();

      _checkBoxList = [];
      _checkBoxList = orders;
      isLoading.value = (false);

      update();
    } finally {
      isLoading.value = (false);
      update();
    }
    update();
  }

  //zone
  List<CgiappZones> _cgiAppZones = [];

  List<CgiappZones> get cgiAppZones => _cgiAppZones;

  Future<void> fetchCgiAppZones() async {
    _issueTypeList = [];
    try {
      isLoading.value = (true);
      var orders = await ApiCalls.fetchCgiZones();

      _cgiAppZones = [];
      _cgiAppZones = orders;
      isLoading.value = (false);

      update();
    } finally {
      isLoading.value = (false);
      update();
    }
    update();
  }

  //grades

  List<ZoneGrade> _cgiZoneGrade = [];

  List<ZoneGrade> get cgiZoneGrade => _cgiZoneGrade;

  Future<void> fetchCgiZoneGrades() async {
    _issueTypeList = [];
    try {
      isLoading.value = (true);
      var orders = await ApiCalls.fetchCgiGrades();

      _cgiZoneGrade = [];
      _cgiZoneGrade = orders;
      isLoading.value = (false);

      update();
    } finally {
      isLoading.value = (false);
      update();
    }
    update();
  }

  //components

  List<GradeComponents> _cgiGradeComponents = [];

  List<GradeComponents> get cgiGradeComponents => _cgiGradeComponents;

  Future<void> fetchCgiGradeComponents() async {
    _issueTypeList = [];
    try {
      isLoading.value = (true);
      var orders = await ApiCalls.fetchCgiGradesComponents();

      _cgiGradeComponents = [];
      _cgiGradeComponents = orders;
      isLoading.value = (false);

      update();
    } finally {
      isLoading.value = (false);
      update();
    }
    update();
  }

  // CgSlateApp? _helloValue;
  // CgSlateApp get hello => _helloValue!;

  // void addDigilab(CgSlateApp data) {
  //   _helloValue = data;

  //   update();
  // }
//  Rise Roar Revolt

  List<String> _issue = [];
  List<String> get issue => _issue;

  List<Digilab> _issueType = [];
  List<Digilab> get issueType => _issueType;

  void addMainData(Digilab data) {
    _issueType.add(data);
    update();
  }

  void addDaata(String data, int index) {
    if (_issue.contains(_issueTypeList[index].issueComponentName!)) {
      _issue.remove(data);
    } else {
      _issue.add(data);
    }
    update();
  }

  bool getVerified(String id) {
    for (int i = 0; i < _issueType.length; i++) {
      if (_issueType[i].id == id) {
        return true;
      }
    }

    return false;
  }
}

class CgSlateApp {
  String? id;
  String? name;
  String? tabletNumber;
  String? zone;
  String? grade;
  String? tabName;
  String? gameIssue;
  String? gameName;
  String? describeIssue;
  String? subject;
  String? chapter;
  String? status;
  String? resolvedDate;
  List<String>? resolvedBy;
  CgSlateApp({
    this.name,
    this.id,
    this.tabletNumber,
    this.zone,
    this.grade,
    this.tabName,
    this.gameIssue,
    this.gameName,
    this.describeIssue,
    this.subject,
    this.chapter,
    this.status,
    this.resolvedDate,
    this.resolvedBy,
  });
}

class Digilab {
  String? id;
  String? name;
  List<String>? issues;
  String? status;
  String? resolvedDate;
  List<String>? resolvedBy;

  Digilab({
    this.id,
    this.name,
    this.issues,
    this.status,
    this.resolvedDate,
    this.resolvedBy,
  });
}

class Playground {
  String? id;
  String? name;
  List<String>? issues;
  String? sliderImage;
  String? details1;
  String? seeSaw;
  String? details2;
  String? loopRung;
  String? details3;
  String? netScrambler;

  Playground(
      {this.id,
      this.name,
      this.issues,
      this.sliderImage,
      this.details1,
      this.seeSaw,
      this.details2,
      this.loopRung,
      this.details3,
      this.netScrambler});
}

class CheckData {
  String? name;
  List<CheckboxAttr>? issues;

  CheckData({this.name, this.issues});
}
