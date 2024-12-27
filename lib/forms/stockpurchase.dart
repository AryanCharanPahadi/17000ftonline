// ignore_for_file: unnecessary_null_comparison, avoid_unnecessary_containers, duplicate_ignore, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:old17000ft/Controllers/pendingExpenses_Controller.dart';
import 'package:old17000ft/Controllers/school_Controller.dart';
import 'package:old17000ft/Controllers/stockdispatch_controller.dart';
import 'package:old17000ft/Controllers/stockpurchase_controller.dart';
import 'package:old17000ft/Model/newStock_dispatch.dart';
import 'dart:convert';
import '../colors.dart';
import '../custom_dialog.dart';
import '../home_screen.dart';
import '../my_text.dart';
import 'da.dart';

final StateController _stateController = Get.put(StateController());
final DistrictController _districtController = Get.put(DistrictController());
final BlockController _blockController = Get.put(BlockController());
final StaffController staffController = Get.put(StaffController());
final StockPurchaseController stockController =
    Get.put(StockPurchaseController());
final StockDispatchController stockdispatchController =
    Get.put(StockDispatchController());

class StockPurchase extends StatefulWidget {
  const StockPurchase({Key? key}) : super(key: key);

  @override
  _StockPurchaseState createState() => _StockPurchaseState();
}

class _StockPurchaseState extends State<StockPurchase> {
  final TextEditingController _toController = TextEditingController();

  List<String> dispatchitemListArray = [];
  List<String> itemQtyList = [];
  List<String> itemIdList = [];
  List<String> itemNameList = [];


  //MEthod for getDispatchItem List
  getdispatchitemList(String key, bool value, StockDispatch stockObj) {
    if (value == false) {
      dispatchitemListArray.remove(key);
      for (int i = 0; i < stockdispatchController.addStockItem.length; i++) {
        if (stockdispatchController.addStockItem[i].itemName == key) {
          stockdispatchController.addStockItem
              .remove(stockdispatchController.addStockItem[i]);
        }
      }
    } else {
      dispatchitemListArray.add(key);
      stockdispatchController.addStockItem.add(stockObj);
    }
  }
var isLoading = false.obs;

 @override
  void initState() {
    super.initState();
      stockdispatchController.filterList();
   }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: const Color(0xFF8A2724),
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text(
        'Stock for Receiving',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ),
    body: GetBuilder<StockDispatchController>(
      init: StockDispatchController(),
      builder: (stockdispatchController) {
        stockdispatchController.filterList();
        return stockdispatchController.isLoading || isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : stockdispatchController.uniqueDispatchList!.isEmpty
                ? Center(
                  child: Column(
                    children: [
                        const SizedBox(height: 300,),

                      const Center(
                          child: Text(
                          'No Data Found',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        TextButton(onPressed: ()async{
                          stockdispatchController.fetchStockDispatch();
                  
                        }, child: const Text('Tap to Refresh',style:TextStyle(color: Color(0xFF8A2724))))
                    ],
                  ),
                )
                : RefreshIndicator(
                  color: Colors.red,
                    onRefresh: () async {
                      // Call the function to refresh data
                      stockdispatchController.filterList();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: stockdispatchController
                                  .uniqueDispatchCommonId!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        bottomSheet1(
                                          context: context,
                                          title: 'Items',
                                          commonid: stockdispatchController
                                              .uniqueDispatchCommonId![index]
                                              .dispatchCommonId!
                                              .toString(),
                                        );
                                        stockdispatchController.getItem(
                                          stockdispatchController
                                              .uniqueDispatchCommonId![index]
                                              .dispatchCommonId!,
                                        );
                                      },
                                      child: ListTile(
                                        leading: const Icon(
                                          Icons.list,
                                          color: Colors.black,
                                        ),
                                        title: Text(
                                          stockdispatchController
                                              .uniqueDispatchCommonId![index]
                                              .dispatchCommonId!,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        subtitle: Text(
                                          stockdispatchController
                                              .uniqueDispatchCommonId![index]
                                              .dateOfDispatch!
                                              .toString(),
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.black,
                                      thickness: 1,
                                      indent: 2,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
      },
    ),
  );
}


  void bottomSheet1(
      {required BuildContext context,
      required String title,
      required String commonid}) {
    Map<String, bool> map = {};
    List<String> filtername = [];
    showModalBottomSheet<void>(
      context: context,
      // isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return GetBuilder<StockDispatchController>(
            builder: (newIssueTrackerController) {
          stockdispatchController.filterList();
         return Scaffold(
              resizeToAvoidBottomInset: true,
              body: StatefulBuilder(builder: (BuildContext context, setState) {
                return LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.minHeight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Wrap(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(Icons.close)),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Center(
                                    child: Text('$title of $commonid',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ),
                                ),
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: stockdispatchController
                                                .dispatchItemList!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              // print('value of index');
                                              // print(index);
                                              int count = index + 1;
                                              stockdispatchController
                                                  .addController();
                                              stockdispatchController
                                                  .setControllerQty(index);
                                              var qty1 = stockdispatchController
                                                  .dispatchItemList![index]
                                                  .itemQty;
                                              var name = stockdispatchController
                                                  .dispatchItemList![index]
                                                  .itemName;
                                              var itemid =
                                                  stockdispatchController
                                                      .dispatchItemList![index]
                                                      .itemUniqueId!;
                                              var dispatchid =
                                                  stockdispatchController
                                                      .dispatchItemList![index]
                                                      .dispatchCommonId!;
                                              var qty = stockdispatchController
                                                  .qtyControllers[index].text;
                                              List<String> itemname = [];
                                              itemname.add(name!);
                                              map = {
                                                for (var e in itemname)
                                                  // e.itemName: {
                                                  e: false,
                                              };
                                              return Column(
                                                children: [
                                                  InkWell(
                                                    onTap: (() {}),
                                                    child: ListBody(
                                                      children: map.keys
                                                          .map((String key) {
                                                        return CheckboxListTile(
                                                          activeColor:
                                                              Colors.green,
                                                          controlAffinity:
                                                              ListTileControlAffinity
                                                                  .trailing,
                                                          title: Text(key),
                                                          value:
                                                              dispatchitemListArray
                                                                  .contains(
                                                                      key),
                                                          subtitle:
                                                              dispatchitemListArray
                                                                      .contains(
                                                                          key)
                                                                  ? TextField(
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      onChanged:
                                                                          (value) {
                                                                        print(
                                                                            'onchanges is called');
                                                                        stockdispatchController
                                                                            .dispatchItemList![index]
                                                                            .itemQty = value;

                                                                        stockdispatchController.getQty(
                                                                            stockdispatchController.dispatchItemList![index].itemQty!,
                                                                            itemid);
                                                                      },
                                                                      controller:
                                                                          stockdispatchController
                                                                              .qtyControllers[index],
                                                                    )
                                                                  : TextField(
                                                                      onTap:
                                                                          () {
                                                                        const snackdemo =
                                                                            SnackBar(
                                                                          content:
                                                                              Text('Please Select Item First'),
                                                                          backgroundColor:
                                                                              Color(0xFF8A2724),
                                                                          elevation:
                                                                              10,
                                                                          duration:
                                                                              Duration(seconds: 2),
                                                                          behavior:
                                                                              SnackBarBehavior.floating,
                                                                          margin:
                                                                              EdgeInsets.all(5),
                                                                        );
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(snackdemo);
                                                                      },
                                                                      //enabled: false,
                                                                      onChanged:
                                                                          (value) {
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      decoration:
                                                                          InputDecoration(
                                                                              hintText: qty1),
                                                                      // controller:
                                                                      //     _qtyControllers[
                                                                      //         index],
                                                                      readOnly:
                                                                          true,
                                                                    ),
                                                          secondary: Text(
                                                              count.toString(),
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      18)),
                                                          onChanged: (value) {
                                                            print(
                                                                'on changed qty');
                                                            StockDispatch
                                                                stockDispatch =
                                                                StockDispatch(
                                                              itemName: key,
                                                              itemQty: qty,
                                                              itemUniqueId:
                                                                  itemid,
                                                              dispatchCommonId:
                                                                  dispatchid,
                                                              officeId: GetStorage()
                                                                  .read(
                                                                      "office"),
                                                              receivedBy:
                                                                  GetStorage().read(
                                                                      "user_id"),
                                                              receivedDate:
                                                                  '2022-11-21',
                                                            );

                                                            getdispatchitemList(
                                                                key,
                                                                value!,
                                                                stockDispatch);
                                                            setState(() {
                                                              print(
                                                                  'set state is called');
                                                              qty1 = stockdispatchController
                                                                  .dispatchItemList![
                                                                      index]
                                                                  .itemQty;
                                                              print(qty1);
                                                            });
                                                            print(
                                                                'qty before setcontroller qty');
                                                            print(stockdispatchController
                                                                .dispatchItemList![
                                                                    index]
                                                                .itemQty);
                                                          },
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                      ),
                                      stockdispatchController
                                              .addStockItem.isNotEmpty
                                          ? SizedBox(
                                              width: double.infinity,
                                              height: 45,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor: const Color(
                                                              0xFF8A2724),
                                                          elevation: 0),
                                                  child: Text("Submit",
                                                      style: MyText.subhead(
                                                              context)!
                                                          .copyWith(
                                                              color: Colors
                                                                  .white)),
                                                  onPressed: () async {
                                                    for (int i = 0;
                                                        i <
                                                            stockdispatchController
                                                                .addStockItem
                                                                .length;
                                                        i++) {
                                                      itemNameList.add(
                                                          stockdispatchController
                                                              .addStockItem[i]
                                                              .itemName!);
                                                      itemIdList.add(
                                                          stockdispatchController
                                                              .addStockItem[i]
                                                              .itemUniqueId!);
                                                      itemQtyList.add(
                                                          stockdispatchController
                                                              .addStockItem[i]
                                                              .itemQty!);
                                                    }
                                                    final nameItem =
                                                        itemNameList
                                                            .toString()
                                                            .replaceAll("[", "")
                                                            .replaceAll(
                                                                "]", "");
                                                    final qtyItem = itemQtyList
                                                        .toString()
                                                        .replaceAll("[", "")
                                                        .replaceAll("]", "");

                                                    final idItem = itemIdList
                                                        .toString()
                                                        .replaceAll("[", "")
                                                        .replaceAll("]", "");
                                                    var rsp =
                                                        await insert_stockrecieve(
                                                            nameItem.toString(),
                                                            // GetStorage()
                                                            //     .read("office"),
                                                            GetStorage()
                                                                .read("office"),
                                                            idItem.toString(),
                                                            commonid,
                                                            qtyItem.toString(),
                                                            GetStorage()
                                                                .read('userId'),
                                                            '2022-11-21');
                                                            print('this is response i Got');
                                                            print(rsp);
                                                    // print('insert is called $rsp');
                                                    // print(rsp['status']);
                                                   if (rsp['status'].toString() == '1') {
  // Dismiss the bottom sheet before showing the dialog
  Navigator.pop(context);

  // Clear all the lists and controllers
  stockdispatchController.addStockItem.clear();
  dispatchitemListArray.clear();
  itemNameList.clear();
  itemIdList.clear();
  itemQtyList.clear();

  // Show the success dialog
  showDialog(
    context: context,
    builder: (_) => const CustomEventDialog(
      title: 'Home',
      head: 'Submit',
      desc: 'Data Submit Successfully',
    ),
  );
} else {
  // Show an error dialog if submission fails
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Something Went Wrong'),
        content: const Text('Try Again!!'),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
                    }))
                                          : const SizedBox(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
              }));
        });
      },
    );

    //*************************CGslate Technical  End bottomsheet to add Staff***************************
  }

  Future insert_stockrecieve(
    String? itemName,
    // String? officeId,
    String? officeName,
    String? itemuniqueId,
    String? dispatchid,
    String? itemQty,
    String? facilitatorId,
    String? receivedDate,
  ) async {
    print('insert stock is called');
    print(itemName);
    // print(officeId);
    print(officeName);
    print(itemuniqueId);
    print(dispatchid);
    print(itemQty);
    print(facilitatorId);
    print(receivedDate);

    var response = await http
        .post(Uri.parse('${MyColors.baseUrl}insert_stock_receive.php'), headers: {
      "Accept": "Application/json"
    }, body: {
      'item_name': itemName,
      // 'office_id': officeId,
      'office_name': officeName,
      'item_unique_id': itemuniqueId,
      'dispatch_common_id': dispatchid,
      'item_qty': itemQty,
      'facilitator_id': facilitatorId,
      'received_date': receivedDate,
    });
    print(response);
     print(response.body);
    var convertedDatatoJson = jsonDecode(response.body);
    print('response i got from stao');
    print(convertedDatatoJson);
    return convertedDatatoJson;
  }
}
