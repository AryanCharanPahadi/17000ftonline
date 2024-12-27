// // ignore_for_file: unnecessary_null_comparison, avoid_unnecessary_containers

// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:old17000ft/Controllers/pendingExpenses_Controller.dart';
// import 'package:old17000ft/Controllers/school_Controller.dart';
// import 'package:old17000ft/Controllers/stockdispatch_controller.dart';
// import 'package:old17000ft/Controllers/stockpurchase_controller.dart';
// import 'dart:convert';
// import '../colors.dart';
// import '../my_text.dart';
// import 'da.dart';
// import 'issue_tracker.dart';

// final StateController _stateController = Get.put(StateController());
// final DistrictController _districtController = Get.put(DistrictController());
// final BlockController _blockController = Get.put(BlockController());
// final StaffController staffController = Get.put(StaffController());
// final StockPurchaseController stockController =
//     Get.put(StockPurchaseController());
// final StockDispatchController stockdispatchController =
//     Get.put(StockDispatchController());

// class StockPurchase extends StatefulWidget {
//   const StockPurchase({Key? key}) : super(key: key);

//   @override
//   _StockPurchaseState createState() => _StockPurchaseState();
// }

// class _StockPurchaseState extends State<StockPurchase> {
//   final TextEditingController _toController = TextEditingController();
//   final List<TextEditingController> _qtyControllers = [];

//   setQty(String qtyvalue, int index) {
//     print('setqty is called');
//     print(index);
//     print(qtyvalue);

//     setState(() {
//       _qtyControllers[index].text = qtyvalue;
//     });
//   }

//   String? stateValue;
//   String? districtValue;
//   String? blockValue;
//   String? dropdownValue3;
//   String? dropdownValue4;
//   String? dropdownValue5;
//   String? dropdownValue6;
//   String? dropdownValue7;
//   bool? itemValue;

//   int? from;
//   int? to;

//   var isLoading = false.obs;
//   getNumber(int a) {
//     return a;
//   }

//   //bool _validateState = false;

//   DateTime selectedDate = DateTime.now(), initialDate = DateTime.now();

//   _selectDate(
//     BuildContext context,
//     TextEditingController date,
//     String title,
//   ) async {
//     final DateTime? selected = await showDatePicker(
//       locale: const Locale('en', 'IN'),
//       context: context,
//       initialDate: title == 'to' ? schoolController.from! : DateTime.now(),
//       firstDate: title == 'to' ? schoolController.from! : DateTime(2017),
//       lastDate: DateTime(2040),
//       builder: (context, picker) {
//         return Theme(data: theme, child: picker!);
//       },
//     );
//     if (selected != null) {
//       setState(() {
//         selectedDate = selected;
//         schoolController.setDate(selected, title);
//         String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
//         date.text = formattedDate;
//         if (title == 'from') {
//           _toController.clear();
//         }
//         //    (getNumber(int.parse(DateFormat('dd').format(selectedDate))));
//       });
//     }
//   }

//   // int daysBetween(DateTime from, DateTime to) {
//   //   from = DateTime(from.day);
//   //   to = DateTime(to.day);
//   //   return (to.difference(from).inHours / 24).round();
//   // }

//   @override
//   void initState() {
//     super.initState();

//     //  _districtController.fetchDistrict('LADAKH');

//     // for (int i = 0; i <= stateController.stateList.data!.length; i++) {
//     //   state.add(stateController.stateList.data![i].state!);
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF8A2724),
//           title: const Text(
//             'Stock for Receiving',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//             ),
//           ),
//         ),
//         body: GetBuilder<StockDispatchController>(
//             init: StockDispatchController(),
//             builder: (stockdispatchController) {
//               stockdispatchController.filterList();
//               return Obx(
//                 () => stockdispatchController.isLoading || isLoading.value
//                     ? const Center(child: CircularProgressIndicator())
//                     // ignore: avoid_unnecessary_containers
//                     : stockdispatchController.uniqueDispatchCommonId!.isEmpty
//                         ? const Center(
//                             child: Text(
//                             'No Data Found',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ))
//                         : SingleChildScrollView(
//                             child: Column(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(12.0),
//                                   child: ListView.builder(
//                                       physics:
//                                           const NeverScrollableScrollPhysics(),
//                                       shrinkWrap: true,
//                                       scrollDirection: Axis.vertical,
//                                       itemCount: stockdispatchController
//                                           .uniqueDispatchCommonId!.length,
//                                       itemBuilder:
//                                           (BuildContext context, int index) {
//                                         _qtyControllers
//                                             .add(TextEditingController());
//                                         _qtyControllers[index].text =
//                                             stockdispatchController
//                                                 .uniqueDispatchCommonId![index]
//                                                 .itemQty!
//                                                 .toString();

//                                         return Column(
//                                           children: [
//                                             InkWell(
//                                               onTap: (() {
//                                                 bottomSheet1(
//                                                     context: context,
//                                                     title: 'Items',
//                                                     commonid:
//                                                         stockdispatchController
//                                                             .uniqueDispatchCommonId![
//                                                                 index]
//                                                             .dispatchCommonId!
//                                                             .toString());
//                                                 stockdispatchController.getItem(
//                                                     stockdispatchController
//                                                         .uniqueDispatchCommonId![
//                                                             index]
//                                                         .dispatchCommonId!);
//                                               }),
//                                               child: ListTile(
//                                                 leading: const Icon(Icons.list,
//                                                     color: Colors.black),
//                                                 // Text(stockdispatchController.dispatchList[index].itemQty!.toString())
//                                                 title: Text(
//                                                   stockdispatchController
//                                                       .uniqueDispatchCommonId![
//                                                           index]
//                                                       .dispatchCommonId!,
//                                                   style: const TextStyle(
//                                                       color: Colors.black),
//                                                 ),
//                                                 subtitle: Text(
//                                                     stockdispatchController
//                                                         .uniqueDispatchCommonId![
//                                                             index]
//                                                         .dateOfDispatch!
//                                                         .toString()),
//                                                 // subtitle: SizedBox(
//                                                 //   width: 400,
//                                                 //   child: TextField(
//                                                 //     onSubmitted: (value) {},
//                                                 //     maxLines: 1,
//                                                 //     controller:
//                                                 //         _qtyControllers[index],
//                                                 //     decoration: InputDecoration(
//                                                 //         contentPadding:
//                                                 //             const EdgeInsets.only(
//                                                 //                 top: -12,
//                                                 //                 left: 6),
//                                                 //         // border: new OutlineInputBorder(
//                                                 //         //     borderSide: new BorderSide(
//                                                 //         //         color: Colors.teal)),
//                                                 //         hintText:
//                                                 //             "Enter recieved quantity",
//                                                 //         hintStyle: MyText.body1(
//                                                 //                 context)!
//                                                 //             .copyWith(
//                                                 //                 color: MyColors
//                                                 //                     .grey_40)),
//                                                 //   ),
//                                                 // ),
//                                                 // secondary: const Icon(Icons.list,
//                                                 //     color: Colors.black),
//                                                 // autofocus: false,
//                                                 // activeColor: Colors.green,
//                                                 // checkColor: Colors.white,
//                                                 // selected: true,
//                                                 // value: stockdispatchController
//                                                 //     .getitemid
//                                                 //     .contains(stockdispatchController
//                                                 //         .uniqueDispatchCommonId![
//                                                 //             index]
//                                                 //         .itemName!),
//                                                 // onChanged: (bool? value) {
//                                                 //   stockdispatchController
//                                                 //       .getReceivedItem(
//                                                 //           stockdispatchController
//                                                 //               .uniqueDispatchCommonId![
//                                                 //                   index]
//                                                 //               .itemName!
//                                                 //               .toString());
//                                                 //   stockdispatchController
//                                                 //       .getReceivedQty(
//                                                 //           _qtyControllers[index]
//                                                 //               .text);
//                                                 //   // stockdispatchController
//                                                 //   //     .getPurchaseid(
//                                                 //   //         stockdispatchController
//                                                 //   //             .dispatchList[index]
//                                                 //   //             .purchaseId
//                                                 //   //             .toString());
//                                                 //   stockdispatchController
//                                                 //       .getitemuniqueid(
//                                                 //           stockdispatchController
//                                                 //               .uniqueDispatchCommonId![
//                                                 //                   index]
//                                                 //               .itemUniqueId
//                                                 //               .toString());
//                                                 //   stockdispatchController
//                                                 //       .getDispatchId(
//                                                 //           stockdispatchController
//                                                 //               .uniqueDispatchCommonId![
//                                                 //                   index]
//                                                 //               .dispatchCommonId
//                                                 //               .toString());
//                                                 //   // stockdispatchController.getEditQty(
//                                                 //   //     _qtyControllers[index].text);

//                                                 //   print(_qtyControllers[index]
//                                                 //       .text);

//                                                 //   print(stockdispatchController
//                                                 //       .getitemid
//                                                 //       .toString());
//                                                 //   print(stockdispatchController
//                                                 //       .getitemqty);
//                                                 //   print(stockdispatchController
//                                                 //       .getpurchaseid
//                                                 //       .toString());
//                                                 //   print(stockdispatchController
//                                                 //       .getdispatchid
//                                                 //       .toString());
//                                                 //   // print(stockdispatchController
//                                                 //   //     .geteditqty
//                                                 //   //     .toString());

//                                                 //   // setState(() {
//                                                 //   //   _value = value;
//                                                 //   // });
//                                                 // },
//                                               ),
//                                             ),
//                                             const Divider(
//                                               color: Colors.black,
//                                               thickness: 1,
//                                               indent: 2,
//                                             ),
//                                           ],
//                                         );
//                                       }),
//                                 ),
//                               ],
//                             ),
//                           ),
//                 //  ),
//               );
//             }));
//   }

//   void bottomSheet1(
//       {required BuildContext context,
//       required String title,
//       required String commonid}) {
//     showModalBottomSheet<void>(
//       context: context,
//       // isScrollControlled: true,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(24), topRight: Radius.circular(24)),
//       ),
//       builder: (BuildContext context) {
//         return GetBuilder<StockDispatchController>(
//             builder: (newIssueTrackerController) {
//           return Scaffold(
//               resizeToAvoidBottomInset: true,
//               body: StatefulBuilder(builder: (BuildContext context, setState) {
//                 return LayoutBuilder(builder:
//                     (BuildContext context, BoxConstraints constraints) {
//                   return SingleChildScrollView(
//                     child: ConstrainedBox(
//                       constraints: BoxConstraints(
//                         minHeight: constraints.minHeight,
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(13.0),
//                         child: Wrap(
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: <Widget>[
//                                 InkWell(
//                                     onTap: () {
//                                       Navigator.pop(context);
//                                     },
//                                     child: const Icon(Icons.close)),
//                                 Padding(
//                                   padding: const EdgeInsets.all(15.0),
//                                   child: Center(
//                                     child: Text(title + ' of ' + commonid,
//                                         style: const TextStyle(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black)),
//                                   ),
//                                 ),
//                                 SingleChildScrollView(
//                                   child: Column(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(12.0),
//                                         child: ListView.builder(
//                                             physics:
//                                                 const NeverScrollableScrollPhysics(),
//                                             shrinkWrap: true,
//                                             scrollDirection: Axis.vertical,
//                                             itemCount: stockdispatchController
//                                                 .dispatchItemList!.length,
//                                             itemBuilder: (BuildContext context,
//                                                 int index) {
//                                               int count = index + 1;
//                                               _qtyControllers
//                                                   .add(TextEditingController());
//                                               // var qty = stockdispatchController
//                                               //     .dispatchItemList![index]
//                                               //     .dispatchQty;
//                                               // _qtyControllers[index].text =
//                                               //     qty!;

//                                               return Column(
//                                                 children: [
//                                                   InkWell(
//                                                     onTap: (() {}),
//                                                     child: CheckboxListTile(
//                                                       // leading: const Icon(Icons.list,
//                                                       //     color: Colors.black),
//                                                       // Text(stockdispatchController.dispatchList[index].itemQty!.toString())
//                                                       title: Text(
//                                                         stockdispatchController
//                                                             .dispatchItemList![
//                                                                 index]
//                                                             .itemName!,
//                                                         style: const TextStyle(
//                                                             color:
//                                                                 Colors.black),
//                                                       ),
//                                                       // subtitle: Text(
//                                                       //     stockdispatchController
//                                                       //         .dispatchItemList![
//                                                       //             index]
//                                                       //         .dateOfDispatch!
//                                                       //         .toString()),
//                                                       subtitle: SizedBox(
//                                                         width: 400,
//                                                         child: TextField(
//                                                           onEditingComplete:
//                                                               () {
//                                                             // print(
//                                                             //     'on editing is called');
//                                                             // print(
//                                                             //     _qtyControllers[
//                                                             //             index]
//                                                             //         .text);
//                                                             //  setQty(index);
//                                                           },
//                                                           maxLines: 1,
//                                                           controller:
//                                                               _qtyControllers[
//                                                                   index],
//                                                           decoration:
//                                                               InputDecoration(
//                                                                   contentPadding:
//                                                                       const EdgeInsets
//                                                                               .only(
//                                                                           top:
//                                                                               -12,
//                                                                           left:
//                                                                               6),
//                                                                   // border: new OutlineInputBorder(
//                                                                   //     borderSide: new BorderSide(
//                                                                   //         color: Colors.teal)),
//                                                                   hintText:
//                                                                       "Enter recieved quantity",
//                                                                   hintStyle: MyText
//                                                                           .body1(
//                                                                               context)!
//                                                                       .copyWith(
//                                                                           color:
//                                                                               MyColors.grey_40)),
//                                                         ),
//                                                       ),
//                                                       secondary: Text(
//                                                           count.toString(),
//                                                           style:
//                                                               const TextStyle(
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                   color: Colors
//                                                                       .black,
//                                                                   fontSize:
//                                                                       18)),
//                                                       autofocus: false,
//                                                       activeColor: Colors.green,
//                                                       checkColor: Colors.white,
//                                                       selected: true,
//                                                       value: stockdispatchController
//                                                           .getitemid
//                                                           .contains(
//                                                               stockdispatchController
//                                                                   .dispatchItemList![
//                                                                       index]
//                                                                   .itemName!),
//                                                       onChanged: (bool? value) {
//                                                         stockdispatchController
//                                                             .getReceivedItem(
//                                                                 stockdispatchController
//                                                                     .dispatchItemList![
//                                                                         index]
//                                                                     .itemName!
//                                                                     .toString());
//                                                         stockdispatchController
//                                                             .getReceivedQty(
//                                                                 _qtyControllers[
//                                                                         index]
//                                                                     .text);
//                                                         //   // stockdispatchController
//                                                         //   //     .getPurchaseid(
//                                                         //   //         stockdispatchController
//                                                         //   //             .dispatchList[index]
//                                                         //   //             .purchaseId
//                                                         //   //             .toString());
//                                                         stockdispatchController
//                                                             .getitemuniqueid(
//                                                                 stockdispatchController
//                                                                     .dispatchItemList![
//                                                                         index]
//                                                                     .itemUniqueId
//                                                                     .toString());
//                                                         stockdispatchController
//                                                             .getDispatchId(
//                                                                 stockdispatchController
//                                                                     .dispatchItemList![
//                                                                         index]
//                                                                     .dispatchCommonId
//                                                                     .toString());
//                                                         // stockdispatchController.getEditQty(
//                                                         //     _qtyControllers[index].text);
//                                                         print(
//                                                             'from changed bool value');
//                                                         print(_qtyControllers[
//                                                                 index]
//                                                             .text);

//                                                         print(
//                                                             stockdispatchController
//                                                                 .getitemid
//                                                                 .toString());
//                                                         print(
//                                                             stockdispatchController
//                                                                 .getitemqty);
//                                                         print(
//                                                             stockdispatchController
//                                                                 .getpurchaseid
//                                                                 .toString());
//                                                         print(
//                                                             stockdispatchController
//                                                                 .getdispatchid
//                                                                 .toString());
//                                                         // print(stockdispatchController
//                                                         //     .geteditqty
//                                                         //     .toString());

//                                                         // setState(() {
//                                                         //   _value = value;
//                                                         // });
//                                                       },
//                                                     ),
//                                                   ),

//                                                   // const Divider(
//                                                   //   color: Colors.black,
//                                                   //   thickness: 1,
//                                                   //   indent: 2,
//                                                   // ),
//                                                 ],
//                                               );
//                                             }),
//                                       ),
//                                       SizedBox(
//                                           width: double.infinity,
//                                           height: 45,
//                                           child: ElevatedButton(
//                                               style: ElevatedButton.styleFrom(
//                                                   backgroundColor:
//                                                       const Color(0xFF8A2724),
//                                                   elevation: 0),
//                                               child: Text("Submit",
//                                                   style: MyText.subhead(
//                                                           context)!
//                                                       .copyWith(
//                                                           color: Colors.white)),
//                                               onPressed: () async {
//                                                 print("hello");
//                                                 print(stockdispatchController
//                                                     .getitemid
//                                                     .toString());
//                                                 print(stockdispatchController
//                                                     .getitemqty
//                                                     .toString());
//                                                 print(stockdispatchController
//                                                     .getpurchaseid
//                                                     .toString());
//                                                 print(stockdispatchController
//                                                     .
//                                                     .toString());
//                                                 print(stockdispatchController
//                                                     .getdispatchid
//                                                     .toString());
//                                                 GetStorage().read("office");
//                                                 final itemname =
//                                                     stockdispatchController
//                                                         .getitemid
//                                                         .toString()
//                                                         .replaceAll("[", "")
//                                                         .replaceAll("]", "");
//                                                 final itemid =
//                                                     stockdispatchController
//                                                         .getuniqueid
//                                                         .toString()
//                                                         .replaceAll("[", "")
//                                                         .replaceAll("]", "");
//                                                 final itemqty =
//                                                     stockdispatchController
//                                                         .getitemqty
//                                                         .toString()
//                                                         .replaceAll("[", "")
//                                                         .replaceAll("]", "");
//                                                 final itemdispatch =
//                                                     stockdispatchController
//                                                         .getdispatchid
//                                                         .toString()
//                                                         .replaceAll("[", "")
//                                                         .replaceAll("]", "");

//                                                 var rsp =
//                                                     await insert_stockrecieve(
//                                                         itemname,
//                                                         '4',
//                                                         GetStorage()
//                                                             .read("office"),
//                                                         itemid,
//                                                         itemdispatch,
//                                                         '30',
//                                                         GetStorage()
//                                                             .read('userId')
//                                                             .toString(),
//                                                         '2022-11-10');
//                                                 print('this is status of 1');
//                                                 print(rsp['status']);
//                                                 print(rsp['inven']);

//                                                 // print(rsp['value']);
//                                                 // print(rsp['len']);
//                                                 // if (rsp['status'] == 1) {
//                                                 //   print('this is status of 1');
//                                                 //   print(rsp['status']);
//                                                 //   isLoading.value = false;
//                                                 //   stockdispatchController
//                                                 //       .setListValue();
//                                                 //   showDialog(
//                                                 //       context: context,
//                                                 //       builder: (_) =>
//                                                 //           const CustomEventDialog(
//                                                 //               title: "Home"));
//                                                 // } else {
//                                                 //   print('this is status of 1');
//                                                 //   print(rsp['status']);
//                                                 //   isLoading.value = false;
//                                                 //   showDialog(
//                                                 //       context: context,
//                                                 //       builder: (BuildContext
//                                                 //           context) {
//                                                 //         return AlertDialog(
//                                                 //           title: const Text(
//                                                 //               'Something Went Wrong'),
//                                                 //           content: const Text(
//                                                 //               'Try Again!!'),
//                                                 //           actions: <Widget>[
//                                                 //             FlatButton(
//                                                 //               child: const Text(
//                                                 //                   'OK'),
//                                                 //               onPressed: () {
//                                                 //                 Navigator.of(
//                                                 //                         context)
//                                                 //                     .pop();
//                                                 //               },
//                                                 //             )
//                                                 //           ],
//                                                 //         );
//                                                 //       });
//                                                 // }
//                                               })),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 });
//               }));
//         });
//       },
//     );

//     //*************************CGslate Technical  End bottomsheet to add Staff***************************
//   }

//   Future insert_stockrecieve(
//     String? itemName,
//     String? officeId,
//     String? officeName,
//     String? itemuniqueId,
//     String? dispatchid,
//     String? itemQty,
//     String? facilitatorId,
//     String? receivedDate,

//     // String recievedBy,
//     // String itemName,
//     // String itemQty,
//     // String purchaseId,
//     // String itemuniqueid,
//     // String dispatchid,
//     // // String editqty,
//     // String officeid,
//   ) async {
//     print('insert stock is called');
//     print(itemName);
//     print(officeId);
//     print(officeName);
//     print(itemuniqueId);
//     print(dispatchid);
//     print(itemQty);
//     print(facilitatorId);
//     print(receivedDate);

//     var response = await http
//         .post(Uri.parse(MyColors.baseUrl + 'insert_stock_receive.php'), headers: {
//       "Accept": "Application/json"
//     }, body: {
//       'item_name': itemName,
//       'office_id': officeId,
//       'office_name': officeName,
//       'item_unique_id': itemuniqueId,
//       'dispatch_common_id': dispatchid,
//       'item_qty': itemQty,
//       'facilitator_id': facilitatorId,
//       'received_date': receivedDate,
//     });
//     var convertedDatatoJson = jsonDecode(response.body);
//     return convertedDatatoJson;
//   }

//   // Row titleView(String name, String value, String staff) {
//   //   return Row(
//   //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //     children: [
//   //       Column(
//   //         children: [
//   //           Text(name,
//   //               style: const TextStyle(
//   //                   fontSize: 12,
//   //                   fontWeight: FontWeight.bold,
//   //                   color: MyColors.grey_95)),
//   //         ],
//   //       ),
//   //       Column(
//   //         children: [
//   //           Text(value,
//   //               style: const TextStyle(
//   //                   fontSize: 12,
//   //                   fontWeight: FontWeight.bold,
//   //                   color: MyColors.grey_95)),
//   //         ],
//   //       ),
//   //       Column(
//   //         children: [
//   //           Text(staff,
//   //               style: const TextStyle(
//   //                   fontSize: 12,
//   //                   fontWeight: FontWeight.bold,
//   //                   color: MyColors.grey_95)),
//   //         ],
//   //       )
//   //     ],
//   //   );
//   // }

// //   Row titleView1(String name, String value, String staff) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         GetBuilder<DistrictController>(
// //             init: DistrictController(),
// //             builder: (districtController) {
// //               List<c.District>? district;
// //               district = districtController.districtList.value.data;

// //               return Container(
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(5),
// //                   boxShadow: const [
// //                     BoxShadow(
// //                         color: Colors.white, spreadRadius: 1, blurRadius: 5)
// //                   ],
// //                 ),
// //                 child: Stack(children: [
// //                   DropdownButton<String>(
// //                     value: districtValue1,
// //                     iconSize: 14,

// //                     hint: Text(
// //                       'Select District'.tr,
// //                       style: const TextStyle(color: Colors.grey),
// //                     ),
// //                     // ignore: can_be_null_after_null_aware
// //                     items: district?.map((value) {
// //                       return DropdownMenuItem<String>(
// //                         value: value.district.toString(),
// //                         child: Text(
// //                           value.district.toString(),
// //                           style: const TextStyle(fontSize: 9),
// //                         ),
// //                       );
// //                     }).toList(),
// //                     onChanged: (data) {
// //                       setState(() {
// //                         districtValue1 = data;
// //                       });
// //                     },
// //                   ),
// //                 ]),
// //               );
// //             }),
// //         Text(value,
// //             style: const TextStyle(
// //                 fontSize: 12,
// //                 fontWeight: FontWeight.bold,
// //                 color: MyColors.grey_95)),
// //         Text(staff,
// //             style: const TextStyle(
// //                 fontSize: 12,
// //                 fontWeight: FontWeight.bold,
// //                 color: MyColors.grey_95))
// //       ],
// //     );
// //   }
// // }

// }


