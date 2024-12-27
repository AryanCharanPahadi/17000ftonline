
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:old17000ft/Controllers/apiCalls.dart';
import 'package:old17000ft/Model/adminLogin.dart';
import 'package:old17000ft/db.dart';

class AdminLoginController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<AdminLogin> _adminLogin = [];
  List<AdminLogin> get adminLogin => _adminLogin;
  static String adminLoginTable = 'adminLoginTable';

  final List<AdminLogin> _localAdminLogin = [];
  List<AdminLogin> get localAdminLogin => _localAdminLogin;

  fetchDb() async {
    if (kDebugMode) {
      print("fetchdb os called");
    }
    var data = await Controller().fetchLocalAdminLogin();
    _localAdminLogin.addAll(data as Iterable<AdminLogin>);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchAdminLogin();
    fetchDb();
  }

  void fetchAdminLogin() async {
    _isLoading = true;
    try {
      var userlogin = await ApiCalls.fetchAdminLogin();
      _adminLogin.addAll(userlogin as Iterable<AdminLogin>);

      for (int i = 0; i < _adminLogin.length; i++) {
        // SqfliteDatabaseHelper().delete(adminLoginTable);
        if (kDebugMode) {
          // print("this is from adminlogin controller loop");
        }
        //print(_adminLogin[i].username);
        Controller().addData(adminLoginModel: _adminLogin[i]);
      }
    } finally {
      update();
    }
  }
}
