// ignore_for_file: non_constant_identifier_names, unused_catch_clause, unused_field

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:old17000ft/Controllers/offlineHandler.dart';
import 'package:old17000ft/colors.dart';

final OfflineHandler _offlineHandler = Get.put(OfflineHandler());
// ignore: unused_element
final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());

class GetXNetworkManager extends GetxController {
  var connectionType = 0.obs;
  //int get connectionType => _connectionType;

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription _streamSubscription;

  // void sync() async {
  //   print('Process');
  //   if (_offlineHandler.filterdExpenses.isNotEmpty &&
  //       _networkManager.connectionType.value != 0) {
  //     print('mogliiiii');
  //     for (int i = 0; i < _offlineHandler.filterdExpenses.length;) {
  //       _offlineHandler.isLoading.value = true;
  //       var rsp = await insertData(
  //         Get.find<OfflineHandler>().filterdExpenses[0].office.toString(),
  //         Get.find<OfflineHandler>()
  //             .filterdExpenses[0]
  //             .submissionDate
  //             .toString(),
  //         Get.find<OfflineHandler>().filterdExpenses[0].tourID.toString(),
  //         Get.find<OfflineHandler>().filterdExpenses[0].vendorName.toString(),
  //         Get.find<OfflineHandler>()
  //             .filterdExpenses[0]
  //             .invoiceNumber
  //             .toString(),
  //         Get.find<OfflineHandler>().filterdExpenses[0].invoiceDate.toString(),
  //         Get.find<OfflineHandler>()
  //             .filterdExpenses[0]
  //             .invoiceAmount
  //             .toString(),
  //         Get.find<OfflineHandler>().filterdExpenses[0].towardsCost.toString(),
  //         Get.find<OfflineHandler>().filterdExpenses[0].expenseHead.toString(),
  //         Get.find<OfflineHandler>().filterdExpenses[0].projectName.toString(),
  //         Get.find<OfflineHandler>().filterdExpenses[0].sponsorName.toString(),
  //         Get.find<OfflineHandler>().filterdExpenses[0].expenseBy.toString(),
  //         Get.find<OfflineHandler>()
  //             .filterdExpenses[0]
  //             .expenseApprovedBy
  //             .toString(),
  //         Get.find<OfflineHandler>().filterdExpenses[0].invoiceImage.toString(),
  //         Get.find<OfflineHandler>()
  //             .filterdExpenses[0]
  //             .dateOfPayment
  //             .toString(),
  //         Get.find<OfflineHandler>().filterdExpenses[0].paidBy.toString(),
  //         Get.find<OfflineHandler>()
  //             .filterdExpenses[0]
  //             .paymentApprovedBy
  //             .toString(),
  //         Get.find<OfflineHandler>().filterdExpenses[0].paidAmount.toString(),
  //         Get.find<OfflineHandler>().filterdExpenses[0].paymentType.toString(),
  //         Get.find<OfflineHandler>().filterdExpenses[0].paymentMode.toString(),
  //         Get.find<OfflineHandler>().filterdExpenses[0].userId.toString(),
  //       );
  //       if (rsp['status'].toString() == '1') {
  //         i++;
  //       }
  //     }

  //     _offlineHandler.removedata();
  //     _offlineHandler.isLoading.value = false;
  //     update();
  //   }
  // }

  Future insertData(
    String office,
    String submission_date,
    String tour_id,
    String vendor_name,
    String invoice_no,
    String date_of_invoice,
    String invoice_amt,
    String towards_cost_of,
    String expense_head,
    String project,
    String sponsor,
    String expense_by,
    String expense_approved_by,
    String image,
    String date_of_payment,
    String paid_by,
    String payment_approved_by,
    String paid_amt,
    String type_of_payment,
    String mode_of_payment,
    String userId,
  ) async {
    var response =
        await http.post(Uri.parse(MyColors.baseUrl + 'expense.php'), headers: {
      "Accept": "Application/json"
    }, body: {
      "office": office,
      "submission_date": submission_date,
      "tour_id": tour_id,
      "vendor_name": vendor_name,
      "invoice_no": invoice_no,
      "date_of_invoice": date_of_invoice,
      "invoice_amt": invoice_amt,
      "towards_cost_of": towards_cost_of,
      "expense_head": expense_head,
      "project": project,
      "sponsor": sponsor,
      "expense_by": expense_by,
      "expense_approved_by": expense_approved_by,
      "image": image,
      "date_of_payment": date_of_payment,
      "paid_by": paid_by,
      "payment_approved_by": payment_approved_by,
      "paid_amt": paid_amt,
      "type_of_payment": type_of_payment,
      "mode_of_payment": mode_of_payment,
      "userId": userId
    });
    var convertedDatatoJson = jsonDecode(response.body);
    return convertedDatatoJson;
  }

  @override
  void onInit() {
    super.onInit();
    GetConnectionType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
    // print('onInit');
  }

  Future<void> GetConnectionType() async {
    ConnectivityResult? connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
      update();
    } on PlatformException catch (e) {
      update();
    }

    return _updateState(connectivityResult!);
  }

  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;
        update();
        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        update();
        break;
      default:
        Get.snackbar('Network Error', 'Failed to get Network Status');
        break;
    }
  }
}
