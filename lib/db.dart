import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:old17000ft/Model/adminLogin.dart';
import 'package:old17000ft/Model/blockModel.dart';
import 'package:old17000ft/Model/expense_model.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'Controllers/networ_Controller.dart';
import 'colors.dart';

final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());

class Controller {
  final conn = SqfliteDatabaseHelper.instance;

//check internet connectivity
  static Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (_networkManager.connectionType.value == 1) {
        return true;
      } else {
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (_networkManager.connectionType.value == 2) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

//function for insert query
  Future<int> addData(
      {ExpenseModel? contactInfoModel,
      StateInfo? stateInfoModel,
      AdminLogin? adminLoginModel}) async {
    var dbclient = await conn.db;
    int result = 1;
    try {
      if (contactInfoModel != null) {
        result = await dbclient.insert(
            SqfliteDatabaseHelper.expenseInfoTable, contactInfoModel.toJson());
      } else if (stateInfoModel != null) {
        result = await dbclient.insert(
            SqfliteDatabaseHelper.stateInfoTable, stateInfoModel.toJson());
      } else if (adminLoginModel != null) {
        result = await dbclient.insert(
            SqfliteDatabaseHelper.adminLogin, adminLoginModel.toJson());
      }
    } catch (e) {}
    return result;
  }

//function for update query
  Future<int> updateData(ExpenseModel contactinfoModel) async {
    var dbclient = await conn.db;
    int result = 1;
    try {
      result = await dbclient.update(
          SqfliteDatabaseHelper.expenseInfoTable, contactinfoModel.toJson(),
          where: 'id=?', whereArgs: [contactinfoModel.tourId]);
    } catch (e) {}
    return result;
  }

//function for select query
  Future fetchData() async {
    var dbclient = await conn.db;
    List expenseList = [];
    try {
      List<Map<String, dynamic>> maps = await dbclient
          .query(SqfliteDatabaseHelper.expenseInfoTable, orderBy: 'id DESC');
      for (var item in maps) {
        if (item['userId'] == GetStorage().read('userId').toString()) {
          expenseList.add(item);
        }
      }
    } catch (e) {}
    return expenseList;
  }

//fetch state info from local db
  Future<List<StateInfo>> fetchStateData() async {
    var dbclient = await conn.db;
    List<StateInfo> stateList = [];
    try {
      List<Map<String, dynamic>> maps =
          await dbclient.rawQuery('SELECT * FROM stateInfoTable');

      for (var element in maps) {
        stateList.add(StateInfo.fromJson(element));
      }
    } catch (e) {
   
    }
    return stateList;
  }

//fetch admin login from local db
  Future<List<AdminLogin>> fetchLocalAdminLogin() async {
    var dbclient = await conn.db;
    List<AdminLogin> adminLoginList = [];
    try {
      List<Map<String, dynamic>> maps =
          await dbclient.rawQuery('SELECT * FROM adminLogin');

      for (var element in maps) {
        adminLoginList.add(AdminLogin.fromJson(element));
      }
    } catch (e) {
      // NullThrownError();
    }
    return adminLoginList;
  }

  //userlogin
  loginUser(String username, String password) async {
    if (kDebugMode) {
      print("this is offline login");
    }
    var dbclient = await conn.db;
    AdminLogin? loginUser;
    try {
      List<Map<String, dynamic>> maps = await dbclient.rawQuery(
          "SELECT * FROM adminLogin WHERE  username = $username AND password = $password");
      for (var element in maps) {
        loginUser = AdminLogin.fromJson(element);
      }
    } catch (e) {
      // NullThrownError();
    }

    return loginUser;
  }
}

//this class contains all the crud function for database
class SqfliteDatabaseHelper {
  SqfliteDatabaseHelper.internal();
  static final SqfliteDatabaseHelper instance =
      SqfliteDatabaseHelper.internal();
  factory SqfliteDatabaseHelper() => instance;
//name of the tables
  static const expenseInfoTable = 'expenseInfoTable';
  static const stateInfoTable = 'stateInfoTable';
  static const adminLogin = 'adminLogin';
  static const _version = 1;

  static Database? _db;
//function for initialization database
  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

//delete function for delete records from table
  Future<int> delete(String tableName,
      {String? where, List<dynamic>? whereArgs}) async {
    // print("delete is called for stateinfo");
    // print(tableName);
    return _db!.rawDelete(
      "DELETE FROM $tableName",
      // where: where,
      // whereArgs: whereArgs,
    );
  }

//perform tasks
  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'myadmindb.db');
    if (kDebugMode) {
      print(dbPath);
    }
    var openDb = await openDatabase(
      dbPath,
      version: _version,
      onCreate: (Database db, int newVersion) async {
        //db.execute("DELETE FROM $stateInfoTable");
        db.execute('''CREATE TABLE $expenseInfoTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          office TEXT NOT NULL,
          submissionDate TEXT NOT NULL,
          tourID TEXT NOT NULL,
          vendorName TEXT NOT NULL,
          invoiceNumber TEXT NOT NULL,
          invoiceDate TEXT NOT NULL,
          invoiceAmount TEXT NOT NULL,
          towardsCost TEXT NOT NULL,
          expenseHead TEXT NOT NULL,
          projectName TEXT NOT NULL,
          sponsorName TEXT NOT NULL,
          expenseBy TEXT NOT NULL,
          expenseApprovedBy TEXT NOT NULL,
          invoiceImage TEXT NOT NULL,
          dateOfPayment TEXT NOT NULL,
          paidBy TEXT NOT NULL,
          paymentApprovedBy TEXT NOT NULL,
          paidAmount TEXT NOT NULL,
          paymentType TEXT NOT NULL,
          paymentMode TEXT NOT NULL,
          userId TEXT NOT NULL
          )''');
        db.execute('''CREATE TABLE $stateInfoTable(
          Id INTEGER PRIMARY KEY AUTOINCREMENT, 
          stateName TEXT, 
          districtName TEXT, 
          blockName TEXT, 
          status TEXT 
         )''');

        db.execute('''CREATE TABLE $adminLogin(
          admin_Id INTEGER PRIMARY KEY AUTOINCREMENT, 
          username TEXT, 
          password TEXT, 
          admin_email TEXT, 
          role TEXT,
          office_id TEXT,
          role_name TEXT,
          office_name TEXT,
          emp_id TEXT,
          admin_level TEXT,
          version TEXT
         )''');

        // db.execute('''CREATE TABLE $adminLogin(admin_id INTEGER PRIMARY KEY AUTOINCREMENT,username TEXT,password TEXT,admin_email TEXT,role TEXT,office_id TEXT,role_name TEXT,office_name TEXT,emp_id TEXT,admin_level TEXT,version TEXT,)''');
      },
    );
    return openDb;
  }
}

class SyncronizationData {
  static Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (_networkManager.connectionType.value != 0) {
        return true;
      } else {
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (_networkManager.connectionType.value != 0) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  final conn = SqfliteDatabaseHelper.instance;

  Future<List<ExpenseModel>> fetchAllInfo() async {
    final dbClient = await conn.db;
    List<ExpenseModel> contactList = [];
    try {
      final maps = await dbClient.query(SqfliteDatabaseHelper.expenseInfoTable);
      for (var item in maps) {
        if (item['userId'] == GetStorage().read('userId').toString()) {
          contactList.add(ExpenseModel.fromJson(item));
        }
      }
    } catch (e) {
      // NullThrownError();
    }
    return contactList;
  }

  Future saveToMysqlWith(List<ExpenseModel> expenseList) async {
    for (var i = 0; i < expenseList.length; i++) {
      Map<String, dynamic> data = {
        "office": expenseList[i].office,
        "submission_date": expenseList[i].submissionDate,
        "tour_id": expenseList[i].tourId,
        "vendor_name": expenseList[i].vendorName,
        "invoice_no": expenseList[i].invoiceNumber,
        "date_of_invoice": expenseList[i].invoiceDate,
        "invoice_amt": expenseList[i].invoiceAmount,
        "towards_cost_of": expenseList[i].towardsCost,
        "expense_head": expenseList[i].expenseHead,
        "project": expenseList[i].projectName,
        "sponsor": expenseList[i].sponsorName,
        "expense_by": expenseList[i].expenseBy,
        "expense_approved_by": expenseList[i].expenseApprovedBy,
        "image": expenseList[i].invoiceImage,
        "date_of_payment": expenseList[i].dateOfPayment,
        "paid_by": expenseList[i].paidBy,
        "payment_approved_by": expenseList[i].paymentApprovedBy,
        "paid_amt": expenseList[i].paidAmount,
        "type_of_payment": expenseList[i].paymentType,
        "mode_of_payment": expenseList[i].paymentMode,
        "uid": expenseList[i].userId,
      };
      var response = await http.post(Uri.parse(MyColors.baseUrl + 'expense.php'),
          headers: {"Accept": "Application/json"}, body: data);
      if (response.statusCode == 200) {
        SqfliteDatabaseHelper().delete(SqfliteDatabaseHelper.expenseInfoTable,
            where: 'tourId=?', whereArgs: [expenseList[i].tourId]);
      } else {}
    }
  }

  Future<List> fetchAllCustomerInfo() async {
    final dbClient = await conn.db;
    List contactList = [];
    try {
      final maps = await dbClient.query(SqfliteDatabaseHelper.expenseInfoTable);
      for (var item in maps) {
        contactList.add(item);
      }
    } catch (e) {}
    return contactList;
  }
}
