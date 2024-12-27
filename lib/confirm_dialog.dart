import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old17000ft/home_screen.dart';

import 'colors.dart';

class ConfirmEventDialog extends StatefulWidget {
  final String? desc;
  final String? title;
  // final Function? onyes; 
  const ConfirmEventDialog({
    Key? key,
    this.desc,
    this.title,
    // this.onyes,
  }) : super(key: key);

  @override
  ConfirmEventDialogState createState() => ConfirmEventDialogState();
}

class ConfirmEventDialogState extends State<ConfirmEventDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: 160,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          color: Colors.white,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Wrap(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                color: MyColors.primary,
                child: Column(
                  children: <Widget>[
                    Container(height: 10),
                    const Icon(Icons.warning_amber,
                        color: Colors.white, size: 40),
                    Container(height: 10),
                    const Text("Warning",
                        style: TextStyle(color: Colors.white)),
                    Container(height: 10),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Container(height: 10),
                    Text(
                      widget.desc ?? "",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Container(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                      ),
                      child: const Text("Yes",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        if (widget.title.toString() == 'Home') {
                          Get.to(() => const HomeScreen());
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                      ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                      ),
                      child: const Text("No",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        if (widget.title.toString() == 'Home') {
                          Get.to(() => const HomeScreen());
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}


