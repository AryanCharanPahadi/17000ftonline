import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old17000ft/colors.dart';

class MyTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Pending'),
    const Tab(text: 'Approved'),
    const Tab(text: 'Disapproved'),
  ];

  TabController? controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: myTabs.length);
  }

//api fetching

  @override
  void onClose() {
    controller!.dispose();
    super.onClose();
  }
}

class MyTabbedWidget extends StatelessWidget {
  const MyTabbedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyTabController _tabx = Get.put(MyTabController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        title: const Text('Form Status'),
        bottom: TabBar(
          automaticIndicatorColorAdjustment: true,
          controller: _tabx.controller,
          tabs: _tabx.myTabs,
          indicatorColor: Colors.grey[200],
          indicatorWeight: 3,
          labelColor: Colors.white,
          labelStyle:
              const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      body: TabBarView(
        controller: _tabx.controller,
        children: _tabx.myTabs.map((Tab tab) {
          final String label = tab.text!.toLowerCase();
          return Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(
                      '( $index )',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      'Expense Form',
                      key: Key(label),
                      style: const TextStyle(fontSize: 18),
                    ),
                    trailing: const Text(
                      'Pending',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Date: 2020-01-01'),
                        Text('Amount: 100.000'),
                      ],
                    ),
                  );
                }),
          );
        }).toList(),
      ),
    );
  }
}

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyTabbedWidget(),
      ),
    );
  }
}
