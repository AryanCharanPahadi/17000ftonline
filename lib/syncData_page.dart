import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old17000ft/Controllers/networ_Controller.dart';
import 'package:old17000ft/Controllers/offlineHandler.dart';
import 'package:old17000ft/colors.dart';
import 'package:old17000ft/home_screen.dart';

import 'db.dart';

final OfflineHandler _offlineHandler = Get.put(OfflineHandler());
final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());

var sync = false.obs;

class SyncData extends StatefulWidget {
  const SyncData({Key? key}) : super(key: key);

  @override
  State<SyncData> createState() => _SyncDataState();
}

class _SyncDataState extends State<SyncData> {
  Future syncToMysql() async {
    await SyncronizationData().fetchAllInfo().then((userList) async {
      await SyncronizationData().saveToMysqlWith(userList);
      setState(() {
        Get.to(() => const HomeScreen());
      });
    });
  }

  List? data;

  Future userList() async {
    data = await Controller().fetchData();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    userList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _offlineHandler.isLoading.value
          ? Scaffold(
              body: Stack(
              children: [
                Center(
                  child: Container(
                      color: Colors.white,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/17000ft.jpg',
                            height: 60,
                            width: 60,
                          ),
                          const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(MyColors.primary),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Syncing Your Data\nPlease wait...',
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ))
                        ],
                      ))),
                )
              ],
            ))
          : Scaffold(
              appBar: AppBar(
                backgroundColor: MyColors.primary,
                title: const Text('Sync Your Data'),
                actions: [
                  // IconButton(
                  //     onPressed: () async {
                  //       if (offlineHandler.filterdExpenses.isNotEmpty &&
                  //           _networkManager.connectionType.value != 0) {
                  //         for (int i = 0;
                  //             i < _offlineHandler.filterdExpenses.length;) {
                  //           _offlineHandler.isLoading.value = true;
                  //           try {
                  //             var rsp = await insertData(
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .office
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .submissionDate
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .tourId
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .vendorName
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .invoiceNumber
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .invoiceDate
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .invoiceAmount
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .towardsCost
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .expenseHead
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .projectName
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .sponsorName
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .expenseBy
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .expenseApprovedBy
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .invoiceImage
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .dateOfPayment
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .paidBy
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .paymentApprovedBy
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .paidAmount
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .paymentType
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .paymentMode
                  //                   .toString(),
                  //               Get.find<OfflineHandler>()
                  //                   .filterdExpenses[i]
                  //                   .userId
                  //                   .toString(),
                  //             );

                  //             if (rsp['status'].toString() == '1') {
                  //               setState(() {
                  //                 _offlineHandler.removedata(i);
                  //                 print('this is {$i}');
                  //               });

                  //               if (_offlineHandler.filterdExpenses.length ==
                  //                   1) {
                  //                 print('done');
                  //                 print(_offlineHandler.filterdExpenses.length);
                  //                 break;
                  //               }
                  //             } else if (rsp['status'].toString() == '0') {
                  //               _offlineHandler.isLoading.value = false;
                  //               Get.defaultDialog(
                  //                 title: 'Error',
                  //                 middleText: 'Something went wrong',
                  //               );
                  //             } else {
                  //               _offlineHandler.isLoading.value = false;
                  //               Get.defaultDialog(
                  //                 title: 'Error',
                  //                 middleText: 'Something went wrong',
                  //               );
                  //             }
                  //           } catch (e) {
                  //             _offlineHandler.isLoading.value = false;

                  //             Get.defaultDialog(
                  //               title: 'Error',
                  //               middleText: 'Something went wrong',
                  //             );
                  //             break;
                  //           }
                  //         }
                  //         _offlineHandler.isLoading.value = false;

                  //         _offlineHandler.restoreTasks();
                  //         showDialog(
                  //             context: context,
                  //             builder: (_) => const CustomEventDialog(
                  //                   title: 'Home',
                  //                   desc: 'Data Submitted',
                  //                 ));
                  //       } else if (_networkManager.connectionType.value == 0) {
                  //         Get.defaultDialog(
                  //             title: 'Try Again',
                  //             middleText: 'When Internet is Available');
                  //       } else {
                  //         Get.defaultDialog(
                  //             title: 'No Data', middleText: 'No data to sync');
                  //       }
                  //     },
                  //     icon: const Icon(Icons.sync))
                  IconButton(
                      icon: const Icon(Icons.refresh_sharp),
                      onPressed: () async {
                        await SyncronizationData.isInternet()
                            .then((connection) {
                          if (connection && data!.isNotEmpty) {
                            syncToMysql();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("No Internet")));
                          }
                        });
                      })
                ],
              ),
              body: GetBuilder<OfflineHandler>(
                  init: OfflineHandler(),
                  builder: (offlineHandler) {
                    return data == null
                        ? const Center(
                            child: Text(
                            'No data to sync',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: MyColors.primary),
                          ))
                        : Column(
                            children: [
                              Expanded(
                                // ignore: avoid_unnecessary_containers
                                child: Container(
                                  child: ListView.separated(
                                    itemCount:
                                        // ignore: deprecated_member_use
                                        data!.length.isNull ? 0 : data!.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        leading: Text("(${(index + 1)})   " +
                                            data![index]['id'].toString()),
                                        title: Text(
                                          data![index]['vendorName'],
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Invoice Amount :" +
                                                  data![index]['invoiceAmount'],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Invoice No :" +
                                                  data![index]['invoiceNumber'],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Invoice Date :" +
                                                  data![index]['invoiceDate'],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Office :" +
                                                  data![index]['office'],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        //   trailing: IconButton(
                                        //   icon: Icon(
                                        //   Icons.sync,
                                        // color: MyColors.primary,
                                        // ),
                                        //   onPressed: () async {
                                        // print('This is example of sync');
                                        // var rsp = await _networkManager
                                        //     .insertData(
                                        //   GetStorage()
                                        //       .read('office')
                                        //       .toString(),
                                        //   _offlineHandler
                                        //       .filterdExpenses[index]
                                        //       .submissionDate
                                        //       .toString(),
                                        //   _offlineHandler
                                        //       .filterdExpenses[index].tourID
                                        //       .toString(),
                                        //   _offlineHandler
                                        //       .filterdExpenses[index]
                                        //       .vendorName
                                        //       .toString(),
                                        //   _offlineHandler
                                        //       .filterdExpenses[index]
                                        //       .invoiceNumber
                                        //       .toString(),
                                        //   _offlineHandler
                                        //       .filterdExpenses[index]
                                        //       .invoiceDate
                                        //       .toString(),
                                        //   _offlineHandler
                                        //       .filterdExpenses[index]
                                        //       .invoiceAmount
                                        //       .toString(),
                                        //   _offlineHandler
                                        //       .filterdExpenses[index]
                                        //       .towardsCost
                                        //       .toString(),
                                        //   _offlineHandler
                                        //       .filterdExpenses[index]
                                        //       .expenseHead
                                        //       .toString(),
                                        //   _offlineHandler
                                        //       .filterdExpenses[index]
                                        //       .projectName
                                        //       .toString(),
                                        //   _offlineHandler
                                        //       .filterdExpenses[index]
                                        //       .sponsorName
                                        //       .toString(),
                                        //   _offlineHandler
                                        //       .filterdExpenses[index]
                                        //       .expenseBy
                                        //       .toString(),
                                        //   _offlineHandler
                                        //       .filterdExpenses[index]
                                        //       .expenseApprovedBy
                                        //       .toString(),
                                        //   _offlineHandler
                                        //       .filterdExpenses[index]
                                        //       .invoiceImage
                                        //       .toString(),
                                        //   _offlineHandler
                                        //       .filterdExpenses[index]
                                        //       .dateOfPayment
                                        //       .toString(),
                                        //   _offlineHandler
                                        //       .filterdExpenses[index].paidBy
                                        //       .toString(),
                                        //   _offlineHandler
                                        //       .filterdExpenses[index]
                                        //       .paymentApprovedBy
                                        //       .toString(),
                                        //   _offlineHandler
                                        //       .filterdExpenses[index]
                                        //       .paidAmount
                                        //       .toString(),
                                        //   _offlineHandler
                                        //       .filterdExpenses[index]
                                        //       .paymentType
                                        //       .toString(),
                                        //   _offlineHandler
                                        //       .filterdExpenses[index]
                                        //       .paymentMode
                                        //       .toString(),
                                        //   GetStorage()
                                        //       .read('userId')
                                        //       .toString(),
                                        // );
                                        //  },
                                        // ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          );
                  })),
    );
  }
}
