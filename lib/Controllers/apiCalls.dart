
import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:old17000ft/Model/adminLogin.dart';
import 'package:old17000ft/Model/allocateModel.dart';
import 'package:old17000ft/Model/blockModel.dart';
import 'package:old17000ft/Model/expensehead.dart';
import 'package:old17000ft/Model/generalRecordsModel.dart';
import 'package:old17000ft/Model/issue.dart';
import 'package:old17000ft/Model/issue_atrr.dart';
import 'package:old17000ft/Model/newStock_dispatch.dart';
import 'package:old17000ft/Model/pending_expenses.dart';
import 'package:old17000ft/Model/programme.dart';
import 'package:old17000ft/Model/school_data.dart';
import 'package:old17000ft/Model/staff_data.dart';
import 'package:old17000ft/Model/state_model.dart';
import 'package:old17000ft/Model/stockpurchase_model.dart';
import 'package:old17000ft/Model/tour.dart';
import 'package:old17000ft/Model/usertaskModel.dart';
import 'package:old17000ft/Model/vendorModel.dart';
import 'package:old17000ft/colors.dart';

class ApiCalls {
  static var client = http.Client();
  var id = GetStorage().read('userId');
  static Future<List<PendingExpense>> fetchPendingForms() async {
    var response = await client.get(
        Uri.parse('${MyColors.baseUrl}pending_expense.php?uid=${GetStorage().read('userId')}'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return expenseFromJson(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<StateModel> fetchState() async {
    var response = await client.get(Uri.parse('${MyColors.baseUrl}school_data.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return stateModelFromJson(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<ExpenseClaimHead>> fetchExpenseHeader() async {
    var response = await client.get(
        Uri.parse('${MyColors.baseUrl}master_expense_claim.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return expenseClaimHeadFromJson(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<Authority>> fetchAuthority() async {
    var response = await client.get(
        Uri.parse('${MyColors.baseUrl}approval_authority.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return authorityFromJson(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  // static Future<StateModel> fetchDynamic(
  //     String value, String state, String district) async {
  //   var response = await client.get(Uri.parse(MyColors.baseUrl + 'school_data'),
  //       headers: {"Accept": "application/json"});
  //   if (response.statusCode == 200) {
  //     var jsonString = response.body;
  //     return stateModelFromJson(jsonString);
  //   } else {
  //     throw Exception('Failed to load post');
  //   }
  // }

  // static Future<DistributionActivity> fetchDistribution() async {
  //   var response = await client.get(
  //       Uri.parse(MyColors.baseUrl + 'distribution_activity'),
  //       headers: {"Accept": "application/json"});
  //   if (response.statusCode == 200) {
  //     var jsonString = response.body;
  //     // print(jsonString);
  //     return distributionActivityFromMap(jsonString);
  //   } else {
  //     throw Exception('Failed to load post');
  //   }
  // }

  static Future<List<StateInfo>> fetchStateInfo() async {
    var response = await client.get(Uri.parse('${MyColors.baseUrl}block.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return stateInfoFromJson(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<ProgrammeMaster>> fetchProgram() async {
    var response = await client.get(
        Uri.parse('${MyColors.baseUrl}programme_master.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      // print(jsonString);

      return programmeMasterFromMap(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<IssueTypeComponent>> fetchComponents(String id) async {
    var response = await client.get(
        Uri.parse('${MyColors.baseUrl}issue_type_components.php?component_id=$id'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return issueTypeComponentFromMap(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<GradeComponents>> fetchCgiGradesComponents() async {
    var response = await client.get(
        Uri.parse('${MyColors.baseUrl}grade_components.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return gradeComponentsFromMap(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<ZoneGrade>> fetchCgiGrades() async {
    var response = await client.get(Uri.parse('${MyColors.baseUrl}zone_grade.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return zoneGradeFromMap(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<CheckboxAttr>> fetchCheckBoxAtrr() async {
    var response = await client.get(
        Uri.parse('${MyColors.baseUrl}issue_attribute.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return checkboxAttrFromMap(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<CgiappZones>> fetchCgiZones() async {
    var response = await client.get(
        Uri.parse('${MyColors.baseUrl}cgiapp_zones.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return cgiappZonesFromMap(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<IssueComponent>> fetchIssue() async {
    var response = await client.get(
        Uri.parse('${MyColors.baseUrl}issue_component.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return issueComponentFromMap(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<TourId>> fetchTourId() async {
    var response = await client.get(Uri.parse('${MyColors.baseUrl}tour_id.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return tourIdFromJson(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  //fetch tour ids by empId
   static Future<List<TourId>> fetchTourIdByEmp() async {
    var response = await client.get(Uri.parse('${MyColors.baseUrl}tour_id.php?emp_id=${GetStorage().read('userId')}'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print('this is response from sfsdf $jsonString');
      return tourIdFromJson(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  

  static Future<List<ExpenseHead>> fetchExpenseHead() async {
    var response = await client.get(
        Uri.parse('${MyColors.baseUrl}expense_head.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return expenseHeadFromJson(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<ExpenseHead>> fetchExpenseHeadClaim() async {
    var response = await client.get(
        Uri.parse('${MyColors.baseUrl}expenseClaimHead.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return expenseHeadFromJson(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  //Vendor name list
  //https://mis.17000ft.org/17000ft_apis/vendors.php
   static Future<List<VendorModel>> fetchVendorNameList() async {
    var response = await client.get(
        Uri.parse('${MyColors.baseUrl}vendors.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return vendorModelFromJson(jsonString);
    } else {
      throw Exception('Failed to load vendor');
    }
  }

  static Future<List<GeneralRecords>> fetchGeneralRecords() async {
    var response = await client.get(
        Uri.parse('${MyColors.baseUrl}generalRecords.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return generalRecordsFromJson(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<AllStaff>> fetchAllStaff() async {
    print('stafff get response');
    var response = await client.get(Uri.parse('${MyColors.baseUrl}allStaff.php'),
        headers: {"Accept": "application/json"});
     //print(jsonString);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return allStaffFromJson(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }




  static Future<DistrictModel> fetchData(
      String value, String state, String district) async {
    var response = await client
        .post(Uri.parse('${MyColors.baseUrl}school_data.php'), headers: {
      "Accept": "application/json"
    }, body: {
      "valueq": value,
      "state": state,
      "district": district,
    });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return districtModelFromJson(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }


  static Future<Staff> fetchStaff(String office) async {
    var response =
        await client.post(Uri.parse('${MyColors.baseUrl}staff.php'), headers: {
      "Accept": "application/json"
    }, body: {
      "office": office,
    });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return staffFromJson(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  // static Future<List<SchoolData>> readJson() async {
  //   final String response =
  //       await rootBundle.loadString('assets/json/school_basic.json');
  //   final data = await json.decode(response);

  //   return data.map<SchoolData>((json) => SchoolData.fromJson(json)).toList();

  //   // ...
  // }

//all_schools

  static Future<List<SchoolData>> readJson() async {
    var response = await client.get(
      Uri.parse('${MyColors.baseUrl}all_schools.php'),
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return schoolDataFromJson(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<BlockModel> fetchSchool(
      String value, String state, String district) async {
    var response = await client
        .post(Uri.parse('${MyColors.baseUrl}school_data.php'), headers: {
      "Accept": "application/json"
    }, body: {
      "valueq": value,
      "state": state,
      "district": district,
    });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return blockModelFromJson(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  // static Future<List<StaffDetails>> readStaff() async {
  //   final String response =
  //       await rootBundle.loadString('assets/json/employee_details.json');
  //   final data = await json.decode(response);

  //   return data
  //       .map<StaffDetails>((json) => StaffDetails.fromJson(json))
  //       .toList();

  //   // ...
  // }
  static Future<List<StockRecieved>> fetchStockRecieved() async {
    var response = await client.get(
        Uri.parse('${MyColors.baseUrl}stock_receive.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      // print("from api calls");
      // print(jsonString);
      return stockRecievedFromJson(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<StockDispatch>> fetchStockDispatch() async {
    var response = await client.get(
        Uri.parse('${MyColors.baseUrl}stock_dispatch.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;
    //  print("from api calls dispatch");
     // print(jsonString);
      return stockDispatchFromJson(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<AllocateModel>> fetchStockAllocation() async {
    var response = await client.get(
        Uri.parse('${MyColors.baseUrl}allocateSchool.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print("from api calls allocation");
      print(jsonString);
      
      return allocateModelFromJson(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<BlockModel> fetchBlock(
      String value, String state, String district) async {
    var response = await client
        .post(Uri.parse('${MyColors.baseUrl}school_data.php'), headers: {
      "Accept": "application/json"
    }, body: {
      "valueq": value,
      "state": state,
      "district": district,
    });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return blockModelFromJson(jsonString);
    } else {
      throw Exception('Failed to load post');
    }
  }

  //for forms
  // static Future<List<Forms>> fetchForms(String id) async {
  //   var response = await client.get(Uri.parse(MyColors.baseUrl + 'form_name'),
  //       headers: {"Accept": "application/json"});
  //   if (response.statusCode == 200) {
  //     var jsonString = response.body;
  //     // print("This is from forms");
  //     // print(jsonString);
  //     return formsFromJson(jsonString);
  //   } else {
  //     throw Exception("Data is not found");
  //   }
  // }

//for tasks
//for forms
  static Future<List<TaskId>> fetchTasks(String id) async {
    var response = await client.get(
        Uri.parse('${MyColors.baseUrl}emp_task.php?empId=$id'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);

      return taskIdFromJson(jsonString);
    } else {
      throw Exception("Data is not found");
    }
  }

//for tour details
 static Future<List<TourId>> fetchTourDetails() async {
    var response = await client.get(Uri.parse('${MyColors.baseUrl}tour_detail.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return tourIdFromJson(jsonString);
    } else {
      throw Exception("Data is not found");
    }
  }
// fetch tour Details by date
static Future<Map<String, dynamic>> fetchTourDetailsByDate(String tourId) async {
  print('FUNCTION is called with $tourId');
  var response = await client.post(
    Uri.parse('https://mis.17000ft.org/apis/fast_apis/DAModel.php'),
    headers: {
      "Accept": "application/json",
    },
    body: {
      "emp_id": GetStorage().read('userId'),
      "tour_id": tourId,
    },
  );

  if (response.statusCode == 200) {
    print('tour details by date is called');
    var jsonString = response.body;
    
    Map<String, dynamic> responseData = jsonDecode(jsonString);
    print('this is RESPONSE by date $jsonString and the return value $responseData');
    return responseData;
  } else {
    throw Exception('Failed to load post');
  }
}




//f ro admin login details

//for admin login details
  static Future<List<AdminLogin>> fetchAdminLogin() async {
    var response = await client.get(Uri.parse('${MyColors.baseUrl}adminLogin.php'),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return adminLoginFromJson(jsonString);
    } else {
      throw Exception("Data is not Found");
    }
  }
}
