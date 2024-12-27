import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old17000ft/Controllers/networ_Controller.dart';
import 'package:old17000ft/Controllers/pendingExpenses_Controller.dart';
import 'package:old17000ft/colors.dart';
import 'package:old17000ft/forms/pendingForm.dart';

import 'home_screen.dart';

final PendingController _pendingController = Get.put(PendingController());
final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());

 class PendingScreen extends StatefulWidget {
   const PendingScreen({ Key? key }) : super(key: key);
 
   @override
   State<PendingScreen> createState() => _PendingScreenState();
 }
 
 class _PendingScreenState extends State<PendingScreen> {
    @override
  void initState() {
    super.initState();
    stateController.fetchState();
    authController.fetchAuth();
    schoolController.fetchSchool();
    pendingController.fetchPending();


  }
   @override
   Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: MyColors.primary,
          title: const Text('Pending Payments ',style: TextStyle(color: Colors.white),),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         //    _offlineHandler.expenses.clear();
          //       },
          //       icon: const Icon(Icons.clear))
          // ],
        ),
        body: Obx(
          () => _networkManager.connectionType.value == 0
              ? const Center(
                  child: FittedBox(
                    child: Text('Connect to Internet to view this section',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                  ),
                )
              : GetBuilder<PendingController>(
                  init: PendingController(),
                  builder: (pendingController) {
                    return pendingController.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : pendingController.pendingList.isEmpty
                            ? const Center(
                                child: Text(
                                'No Pending Form Data',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.primary),
                              ))
                            : Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: ListView.separated(
                                        itemCount: pendingController
                                            .pendingList.length,
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const Divider(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            leading: Text(
                                                "(${(index + 1)})   ${pendingController
                                                        .pendingList[index]
                                                        .submissionDate}"),
                                            title: Text(
                                              pendingController
                                                  .pendingList[index].vendorName
                                                  .toString(),
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
                                                  "Invoice Amount :${pendingController
                                                          .pendingList[index]
                                                          .invoiceAmt}",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Invoice No :${pendingController
                                                          .pendingList[index]
                                                          .invoiceNo}",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Invoice Date :${pendingController
                                                          .pendingList[index]
                                                          .dateOfInvoice}",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                            trailing: IconButton(
                                              icon: const Icon(
                                                Icons.edit,
                                                color: MyColors.primary,
                                              ),
                                              onPressed: () {
                                                Get.to(() => PendingForm(
                                                    pendingExpense:
                                                        pendingController
                                                                .pendingList[
                                                            index]));
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              );
                  }),
        ));

  
    }
 }



// class PendingScreen extends StatelessWidget {
//   const PendingScreen({Key? key}) : super(key: key);
   
  

//   @override
  // Widget build(BuildContext context) {
   
// }
