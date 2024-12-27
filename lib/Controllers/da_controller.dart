// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:old17000ft/Model/tour.dart';
import 'package:old17000ft/colors.dart';

import '../Model/staff_data.dart';
import '../forms/issue_tracker.dart';
import '../forms/tour_da.dart';

class DaController extends GetxController {
  final bool? _isLoading = false;
  bool? get isLoading => _isLoading;

  //for login
  String? _selectedRadio;
  String? get selectedRadio => _selectedRadio;

  final List<String> _officeList = [
    ...GetStorage()
        .read('officeList')
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',')
  ];
  List<String> get officeList => _officeList;

  // void addOffice(List<String> office) {
  //   _officeList = [];
  //   _officeList.addAll(office);
  //   print('office list is $office');
  //   print(_officeList);

  //   update();
  // }

  void setRadio(String? value) {
    _selectedRadio = value;
    update();
  }

  final TextEditingController _fromController = TextEditingController();

  final TextEditingController _toController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();

  String? _tourValue;
  String? get tourValue => _tourValue;
  String? _days;
  String? get days => _days;
  String? _da;
  String? get da => _da;
  double? _myda;
  double? get myda => _myda;
  final List<TourId>? _minetour = [];
  List<TourId>? get minetour => _minetour;

  final List<StaffDetails> _staffDetails = [];
  List<StaffDetails> get staffDetails => _staffDetails;

  double? _grandDA = 0.00;
  double? get grandDAList => _grandDA;

  final List<String> _empName = [];
  List<String> get empName => _empName;

  final List<String> _empFrom = [];
  List<String> get empFrom => _empFrom;

  final List<String> _empTo = [];
  List<String> get empTo => _empTo;

  final List<String> _empDays = [];
  List<String> get empDays => _empDays;

  final List<String> _empNights = [];
  List<String> get empNights => _empNights;

  final List<String> _empDa = [];
  List<String> get empDa => _empDa;

  final List<String> _empRemark = [];
  List<String> get empRemark => _empRemark;

  void addData(StaffDetails staffDetails) {
    _staffDetails.add(staffDetails);
    update();
  }

  assign() {
    _demo = staffController.staffList[0].data;
  }

  List<Datum>? _demo;
  List<Datum> get demo => _demo!;

  checkStafff() {
    for (var element in _staffDetails) {
      for (var hello in _demo!) {
        if (hello.firstName! + ' ' + hello.lastName! == element.name) {
          _demo!.remove(hello);

          update();
          print(demo);
        }
      }
    }
  }

  addName(String name) {}

  void setTotalDa(double set) {
    _grandDA = 0.0;
  }

  void addDA(double da) {
    _grandDA = _grandDA! + da;
    print('total da is');
    print(_grandDA);
    update();
  }

  void removeDa(StaffDetails da) {
    _staffDetails.remove(da);
    _empName.remove(da.name);
    _empFrom.remove(da.from);
    _empTo.remove(da.to);
    _empDays.remove(da.days);
    _empNights.remove(da.nights);
    // ignore: list_remove_unrelated_type
    _empDa.remove(da.empDa);
    _empRemark.remove(da.remark);

    _grandDA = _grandDA! - da.empDa!;
    update();
  }

  void addFrom(String from) {
    _empFrom.add(from);
    update();
  }

  void addTo(String to) {
    _empTo.add(to);
    update();
  }

  void addDays(String days) {
    _empDays.add(days);
    update();
  }

  void addNights(String nights) {
    _empNights.add(nights);
    update();
  }

  void addEmpDa(String empDa) {
    _empDa.add(empDa);
    update();
  }

  void addRemark(String remark) {
    _empRemark.add(remark);
    update();
  }
  //

  void removeData(StaffDetails staffDetails) {
    _staffDetails.remove(staffDetails);
    update();
  }

  String? _staffName;
  String? get staffName => _staffName;
  // final List<String> _helpData = [];
  // List<String> get helpData => _helpData;

  setStaffName(String? data) {
    print('hello $data');
    if (_empName.contains(data)) {
      Get.defaultDialog(
        title: 'Alert',
        middleText: 'This staff is already added',
        confirm: ElevatedButton(
          style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primary,

          ),
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Ok',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      _staffName = data;
      _empName.add(_staffName!);
    }

    update();
  }

  void setHelp(String? type, String? a) {
    if (type == 'day') {
    } else if (type == 'da') {
    } else if (type == 'tour') {}
  }

  void clearData() {
    _fromController.clear();
    _toController.clear();
    _daysController.clear();
    _nightcountController.clear();
    _totalEmpDaController.clear();
    _staffName = null;
    remark.clear();

    update();
  }

  final bool? _validateTour = false;
  bool? get validateTour => _validateTour;

  final bool? _validateFrom = false;
  bool? get validateFrom => _validateFrom;

  final bool? _validateTo = false;
  bool? get validateTo => _validateTo;

  final bool? _validateStaff = false;
  bool? get validateStaff => _validateStaff;

  void validateDa() {}

  TextEditingController get fromController => _fromController;

  TextEditingController get toController => _toController;

  TextEditingController get daysController => _daysController;

  final TextEditingController _totalEmpDaController = TextEditingController();
  TextEditingController get totalEmpDaController => _totalEmpDaController;

  final TextEditingController _nightcountController = TextEditingController();
  TextEditingController get nightcountController => _nightcountController;

  final TextEditingController _remark = TextEditingController();
  TextEditingController get remark => _remark;

  DateTime selectedDate = DateTime.now(), initialDate = DateTime.now();
  DateTime? _from;
  DateTime? get from => _from;
  DateTime? _to;
  DateTime? get to => _to;

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
        return Theme(data: theme, child: picker!);
      },
    );
    if (selected != null) {
      selectedDate = selected;
      schoolController.setDate(selected, title);
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      date.text = formattedDate;
      if (title == 'from') {
        _toController.clear();
      }
      update();
      //    (getNumber(int.parse(DateFormat('dd').format(selectedDate))));

    }
  }

  // findGrandDA(){
  //   for(int i=0;i<staffDetails.length;i++){
  //     _grandDA = _grandDA! + double.parse(staffDetails[i].empDa!);

  //   }
  //   print('finalDA from findGrandDA $_grandDA');

  //   return _grandDA;
  // }

  setDate(DateTime date, String a) {
    if (a == 'from') {
      _from = date;
    } else if (a == 'to') {
      _to = date;
    }
    update();
  }

//expenseClaim Head
// fetchExpenseHeader

// }
// void fetchForms() async {
//     try {
//       _isLoading = (true);
//       var orders = await ApiCalls.fetchForms();
//       if (orders != null) {

}

class StaffDetails {
  String? name;
  String? from;
  String? to;
  String? days;
  String? nights;
  double? empDa;
  String? remark;
  double? totalda = 0;
  // List<int> _dalist=[];
  // List<int>? get dalist => _dalist;

  StaffDetails(
      {this.name,
      this.from,
      this.to,
      this.days,
      this.nights,
      this.empDa,
      this.remark});
  // calTotalDa(){
  // _dalist.add(int.parse(empDa!));
  // return _dalist.length;
  // }

}
