import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:old17000ft/Controllers/generalController.dart';
import '../colors.dart';
import 'package:http/http.dart' as http;
import '../custom_dialog.dart';
import '../image_view.dart';
import '../my_text.dart';

class Card1 extends StatefulWidget {
  final File? image;

  final int? index;
  final String? imageLink;
  final String? title;
  const Card1({
    Key? key,
    this.imageLink,
    this.image,
    this.index,
    this.title,
  }) : super(key: key);

  @override
  State<Card1> createState() => _Card1State();
}

class _Card1State extends State<Card1> {
  String? velocity;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.imageLink == null
            ? Get.to(() => ImageView(image: widget.image ?? File('')))
            : Get.to(() => ImageView(link: widget.imageLink!));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, bottom: 15),
        child: Container(
          width: 150,
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.5),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(10, 20),
                  blurRadius: 10,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.05)),
            ],
          ),
          child: GetBuilder<GeneralController>(builder: (context) {
            return Column(
              children: [
                widget.imageLink == null
                    ? InteractiveViewer(
                        boundaryMargin: const EdgeInsets.all(5.0),
                        onInteractionEnd: (ScaleEndDetails endDetails) {
                          setState(() {
                            velocity = endDetails.velocity.toString();
                          });
                        },
                        child: Image.file(widget.image!,
                            height: 100, fit: BoxFit.fill))
                    : InteractiveViewer(
                        boundaryMargin: const EdgeInsets.all(5.0),
                        onInteractionEnd: (ScaleEndDetails endDetails) {
                          print(endDetails);
                          print(endDetails.velocity);
                          setState(() {
                            velocity = endDetails.velocity.toString();
                          });
                        },
                        child:
                            Image.network(widget.imageLink!, fit: BoxFit.fill)),
                const SizedBox(
                  height: 20,
                ),
                widget.imageLink == null
                    ? InkWell(
                        onTap: () async {
                          _generalController.removeImage(widget.index!);
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 30,
                        ),
                      )
                    : const SizedBox(),
              ],
            );
          }),
        ),
      ),
    );
  }
}

final GeneralController _generalController = Get.put(GeneralController());
class CabMeterTracing extends StatefulWidget {
  const CabMeterTracing({Key? key}) : super(key: key);

  @override
  State<CabMeterTracing> createState() => _CabMeterTracingState();
}
class _CabMeterTracingState extends State<CabMeterTracing> {
  var isLoading = false.obs;
  bool _validateVehicle = false;
  bool _validateImage = false;
  bool _validateStatus = false;
  bool _validateDriver = false;
  bool _validateReading = false;

  int statusId = 0;
  String? statusRadio;

  final TextEditingController _vehicleController = TextEditingController();
  final TextEditingController _driverController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _readingController = TextEditingController();
  @override
  Widget build(BuildContext parentcontext) {
    return Obx(() => isLoading.value
        ? Stack(
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
                        const Text('Please wait...',
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
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF8A2724),
              title: const Text(
                'CabMeter Tracing Form',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            body: GetBuilder<GeneralController>(
                init: GeneralController(),
                builder: (context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, setState) {
                    return LayoutBuilder(builder:
                        (BuildContext context1, BoxConstraints constraints) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Vehicle Number',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_95)),
                              Container(height: 10),
                              Container(
                                height: 45,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: TextField(
                                  // readOnly: true,
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (value) {},
                                  maxLines: 1,
                                  controller: _vehicleController,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(-12),
                                      border: InputBorder.none,
                                      hintText: "Vehicle Number",
                                      hintStyle: MyText.body1(context)!
                                          .copyWith(color: MyColors.grey_40)),
                                ),
                              ),
                              _validateVehicle
                                  ? const Text('Please fill Vehicle Number',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red))
                                  : const SizedBox(),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text('Driver Name',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_95)),
                              Container(height: 10),
                              Container(
                                height: 45,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: TextField(
                                  // readOnly: true,
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (value) {},
                                  maxLines: 1,
                                  controller: _driverController,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(-12),
                                      border: InputBorder.none,
                                      hintText: "Driver Name",
                                      hintStyle: MyText.body1(context)!
                                          .copyWith(color: MyColors.grey_40)),
                                ),
                              ),
                              _validateDriver
                                  ? const Text('Please fill Driver Name',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red))
                                  : const SizedBox(),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text('Meter Reading',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_95)),
                              Container(height: 10),
                              Container(
                                height: 45,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: TextField(
                                  // readOnly: true,
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (value) {},
                                  maxLines: 1,
                                  controller: _readingController,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(-12),
                                      border: InputBorder.none,
                                      hintText: "Meter Reading",
                                      hintStyle: MyText.body1(context)!
                                          .copyWith(color: MyColors.grey_40)),
                                ),
                              ),
                              _validateReading
                                  ? const Text('Please fill Meter Reading',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red))
                                  : const SizedBox(),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text('Upload Images: ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_95)),
                              Container(height: 10),
                              Container(
                                height: 45,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: <Widget>[
                                    Container(width: 15),
                                    Expanded(
                                      child: TextField(
                                        readOnly: true,
                                        onTap: () {
                                          showModalBottomSheet(
                                              backgroundColor: MyColors.primary,
                                              context: context,
                                              builder: ((builder) =>
                                                  _generalController
                                                      .bottomSheet(context)));
                                        },
                                        maxLines: 1,
                                        keyboardType: TextInputType.text,
                                        controller: _imageController,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(-12),
                                            border: InputBorder.none,
                                            hintText:
                                                "Upload Supporting Images",
                                            hintStyle: MyText.body1(context)!
                                                .copyWith(
                                                    color: MyColors.grey_40)),
                                      ),
                                    ),
                                    IconButton(
                                        icon: const Icon(Icons.camera,
                                            color: MyColors.grey_40),
                                        onPressed: () {
                                          showModalBottomSheet(
                                              backgroundColor: MyColors.primary,
                                              context: context,
                                              builder: ((builder) =>
                                                  _generalController
                                                      .bottomSheet(context)));
                                        })
                                  ],
                                ),
                              ),
                              _generalController.imageList!.isNotEmpty
                                  ? const SizedBox(
                                      height: 20,
                                    )
                                  : const SizedBox(),
                              _generalController.imageList!.isNotEmpty
                                  ? CardListView(
                                      name: _generalController.imageList,
                                    )
                                  : const SizedBox(),
                              _validateImage
                                  ? const Text('Upload Image',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red))
                                  : const SizedBox(),
                              Container(height: 15),
                              const Text('Choose Option: ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.grey_95)),
                              Container(height: 10),
                              Container(
                                  height: 45,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                                value: 1,
                                                groupValue: statusId,
                                                onChanged: (val) {
                                                  FocusScopeNode currentFocus =
                                                      FocusScope.of(context);

                                                  if (!currentFocus
                                                      .hasPrimaryFocus) {
                                                    currentFocus.unfocus();
                                                  }
                                                  print('values');
                                                  // print(val);
                                                  print(statusId);
                                                  setState(() {
                                                    statusId = 1;
                                                    statusRadio = 'Start';
                                                  });
                                                }),
                                            const Text('Start'),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Row(
                                          children: [
                                            Radio(
                                                value: 2,
                                                groupValue: statusId,
                                                onChanged: (value) {
                                                  print('status values');
                                                  // print(value);
                                                  print(statusId);
                                                  setState(() {
                                                    statusId = 2;
                                                    statusRadio = 'End';
                                                  });
                                                }),
                                            const Text('End'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              _validateStatus
                                  ? const Text('Please select Status',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red))
                                  : const SizedBox(),
                              const SizedBox(
                                height: 5,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  height: 45,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF8A2724),
                                          elevation: 0),
                                      child: Text("Submit",
                                          style: MyText.subhead(context)!
                                              .copyWith(color: Colors.white)),
                                      onPressed: () async {
                                        setState(() {
                                          _driverController.text.isNotEmpty
                                              ? _validateDriver = false
                                              : _validateDriver = true;
                                          _vehicleController.text.isNotEmpty
                                              ? _validateVehicle = false
                                              : _validateVehicle = true;
                                          _generalController
                                                  .imageList!.isNotEmpty
                                              ? _validateImage = false
                                              : _validateImage = true;
                                          statusRadio!.isNotEmpty
                                              ? _validateStatus = false
                                              : _validateStatus = true;
                                          _readingController.text.isNotEmpty
                                              ? _validateReading = false
                                              : _validateReading = true;
                                        });
                                        if (!_validateDriver &&
                                            !_validateImage &&
                                            !_validateStatus &&
                                            !_validateVehicle &&
                                            !_validateReading) {
                                          isLoading.value = true;
                                          var rsp = await insertCab(
                                            _vehicleController.text,
                                            _readingController.text,
                                            _generalController.images64![0]
                                                .toString(),
                                            _driverController.text,
                                            statusRadio.toString(),
                                            GetStorage().read('userId'),
                                          );
                                          if (rsp['status'] == 1) {
                                            isLoading.value = false;
                                            showDialog(
                                                context: parentcontext,
                                                builder: (_) =>
                                                    const CustomEventDialog(
                                                        title: 'Home'));
                                            setState(() {
                                              _driverController.clear();
                                              _vehicleController.clear();
                                              _generalController.imageList!
                                                  .clear();
                                              statusRadio = null;
                                            });
                                          } else {
                                            print('something went wrong');
                                          }
                                        }
                                      }))
                            ],
                          ),
                        ),
                      );
                    });
                  });
                }),
          ));
  }

  Future insertCab(
    String vehicle,
    String reading,
    String image,
    String drivername,
    String status,
    String userid,
  ) async {
    print('insert cab is called');
    print(vehicle);
    print(reading);
    print(image);
    print(drivername);
    print(status);
    print(userid);

    var response = await http
        .post(Uri.parse(MyColors.baseUrl + 'insert_cabMeter.php'), headers: {
      "Accept": "Application/json"
    }, body: {
      'vehicle_num': vehicle,
      'meter_reading': reading,
      'image': image.toString(),
      'driver_name': drivername,
      'status': status,
      'user_id': userid,
    });
    var convertedDatatoJson = jsonDecode(response.body);
    return convertedDatatoJson;
  }
}

class CardListView extends StatefulWidget {
  final List<MultipleImage>? name;
  final List<String>? images;
  final String? title;
  const CardListView({Key? key, this.name, this.title, this.images})
      : super(key: key);

  @override
  State<CardListView> createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, right: 25.0, bottom: 15.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            widget.images == null
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: widget.name!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Card1(
                              image: widget.name![index].image,
                              index: index,
                              title: widget.title);
                        }),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: widget.images!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Card1(
                            imageLink: widget.images![index],
                          );
                        }))
          ],
        ),
      ),
    );
  }
}
