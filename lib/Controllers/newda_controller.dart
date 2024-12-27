import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:old17000ft/Controllers/apiCalls.dart';
import 'package:old17000ft/Controllers/state_Controller.dart';
import 'package:old17000ft/Model/blockModel.dart';

import '../forms/issue_tracker.dart';
import '../forms/tour_da.dart';

class NewDaController extends GetxController {
  final TextEditingController _daFromController = TextEditingController();
  final TextEditingController _daToController = TextEditingController();
  final TextEditingController _daDaysController = TextEditingController();
  final TextEditingController _daNightsController = TextEditingController();
  final TextEditingController _daNaFromController = TextEditingController();
  final TextEditingController _daNaToController = TextEditingController();
  final TextEditingController _daNaDaysController = TextEditingController();
  final TextEditingController _daNaNightsController = TextEditingController();
  final TextEditingController _daTotalcontroller = TextEditingController();
  final TextEditingController _daNaTotalcontroller = TextEditingController();
  final TextEditingController _daNaRemarksController = TextEditingController();

  final TextEditingController _daRemarksController = TextEditingController();
  final TextEditingController _daStateController = TextEditingController();
  final TextEditingController _daDistrictController = TextEditingController();
  final TextEditingController _daBlockController = TextEditingController();
  final TextEditingController _daVisitPlaceController = TextEditingController();
  final TextEditingController _daVisitPurposeController =
      TextEditingController();
  final TextEditingController _daController = TextEditingController();
  final TextEditingController _daTourValueController = TextEditingController();

  TextEditingController get daFromController => _daFromController;
  TextEditingController get daToController => _daToController;
  TextEditingController get daDaysController => _daDaysController;
  TextEditingController get daNightsController => _daNightsController;
  TextEditingController get daTotalController => _daTotalcontroller;

  TextEditingController get daNaFromController => _daNaFromController;
  TextEditingController get daNaToController => _daNaToController;
  TextEditingController get daNaDaysController => _daNaDaysController;
  TextEditingController get daNaNightsController => _daNaNightsController;
  TextEditingController get daNaTotalController => _daNaTotalcontroller;
  TextEditingController get daNaRemarksController => _daNaRemarksController;

  TextEditingController get daRemarksController => _daRemarksController;
  TextEditingController get daStateController => _daStateController;
  TextEditingController get daDistrictController => _daDistrictController;
  TextEditingController get daBlockController => _daBlockController;
  TextEditingController get daVisitPlaceController => _daVisitPlaceController;
  TextEditingController get daVisitPurposeController =>
      _daVisitPurposeController;
  TextEditingController get daController => _daController;
  TextEditingController get daTourValueController => _daTourValueController;

  List<StateInfo> _uniqueState = [];
  List<StateInfo> get uniqueState => _uniqueState;

  List<StateInfo> _uniqueDistrict = [];
  List<StateInfo> get uniqueDistrict => _uniqueDistrict;

  List<StateInfo> _uniqueBlock = [];
  List<StateInfo> get uniqueBlock => _uniqueBlock;

  Map<String, dynamic> _response = {};
  Map<String, dynamic> get response => _response;

  final List<DaList> _daList = [];
  List<DaList> get daList => _daList;

  final StateInfoController stateInfoController = StateInfoController();

  DateTime selectedDate = DateTime.now(), initialDate = DateTime.now();
  DateTime? _from;
  DateTime? get from => _from;
  DateTime? _to;
  DateTime? get to => _to;
  String? _tourValue;
  String? get tourValue => _tourValue;
  String? stateValue;
  String? blockValue;
  String? districtValue;

  selectDate(
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
        _daNaNightsController.clear();
        _daNightsController.clear();
        return Theme(data: theme, child: picker!);
      },
    );
    if (selected != null) {
      selectedDate = selected;
      schoolController.setDate(selected, title);
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      date.text = formattedDate;
      if (title == 'from' && _tourValue != 'NA') {
        _daToController.clear();
      } else if (title == 'from' && _tourValue == 'NA') {
        _daNaToController.clear();
        _daDaysController.clear();
        _daNaDaysController.clear();
      }
      update();
      //    (getNumber(int.parse(DateFormat('dd').format(selectedDate))));
    }
  }

  calculateDa(String nights) {
    _daTotalcontroller.text =
        ((int.parse(_daDaysController.text) + int.parse(nights)) *
                int.parse(GetStorage().read("empda")))
            .toString();
  }

  calculateNaDa(String nights) {
    _daNaTotalcontroller.text =
        ((int.parse(_daNaDaysController.text) + int.parse(nights)) *
                int.parse(GetStorage().read("empda")))
            .toString();
  }

  setTourValue(String data) {
    _tourValue = data;
    // getTourDates(data);
  
    update();
  }

  Future<Map<String, dynamic>> getTourDates(String data) async {
    _response = await ApiCalls.fetchTourDetailsByDate(data);
    update();
    return _response;
  }
  

  getStateInfo() {
    _uniqueState = [];
    _uniqueDistrict = [];
    _uniqueBlock = [];
    var seen = <String>{};
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
  }

  addDaList(DaList addDaList) {
    print('add da list is called');
    _daList.add(addDaList);
    print(_daList.length);
    update();
  }

  removeDaList(DaList index) {
    print('remove is called');
    _daList.remove(index);
    update();
  }

  clearData() {
    _daDaysController.clear();
    _daNightsController.clear();
    _daTotalcontroller.clear();
    _daRemarksController.clear();

    _daNaRemarksController.clear();
    // _daNaDaysController.clear();
    // _daNaFromController.clear();
    // _daNaToController.clear();
    _daNaNightsController.clear();
    _daVisitPlaceController.clear();
    _daVisitPurposeController.clear();
    _daNaTotalcontroller.clear();
    // _daList.clear();
    _tourValue = null;
  }
}

class DaList {
  String? tourId;
  String? fromDate;
  String? toDate;
  String? noDays;
  String? noNights;
  String? totalDailyAllowance;
  String? remarks;
  DaList({
    this.tourId,
    this.fromDate,
    this.toDate,
    this.noDays,
    this.noNights,
    this.totalDailyAllowance,
    this.remarks,
  });
}
