// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:old17000ft/Controllers/networ_Controller.dart';
import 'package:old17000ft/Controllers/offlineHandler.dart';
import 'package:old17000ft/Controllers/pendingExpenses_Controller.dart';
import 'package:old17000ft/Model/expense_model.dart';
import 'package:old17000ft/Model/tour.dart';
import 'Controllers/school_Controller.dart';
import 'colors.dart';
import 'package:http/http.dart' as http;
import 'custom_dialog.dart';
import 'db.dart';
import 'forms/tour_da.dart';
import 'forms/travel_Requisition.dart';
import 'home_screen.dart';
import 'image_view.dart';
import 'my_text.dart';

class MultipleImage {
  File? image;

  MultipleImage({this.image});
}

List<MultipleImage> _imageList = [];
List<String>? images64 = [];

final OfflineHandler _offlineHandler = Get.put(OfflineHandler());
final PendingController _pendingController = Get.put(PendingController());
final StaffController _staffController = Get.put(StaffController());
final AuthorityController _authController = Get.put(AuthorityController());
List<TourId>? _officetour;
List<TourId>? get officetour => _officetour;

class Form1 extends StatefulWidget {
  const Form1({super.key});

  @override
  Form1State createState() => Form1State();
}

TextEditingController _officeController = TextEditingController();
List<String> program = [];

class Form1State extends State<Form1> {
  @override
  void initState() {
    super.initState();

    // for (var element in schoolController.programme!) {
    //   program.add(element.program!);
    // }

    _officeController.text = GetStorage().read('office').toString();
    _expenseApprovedBy = '';
    _paymentApprovedBy = '';
    _officeName = DateFormat('dd-MM-yyyy').format(DateTime.now());
    _imageList = [];
    images64 = [];
    
  }

  // String? _selectedState;
  String? _officeName;
  String? _expenseHead;
  String? _budgetHead;
  String? _programme;
  String? _expenseBy;
  String? _expenseApprovedBy;
  String? _imagePicked;
  String? _paidBy;
  String? _paymentApprovedBy;
  String? _paymentMode;
  String? _paymentType;
  String? tourValue;
  String? vendorName;

  String? itemNames;

  //bool _validateState = false;
  bool _validateoffice = false;
  final bool _validateSubmitDate = false;
  bool _validateTourId = false;
  bool _validateVendor = false;
  final bool _validateInvoiceNo = false;
  bool _validateInvoiceDate = false;
  bool _validateInvoiceAmount = false;
  bool _validateTowards = false;
  bool _validatePaymentDate = false;
  bool _validateExpenseHead = false;
  bool _validateBudgetHead = false;
  final bool _validateProject = false;
  final bool _validateSponsor = false;
  bool _validateExpenseBy = false;
  final bool _validateExpenseApprovedBy = false;
  bool _validateImagePicked = false;
  bool _validatePaidBy = false;
  final bool _validatePaymentApprovedBy = false;
  bool _validatePaidAmount = false;
  bool _validatePaymentMode = false;
  bool _validatePaymentType = false;
  bool _validateProgramme = false;
  bool _validateAmount = false;
  bool _settleAmount = false;
  bool _partialAmount = false;
  bool _validateChequeNo = false;
  bool _validateBank = false;
  var isLoading = false.obs;

  DateTime selectedDate = DateTime.now(), initialDate = DateTime.now();

  _selectDate(BuildContext context, TextEditingController date) async {
    final DateTime? selected = await showDatePicker(
      locale: const Locale('en', 'IN'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
      builder: (context, picker) {
        return Theme(data: theme, child: picker!);
      },
    );
    if (selected != null) {
      setState(() {
        selectedDate = selected;
        String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
        date.text = formattedDate;
      });
    }
  }

  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<String> takePhoto(ImageSource source) async {
    _image = null;
    final pickedFile = await _picker.getImage(
      source: source,
      imageQuality: 10,
    );
    _imageFile = pickedFile.obs();

    _image = File(_imageFile!.path);
    MultipleImage image = MultipleImage(image: _image);
    _imageList.add(image);
    final bytes = _image!.readAsBytesSync();

    String status = base64Encode(_image!.readAsBytesSync());

    return status;
  }

  final TextEditingController _submitDateController = TextEditingController();

  final TextEditingController _tourIdController = TextEditingController();
  final TextEditingController _invoiceNoController = TextEditingController();
  final TextEditingController _invoiceDateController = TextEditingController();
  final TextEditingController _invoiceAmountController =
      TextEditingController();
  final TextEditingController _towardsOfController = TextEditingController();
  final TextEditingController _paymentDateController = TextEditingController();
  final TextEditingController _paidAmountController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _chequeController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();

  final FocusNode _tourNode = FocusNode();
  final FocusNode _vendorNode = FocusNode();
  final FocusNode _invoiceNode = FocusNode();
  final FocusNode _invoiceAmountNode = FocusNode();
  final FocusNode _towardsNode = FocusNode();

  Widget bottomSheet(BuildContext context) {
   
    return Container(
      color: MyColors.primary,
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Select Image",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                style:
                    ElevatedButton.styleFrom(backgroundColor: MyColors.primary),
                onPressed: () async {
                  _imagePicked = await takePhoto(
                    ImageSource.camera,
                  );
                  images64!.add(_imagePicked!);

                  // uploadFile(userdata.read('customerID'));
                  Navigator.pop(context);
                 // setState(() {});
                },
                icon: const Icon(
                  Icons.camera,
                  color: Colors.white,
                ),
                label: const Text(
                  'Camera',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
              ElevatedButton.icon(
                style:
                    ElevatedButton.styleFrom(backgroundColor: MyColors.primary),
                onPressed: () async {
                  _imagePicked = await takePhoto(ImageSource.gallery);
                  images64!.add(_imagePicked!);
                  Navigator.pop(context);
                 // setState(() {});
                },
                icon: const Icon(
                  Icons.image,
                  color: Colors.white,
                ),
                label: const Text(
                  'Gallery',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
   

    return GetBuilder<GetXNetworkManager>(
        init: GetXNetworkManager(),
        builder: (networkManager) {
          return Scaffold(
            backgroundColor: MyColors.grey_5,
            appBar: AppBar(
              backgroundColor: const Color(0xFF8A2724),
                iconTheme: const IconThemeData(color: Colors.white),
              title: const Text(
                'Expense Form',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            body: Obx(
              () => isLoading.value || _staffController.isLoading.value
                  ? const loadingWidget()
                  : GetBuilder<SchoolController>(
                    init: SchoolController(),
                    builder: (schoolController)  {
                       schoolController.filterList(GetStorage().read('office'));
                       schoolController.fetchVendor();
                        schoolController.getPaymentMode();
    schoolController.getPaymentType();
                      return SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          scrollDirection: Axis.vertical,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(height: 5),
                                const Text('Center:',
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
                                      const EdgeInsets.symmetric(horizontal: 25),
                                  child: TextField(
                                    readOnly: true,
                                    maxLines: 1,
                                    controller: _officeController
                                      ..text = GetStorage().read('office'),
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(-12),
                                        border: InputBorder.none,
                                        hintText: "Office Name",
                                        hintStyle: MyText.body1(context)!
                                            .copyWith(color: MyColors.grey_40)),
                                  ),
                                ),
                                _validateoffice
                                    ? const Text('Please fill Office name',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                Container(height: 15),
                                const Text('Tour ID:',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.grey_95)),
                                Container(height: 10),
                               Container(
                                              height: 45,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(4))),
                                              alignment: Alignment.centerLeft,
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 25),
                                              child: InkWell(
                                                splashColor: Colors.grey,
                                                child: DropdownButton<String>(
                                                  value: tourValue,
                                                  iconSize: 24,
                                                  elevation: 2,
                                                  hint: Text(
                                                    'Select Tour Id'.tr,
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  // ignore: can_be_null_after_null_aware
                                                  items: schoolController
                                                      .schoolTourList!
                                                      .map((value) {
                                                    return DropdownMenuItem<String>(
                                                      value:
                                                          value.tourId.toString(),
                                                      child: Text(
                                                          value.tourId.toString()),
                                                    );
                                                  }).toList(),
                                                  onChanged: (data) {
                                                    setState(() {
                                                      schoolController.getItemName(
                                                          data ?? 'NA');
                                                     print('this is length of get item naem ${schoolController.getItemNameList!.length}}'); 
                                                     print(schoolController.getItemNameList!);    
                                                      tourValue = data;
                                                      _budgetHead = null;
                                                    });
                                                  },
                                                ),
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .requestFocus(FocusNode());
                                                },
                                              ),
                               ),
                                _validateTourId
                                    ? const Text('Please fill Tour Id',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                Container(height: 15),
                                const Text('Vendor Name:',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.grey_95)),
                                Container(height: 10),
                                DropdownSearch<String>(
                                  popupProps: PopupProps.menu(
                                    showSelectedItems: true,
                                    showSearchBox: true,
                                    disabledItemFn: (String s) =>
                                        s.startsWith('I'),
                                  ),
                                  items:  schoolController.vendorNameList!.map((vendor) => vendor.vendorName).toList(),
                                  dropdownDecoratorProps:
                                      const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      labelText: "Select Vendor",
                                      hintText: "vendor name list ",
                                    ),
                                  ),
                                  onChanged: (value){
                                    // setState(() {
                                      vendorName = value.toString();
                                    // });

                                  },
                                  selectedItem:
                                      vendorName,
                                      
                                ),
                                //  Container(
                                //   height: 45,
                                //   decoration: const BoxDecoration(
                                //       color: Colors.white,
                                //       borderRadius:
                                //           BorderRadius.all(Radius.circular(4))),
                                //   alignment: Alignment.centerLeft,
                                //   padding:
                                //       const EdgeInsets.symmetric(horizontal: 25),
                                //   child: InkWell(
                                //     splashColor: Colors.grey,
                                //     child: DropdownButton<String>(
                                //       value: vendorName,
                                //       iconSize: 24,
                                //       elevation: 2,
                                //       items: schoolController.vendorNameList !=
                                //               null
                                //           ? schoolController.vendorNameList!
                                //               .map((value) {
                      
                                //               return DropdownMenuItem<String>(
                                //                 value: value.vendorName.toString(),
                                //                 child: Text(value.vendorName.toString()),
                                //               );
                                //             }).toList()
                                //           : [], // Empty list if schoolController.getItemNameList is null
                                //       onChanged: (String? v) {
                                     
                                //         FocusScope.of(context)
                                //             .requestFocus(FocusNode());
                                //         setState(() => vendorName = v);
                                //       },
                                //       isExpanded: true,
                                //       hint: Text("Vendor Name",
                                //           style: MyText.body1(context)!
                                //               .copyWith(color: MyColors.grey_40)),
                                //       iconDisabledColor: Colors.black,
                                //     ),
                                //     onTap: () {
                                //       FocusScope.of(context)
                                //           .requestFocus(FocusNode());
                                //     },
                                //   ),
                                // ),
                                // Container(
                                //   height: 45,
                                //   decoration: const BoxDecoration(
                                //       color: Colors.white,
                                //       borderRadius:
                                //           BorderRadius.all(Radius.circular(4))),
                                //   alignment: Alignment.centerLeft,
                                //   padding:
                                //       const EdgeInsets.symmetric(horizontal: 25),
                                //   child: TextField(
                                //     onSubmitted: (value) {
                                //       FocusScope.of(context)
                                //           .requestFocus(_invoiceNode);
                                //     },
                                //     focusNode: _vendorNode,
                                //     textInputAction: TextInputAction.next,
                                //     maxLines: 1,
                                //     controller: _vendorNameController,
                                //     decoration: InputDecoration(
                                //         contentPadding: const EdgeInsets.all(-12),
                                //         border: InputBorder.none,
                                //         hintText: "Vendor Name",
                                //         hintStyle: MyText.body1(context)!
                                //             .copyWith(color: MyColors.grey_40)),
                                //   ),
                                // ),
                                _validateVendor
                                    ? const Text('Please fill Vendor name',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                Container(height: 15),
                                const Text('Invoice No:',
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
                                      const EdgeInsets.symmetric(horizontal: 25),
                                  child: TextField(
                                    focusNode: _invoiceNode,
                                    textInputAction: TextInputAction.next,
                                    maxLines: 1,
                                    controller: _invoiceNoController,
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(-12),
                                        border: InputBorder.none,
                                        hintText: "Invoice No:",
                                        hintStyle: MyText.body1(context)!
                                            .copyWith(color: MyColors.grey_40)),
                                  ),
                                ),
                                _validateInvoiceNo
                                    ? const Text('Please fill Invoice No',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                Container(height: 15),
                                const Text('Date of Invoice:',
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
                                        child: TextFormField(
                                          onChanged: (value) => setState(() {}),
                                          readOnly: true,
                                          onTap: () {
                                            _selectDate(
                                                context, _invoiceDateController);
                                          },
                                          maxLines: 1,
                                          keyboardType: TextInputType.datetime,
                                          controller: _invoiceDateController,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(-12),
                                              border: InputBorder.none,
                                              hintText:
                                                  "Date of Invoice(dd-mm-yyyy)",
                                              hintStyle: MyText.body1(context)!
                                                  .copyWith(
                                                      color: MyColors.grey_40)),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            FocusScopeNode currentFocus =
                                                FocusScope.of(context);
                      
                                            if (!currentFocus.hasPrimaryFocus) {
                                              currentFocus.unfocus();
                                            }
                                            _selectDate(
                                                context, _invoiceDateController);
                                          },
                                          icon: const Icon(Icons.calendar_today,
                                              color: MyColors.grey_40))
                                    ],
                                  ),
                                ),
                                _validateInvoiceDate
                                    ? const Text('Please select date',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                Container(height: 15),
                                const Text('Invoice Amount:',
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
                                      const EdgeInsets.symmetric(horizontal: 25),
                                  child: TextField(
                                    onSubmitted: (value) {
                                      FocusScope.of(context)
                                          .requestFocus(_towardsNode);
                                    },
                                    focusNode: _invoiceAmountNode,
                                    textInputAction: TextInputAction.next,
                                    maxLines: 1,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9.,]+')),
                                    ],
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    controller: _invoiceAmountController,
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(-12),
                                        border: InputBorder.none,
                                        hintText: "Invoice Amount",
                                        hintStyle: MyText.body1(context)!
                                            .copyWith(color: MyColors.grey_40)),
                                  ),
                                ),
                                _validateInvoiceAmount
                                    ? const Text('Please fill Amount',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                Container(height: 15),
                                const Text('Expense Description:',
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
                                      const EdgeInsets.symmetric(horizontal: 25),
                                  child: TextField(
                                    focusNode: _towardsNode,
                                    textInputAction: TextInputAction.next,
                                    maxLines: 1,
                                    controller: _towardsOfController,
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(-12),
                                        border: InputBorder.none,
                                        hintText: "Expense Description:",
                                        hintStyle: MyText.body1(context)!
                                            .copyWith(color: MyColors.grey_40)),
                                  ),
                                ),
                                _validateTowards
                                    ? const Text('Please fill Description',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                Container(height: 15),
                                const Text('Expense Head:',
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
                                      const EdgeInsets.symmetric(horizontal: 25),
                                  child: InkWell(
                                    splashColor: Colors.grey,
                                    child: DropdownButton<String>(
                                      value: _expenseHead,
                                      iconSize: 24,
                                      elevation: 2,
                                      items: schoolController.expensehead!
                                          .map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value.expenseheadname.toString(),
                                          child: Text(
                                              value.expenseheadname.toString()),
                                        );
                                      }).toList(),
                                      onChanged: (String? v) {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        setState(() => _expenseHead = v);
                                      },
                                      isExpanded: true,
                                      hint: Text("Expense Head",
                                          style: MyText.body1(context)!
                                              .copyWith(color: MyColors.grey_40)),
                                      iconDisabledColor: Colors.black,
                                    ),
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    },
                                  ),
                                ),
                                _validateExpenseHead
                                    ? const Text('Please select a Expense Head',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                Container(height: 15),
                                 const Text('Budget Head: ',
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
                                      const EdgeInsets.symmetric(horizontal: 25),
                                  child: InkWell(
                                    splashColor: Colors.grey,
                                    child: DropdownButton<String>(
                                      value: _budgetHead,
                                      iconSize: 24,
                                      elevation: 2,
                                      items: schoolController.getItemNameList !=
                                              null
                                          ? schoolController.getItemNameList!
                                              .map((value) {
                      
                                              return DropdownMenuItem<String>(
                                                value: value.toString(),
                                                child: Text(value.toString()),
                                              );
                                            }).toList()
                                          : [], // Empty list if schoolController.getItemNameList is null
                                      onChanged: (String? v) {
                                     
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        setState(() => _budgetHead = v);
                                      },
                                      isExpanded: true,
                                      hint: Text("Budget Head",
                                          style: MyText.body1(context)!
                                              .copyWith(color: MyColors.grey_40)),
                                      iconDisabledColor: Colors.black,
                                    ),
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    },
                                  ),
                                ),
                                _validateBudgetHead
                                    ? const Text('Please select a Budget Head',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                Container(height: 10),
                                const Text('Programme Name:',
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
                                      const EdgeInsets.symmetric(horizontal: 25),
                                  child: InkWell(
                                    splashColor: Colors.grey,
                                    child: DropdownButton<String>(
                                      value: _programme,
                                      iconSize: 24,
                                      elevation: 2,
                                      items:
                                          schoolController.programme!.map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value.program.toString(),
                                          child: Text(value.program.toString()),
                                        );
                                      }).toList(),
                                      onChanged: (dynamic v) {
                                        setState(() {
                                          _programme = v;
                                        });
                                      },
                                      isExpanded: true,
                                      hint: Text("Select Programme",
                                          style: MyText.body1(context)!
                                              .copyWith(color: MyColors.grey_40)),
                                      iconDisabledColor: Colors.black,
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                                _validateProgramme
                                    ? const Text('Please select a programme',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                Container(height: 15),
                                const Text('Expense By:',
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
                                      const EdgeInsets.symmetric(horizontal: 25),
                                  child: InkWell(
                                    splashColor: Colors.grey,
                                    child: DropdownButton<String>(
                                      value: _expenseBy,
                                      iconSize: 24,
                                      elevation: 2,
                                      items: _staffController.staffList[0].data!
                                          .where((element) =>
                                              element.location!.toLowerCase() ==
                                                  _officeController.text
                                                      .toLowerCase() ||
                                              element.firstName!.toLowerCase() ==
                                                  'sandeep' ||
                                              element.firstName!.toLowerCase() ==
                                                  'sujata')
                                          .map((value) {
                                        return DropdownMenuItem<String>(
                                          value:
                                              "${value.firstName!} ${value.lastName!}",
                                          child: Text(
                                              '${value.firstName!} ${value.lastName!}'),
                                        );
                                      }).toList(),
                                      onChanged: (dynamic v) {
                                        setState(() {
                                          _expenseBy = v;
                                        });
                                      },
                                      isExpanded: true,
                                      hint: Text("Expense By",
                                          style: MyText.body1(context)!
                                              .copyWith(color: MyColors.grey_40)),
                                      iconDisabledColor: Colors.black,
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                                _validateExpenseBy
                                    ? const Text('Please select Expense By',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                Container(height: 15),
                                const Text('Upload Image: (Multiple) ',
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
                                                    bottomSheet(context)));
                                          },
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                          controller: _imageController,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(-12),
                                              border: InputBorder.none,
                                              hintText:
                                                  "Upload Image of Invoice with Approval",
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
                                                    bottomSheet(context)));
                                          }),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                _imageList.isNotEmpty
                                    ? CardListView(
                                        name: _imageList,
                                      )
                                    : const SizedBox(),
                                _validateImagePicked
                                    ? const Text('Upload Image',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                Container(height: 25),
                                const Text('Type of Payment:',
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
                                      const EdgeInsets.symmetric(horizontal: 25),
                                  child: InkWell(
                                    splashColor: Colors.grey,
                                    child: DropdownButton<String>(
                                      value: _paymentType,
                                      iconSize: 24,
                                      elevation: 2,
                                      items: schoolController.paymentType!
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (dynamic v) {
                                        setState(() {
                                          if (_paymentType == 'Pending') {
                                            // _paidBy == 'null';
                                          }
                                          _paymentType = v;
                                        });
                                      },
                                      isExpanded: true,
                                      hint: Text("Type of Payment",
                                          style: MyText.body1(context)!
                                              .copyWith(color: MyColors.grey_40)),
                                      iconDisabledColor: Colors.black,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        FocusScopeNode currentFocus =
                                            FocusScope.of(context);
                      
                                        if (!currentFocus.hasPrimaryFocus) {
                                          currentFocus.unfocus();
                                        }
                                      });
                                    },
                                  ),
                                ),
                                _validatePaymentType
                                    ? const Text('Please select Payment type',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                Container(height: 15),
                                _paymentType == 'Pending'
                                    ? const SizedBox()
                                    : const Text('Date of Payment:',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.grey_95)),
                                _paymentType == 'Pending'
                                    ? const SizedBox()
                                    : Container(height: 10),
                                _paymentType == 'Pending'
                                    ? const SizedBox()
                                    : Container(
                                        height: 45,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Container(width: 15),
                                            Expanded(
                                              child: TextField(
                                                readOnly: true,
                                                onTap: () {
                                                  if (_paymentType != 'Pending') {
                                                    _selectDate(context,
                                                        _paymentDateController);
                                                  }
                                                },
                                                onChanged: (dynamic v) {
                                                  setState(() {
                                                    if (_paymentType != 'Pending') {
                                                      _paymentDateController.text =
                                                          '';
                                                    }
                                                  });
                                                },
                                                maxLines: 1,
                                                keyboardType:
                                                    TextInputType.datetime,
                                                controller: _paymentDateController,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets.all(-12),
                                                    border: InputBorder.none,
                                                    hintText:
                                                        "Date of Payment(dd-mm-yyyy)",
                                                    hintStyle:
                                                        MyText.body1(context)!
                                                            .copyWith(
                                                                color: MyColors
                                                                    .grey_40)),
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  if (_paymentType != 'Pending') {
                                                    _selectDate(context,
                                                        _paymentDateController);
                                                  }
                                                },
                                                icon: const Icon(
                                                    Icons.calendar_today,
                                                    color: MyColors.grey_40))
                                          ],
                                        ),
                                      ),
                                _validatePaymentDate
                                    ? const Text('Please select a date',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                _paymentType == 'Pending'
                                    ? const SizedBox()
                                    : Container(height: 15),
                                _paymentType == 'Pending'
                                    ? const SizedBox()
                                    : const Text('Paid By:',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.grey_95)),
                                _paymentType == 'Pending'
                                    ? const SizedBox()
                                    : Container(height: 10),
                                _paymentType == 'Pending'
                                    ? const SizedBox()
                                    : Container(
                                        height: 45,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: InkWell(
                                          splashColor: Colors.grey,
                                          child: DropdownButton<String>(
                                            value: _paidBy,
                                            iconSize: 24,
                                            elevation: 2,
                                            items: _staffController
                                                .staffList[0].data!
                                                .where((element) =>
                                                    element.location!
                                                            .toLowerCase() ==
                                                        _officeController.text
                                                            .toLowerCase() ||
                                                    element.firstName!
                                                            .toLowerCase() ==
                                                        'sandeep' ||
                                                    element.firstName!
                                                            .toLowerCase() ==
                                                        'sujata')
                                                .map((value) {
                                              return DropdownMenuItem<String>(
                                                  value:
                                                      "${value.firstName!} ${value.lastName!}",
                                                  child: Text(
                                                      '${value.firstName!} ${value.lastName!}')
                                                  // value: value,
                                                  // child: Text(value),
                                                  );
                                            }).toList(),
                                            onChanged: (String? v) {
                                              setState(() {
                                                _paidBy = v;
                                              });
                                            },
                                            isExpanded: true,
                                            hint: Text("Paid By",
                                                style: MyText.body1(context)!
                                                    .copyWith(
                                                        color: MyColors.grey_40)),
                                            iconDisabledColor: Colors.black,
                                          ),
                                          onTap: () {},
                                        ),
                                      ),
                                _validatePaidBy
                                    ? const Text('Please fill Name',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                _paymentType == 'Pending'
                                    ? const SizedBox()
                                    : Container(height: 15),
                                _paymentType == 'Pending'
                                    ? const SizedBox()
                                    : Container(height: 15),
                                _paymentType == 'Pending'
                                    ? const SizedBox()
                                    : const Text('Paid Amount:',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.grey_95)),
                                _paymentType == 'Pending'
                                    ? const SizedBox()
                                    : Container(height: 10),
                                _paymentType == 'Pending'
                                    ? const SizedBox()
                                    : Container(
                                        height: 45,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: TextField(
                                          enabled: _paymentType == 'Pending'
                                              ? false
                                              : true,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9.,]+')),
                                          ],
                                          maxLines: 1,
                                          keyboardType:
                                              const TextInputType.numberWithOptions(
                                                  decimal: true),
                                          controller: _paidAmountController,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(-12),
                                              border: InputBorder.none,
                                              hintText: "Paid Amount",
                                              hintStyle: MyText.body1(context)!
                                                  .copyWith(
                                                      color: MyColors.grey_40)),
                                        ),
                                      ),
                                _validatePaidAmount
                                    ? const Text('Please fill Paid Amount',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                _validateAmount
                                    ? const Text(
                                        '* Paid Amount Should not be greater than Invoice Amount',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                _partialAmount
                                    ? const Text(
                                        '*You selected partial type of payment paid amount should be less than invoice amount',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                _paymentType == 'Pending'
                                    ? const SizedBox()
                                    : Container(height: 15),
                                _paymentType == 'Pending'
                                    ? const SizedBox()
                                    : const Text('Mode of Payment:',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.grey_95)),
                                _paymentType == 'Pending'
                                    ? const SizedBox()
                                    : Container(height: 10),
                                _paymentType == 'Pending'
                                    ? const SizedBox()
                                    : Container(
                                        height: 45,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: InkWell(
                                          splashColor: Colors.grey,
                                          child: DropdownButton<String>(
                                            value: _paymentMode,
                                            iconSize: 24,
                                            elevation: 2,
                                            items: schoolController.modePayment!
                                                .map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (_paymentType == 'Pending'
                                                    ? true
                                                    : false)
                                                ? null
                                                : (dynamic v) {
                                                    FocusScope.of(context)
                                                        .requestFocus(FocusNode());
                      
                                                    setState(() {
                                                      if (_paymentType == 'Pending'
                                                          ? false
                                                          : true) {
                                                        _paymentMode = v;
                                                      } else {
                                                        _paymentMode = '';
                                                      }
                                                    });
                                                  },
                                            isExpanded: true,
                                            hint: Text("Mode of Payment",
                                                style: MyText.body1(context)!
                                                    .copyWith(
                                                        color: MyColors.grey_40)),
                                            iconDisabledColor: Colors.black,
                                          ),
                                          onTap: () {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                      
                                            if (_paymentType == 'Pending'
                                                ? false
                                                : true) {
                                              _paymentMode = '';
                                            }
                                          },
                                        ),
                                      ),
                                _validatePaymentMode
                                    ? const Text('Please select Payment Mode',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
                                const SizedBox(height: 10),
                                _paymentMode == 'Cheque'
                                    ? _paymentType == 'Pending'
                                        ? const SizedBox()
                                        : const Text('Cheque No.:',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.grey_95))
                                    : const SizedBox(),
                                _paymentType == 'Pending'
                                    ? const SizedBox()
                                    : Container(height: 10),
                                _paymentMode == 'Cheque'
                                    ? _paymentType == 'Pending'
                                        ? const SizedBox()
                                        : Container(
                                            height: 45,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4))),
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25),
                                            child: TextField(
                                              enabled: _paymentType == 'Pending'
                                                  ? false
                                                  : true,
                                              maxLines: 1,
                                              controller: _chequeController,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(-12),
                                                  border: InputBorder.none,
                                                  hintText: "Cheque No.",
                                                  hintStyle: MyText.body1(context)!
                                                      .copyWith(
                                                          color: MyColors.grey_40)),
                                            ),
                                          )
                                    : const SizedBox(),
                                _paymentMode == 'Cheque'
                                    ? _validateChequeNo
                                        ? const Text('Please fill Cheque No.',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red))
                                        : const SizedBox()
                                    : const SizedBox(),
                                const SizedBox(height: 10),
                                _paymentMode == 'Bank Transfer'
                                    ? _paymentType == 'Pending'
                                        ? const SizedBox()
                                        : const Text('Reference No.:',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.grey_95))
                                    : const SizedBox(),
                                _paymentType == 'Pending'
                                    ? const SizedBox()
                                    : Container(height: 10),
                                _paymentMode == 'Bank Transfer'
                                    ? _paymentType == 'Pending'
                                        ? const SizedBox()
                                        : Container(
                                            height: 45,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4))),
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25),
                                            child: TextField(
                                              enabled: _paymentType == 'Pending'
                                                  ? false
                                                  : true,
                                              maxLines: 1,
                                              controller: _bankController,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(-12),
                                                  border: InputBorder.none,
                                                  hintText: "Reference No.",
                                                  hintStyle: MyText.body1(context)!
                                                      .copyWith(
                                                          color: MyColors.grey_40)),
                                            ),
                                          )
                                    : const SizedBox(),
                                _paymentMode == 'Bank Transfer'
                                    ? _validateBank
                                        ? const Text('Please fill Reference No.',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red))
                                        : const SizedBox()
                                    : const SizedBox(),
                                Container(height: 15),
                                SizedBox(
                                  width: double.infinity,
                                  height: 45,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF8A2724),
                                        elevation: 0),
                                    child: Text("SUBMIT",
                                        style: MyText.subhead(context)!
                                            .copyWith(color: Colors.white)),
                                    onPressed: () async {
                                      setState(() {
                                        _officeController.text.isNotEmpty
                                            ? _validateoffice = false
                                            : _validateoffice = true;
                      
                                        if (_paymentMode == 'Cheque') {
                                          _chequeController.text.isNotEmpty &&
                                                      _paymentMode == 'Cheque' ||
                                                  _paymentType == 'Pending'
                                              ? _validateChequeNo = false
                                              : _validateChequeNo = true;
                                        }
                                        if (_paymentMode == 'Bank Transfer') {
                                          _bankController.text.isNotEmpty &&
                                                  _paymentMode == 'Bank Transfer'
                                              ? _validateBank = false
                                              : _validateBank = true;
                                        }
                                        tourValue != null
                                            ? _validateTourId = false
                                            : _validateTourId = true;
                                        // _vendorNameController.text.isNotEmpty
                                        vendorName!=null
                                            ? _validateVendor = false
                                            : _validateVendor = true;
                                        // _invoiceNoController.text.isNotEmpty
                                        //     ? _validateInvoiceNo = false
                                        //     : _validateInvoiceNo = true;
                      
                                        _invoiceDateController.text.isNotEmpty
                                            ? _validateInvoiceDate = false
                                            : _validateInvoiceDate = true;
                                        _invoiceAmountController.text.isNotEmpty
                                            ? _validateInvoiceAmount = false
                                            : _validateInvoiceAmount = true;
                                        _towardsOfController.text.isNotEmpty
                                            ? _validateTowards = false
                                            : _validateTowards = true;
                                        _expenseHead != null
                                            ? _validateExpenseHead = false
                                            : _validateExpenseHead = true;
                                        _budgetHead != null
                                            ? _validateBudgetHead = false
                                            : _validateBudgetHead = true;
                                        _programme != null
                                            ? _validateProgramme = false
                                            : _validateProgramme = true;
                                        // _sponsor != null
                                        //     ? _validateSponsor = false
                                        //     : _validateSponsor = true;
                                        _expenseBy != null
                                            ? _validateExpenseBy = false
                                            : _validateExpenseBy = true;
                                        _imageList.isNotEmpty
                                            ? _validateImagePicked = false
                                            : _validateImagePicked = true;
                                        _paymentDateController.text.isNotEmpty ||
                                                _paymentType == 'Pending'
                                            ? _validatePaymentDate = false
                                            : _validatePaymentDate = true;
                      
                                        _paidBy != null || _paymentType == 'Pending'
                                            ? _validatePaidBy = false
                                            : _validatePaidBy = true;
                      
                                        _paidAmountController.text.isNotEmpty ||
                                                _paymentType == 'Pending'
                                            ? _validatePaidAmount = false
                                            : _validatePaidAmount = true;
                                        _paymentType != null
                                            ? _validatePaymentType = false
                                            : _validatePaymentType = true;
                                        _paymentMode != null ||
                                                _paymentType == 'Pending'
                                            ? _validatePaymentMode = false
                                            : _validatePaymentMode = true;
                      
                                        String invoiceAmount =
                                            _invoiceAmountController.text;
                                        String paidAmount =
                                            _paidAmountController.text;
                                        if (_paymentType != 'Pending') {
                                          double.parse(invoiceAmount) <
                                                  double.parse(paidAmount)
                                              ? _validateAmount = true
                                              : _validateAmount = false;
                                        }
                                        if (_paymentType == 'Settlement') {
                                          double.parse(invoiceAmount) ==
                                                  double.parse(paidAmount)
                                              ? _settleAmount = false
                                              : _settleAmount = true;
                                        }
                                        if (_paymentType == 'Partial') {
                                          double.parse(invoiceAmount) ==
                                                  double.parse(paidAmount)
                                              ? _partialAmount = true
                                              : _partialAmount = false;
                                        }
                      
                                        if (_settleAmount &&
                                            double.parse(
                                                    _invoiceAmountController.text) >
                                                double.parse(
                                                    _paidAmountController.text)) {
                                          showDialog(
                                              context: context,
                                              builder: (_) => Confirmation(
                                                  desc:
                                                      'You have selected settlement mode, your paid amount is less than invoice amount. Is it Okay?',
                                                  title: 'Alert',
                                                  onPressed: () async {
                                                    setState(() {
                                                      _settleAmount = false;
                      
                                                    });
                      
                                                    if (!_validateAmount &&
                                                        !_settleAmount &&
                                                        !_validateProject &&
                                                        !_validatePaymentMode &&
                                                        !_validatePaymentType &&
                                                        !_validatePaidAmount &&
                                                        !_validateProgramme &&
                                                        !_validateVendor &&
                                                        !_validatePaymentDate &&
                                                        !_validateTourId &&
                                                        !_validateImagePicked &&
                                                        !_validateExpenseBy &&
                                                        !_validateExpenseHead &&
                                                        !_validatePaidBy &&
                                                        !_validateInvoiceAmount &&
                                                        !_validateInvoiceDate &&
                                                        !_validateBudgetHead &&
                                                        // !_validateInvoiceNo &&
                                                        !_validateTowards &&
                                                        !_partialAmount &&
                                                        !_validateBank &&
                                                        !_validateChequeNo) {
                                                      if (networkManager
                                                              .connectionType
                                                              .value !=
                                                          0) {
                                                        Navigator.of(context).pop();
                                                        isLoading.value = true;
                                                        var rsp = await insertData(
                                                            _officeController.text,
                                                            _officeName!,
                                                            tourValue!,
                                                            vendorName!,
                                                            // _vendorNameController
                                                            //     .text,
                                                            _invoiceNoController
                                                                .text,
                                                            _invoiceDateController
                                                                .text,
                                                            _invoiceAmountController
                                                                .text,
                                                            _towardsOfController
                                                                .text,
                                                            _expenseHead!,
                                                            _expenseBy!,
                                                            _programme!,
                                                            _expenseApprovedBy!,
                                                            _paymentDateController
                                                                .text,
                                                            _paidBy!,
                                                            _paymentApprovedBy
                                                                .toString(),
                                                            _paidAmountController
                                                                .text,
                                                            _paymentType.toString(),
                                                            _paymentMode.toString(),
                                                            _chequeController.text,
                                                            _bankController.text,
                                                            GetStorage()
                                                                .read('userId')
                      
                                                                .toString(),
                                                             _budgetHead.toString(),   
                                                                
                                                                );
                      
                                                        if (rsp['status']
                                                                .toString() ==
                                                            '1') {
                                                          for (int i = 0;
                                                              i < images64!.length;
                                                              i++) {
                                                            var imagesRes =
                                                                await insertImages(
                                                                    rsp['id']
                                                                        .toString(),
                                                                    images64![i]);
                                                            if (imagesRes['status']
                                                                    .toString() ==
                                                                '1') {
                                                            } else if (imagesRes[
                                                                        'status']
                                                                    .toString() ==
                                                                '0') {}
                                                          }
                                                          isLoading.value = false;
                                                          showDialog(
                                                              context: context,
                                                              builder: (_) =>
                                                                  const CustomEventDialog());
                                                          setState(() {
                                                            _submitDateController
                                                                .clear();
                                                            _chequeController
                                                                .clear();
                                                            _bankController.clear();
                                                            _programme = null;
                                                            images64 = [];
                                                            _imageList = [];
                                                            tourValue = null;
                                                            _budgetHead = null;
                      
                                                            _tourIdController
                                                                .clear();
                                                            // _vendorNameController
                                                            //     .clear();
                                                            vendorName == null;
                                                            _invoiceNoController
                                                                .clear();
                                                            _invoiceDateController
                                                                .clear();
                                                            _invoiceAmountController
                                                                .clear();
                                                            _towardsOfController
                                                                .clear();
                                                            _imagePicked = null;
                                                            _expenseHead = null;
                                                            _expenseBy = null;
                                                            _expenseApprovedBy =
                                                                null;
                                                            _image = null;
                                                            _paymentDateController
                                                                .clear();
                                                            _paidBy = null;
                                                            _paymentApprovedBy =
                                                                null;
                                                            _paidAmountController
                                                                .clear();
                                                            _paymentType = null;
                                                            _paymentMode = null;
                                                            _officeController
                                                                .clear();
                                                          });
                                                        } else if (rsp['status']
                                                                .toString() ==
                                                            '0') {
                                                          isLoading.value = false;
                                                          showDialog(
                                                              context: context,
                                                              builder: (BuildContext
                                                                  context) {
                                                                return AlertDialog(
                                                                  title: const Text(
                                                                      'Something Went Wrong'),
                                                                  content: const Text(
                                                                      'Try Again!!'),
                                                                  actions: <Widget>[
                                                                    ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          backgroundColor:
                                                                              const Color(
                                                                                  0xFF8A2724),
                                                                          elevation:
                                                                              0),
                                                                      child:
                                                                          const Text(
                                                                              'OK'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(
                                                                                context)
                                                                            .pop();
                                                                      },
                                                                    )
                                                                  ],
                                                                );
                                                              });
                                                        } else {
                                                          isLoading.value = false;
                                                          showDialog(
                                                              context: context,
                                                              builder: (BuildContext
                                                                  context) {
                                                                return AlertDialog(
                                                                  title: const Text(
                                                                      'Something Went Wrong'),
                                                                  content: const Text(
                                                                      'Try After Sometime!!'),
                                                                  actions: <Widget>[
                                                                    ElevatedButton(
                                                                      child:
                                                                          const Text(
                                                                              'OK'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(
                                                                                context)
                                                                            .pop();
                                                                      },
                                                                    )
                                                                  ],
                                                                );
                                                              });
                                                        }
                                                      } else {
                                                        ExpenseModel
                                                            contactinfoModel =
                                                            ExpenseModel(
                                                          office: _officeController
                                                              .text
                                                              .toString(),
                                                          submissionDate:
                                                              _officeName!,
                                                          tourId: _tourIdController
                                                              .text
                                                              .toString(),
                                                          vendorName:
                                                              vendorName
                                                                  .toString(),
                                                          invoiceNumber:
                                                              _invoiceNoController
                                                                  .text
                                                                  .toString(),
                                                          invoiceDate:
                                                              _invoiceDateController
                                                                  .text
                                                                  .toString(),
                                                          invoiceAmount:
                                                              _invoiceAmountController
                                                                  .text
                                                                  .toString(),
                                                          towardsCost:
                                                              _towardsOfController
                                                                  .text
                                                                  .toString(),
                                                          expenseHead: _expenseHead
                                                              .toString(),
                                                          expenseBy:
                                                              _expenseBy.toString(),
                                                          expenseApprovedBy:
                                                              _expenseApprovedBy
                                                                  .toString(),
                                                          invoiceImage: _imagePicked
                                                              .toString(),
                                                          dateOfPayment:
                                                              _paymentDateController
                                                                  .text
                                                                  .toString(),
                                                          paidBy:
                                                              _paidBy.toString(),
                                                          paymentApprovedBy:
                                                              _paymentApprovedBy
                                                                  .toString(),
                                                          paidAmount:
                                                              _paidAmountController
                                                                  .text
                                                                  .toString(),
                                                          paymentType: _paymentType
                                                              .toString(),
                                                          paymentMode: _paymentMode
                                                              .toString(),
                                                          userId: GetStorage()
                                                              .read('userId')
                                                              .toString(),
                      
                                                        );
                      
                                                        await Controller()
                                                            .addData(
                                                                contactInfoModel:
                                                                    contactinfoModel)
                                                            .then((value) {
                                                          if (value > 0) {
                                                            showDialog(
                                                                context: context,
                                                                builder: (_) =>
                                                                    const CustomEventDialog(
                                                                      desc:
                                                                          'Data Submitted',
                                                                    ));
                                                          } else {}
                                                        });
                      
                                                        setState(() {
                                                          _submitDateController
                                                              .clear();
                                                          _chequeController.clear();
                                                          _bankController.clear();
                                                          _programme = null;
                                                          images64 = [];
                                                          _imageList = [];
                      
                                                          _tourIdController.clear();
                                                          vendorName=null;
                                                          // _vendorNameController
                                                          //     .clear();
                                                          _invoiceNoController
                                                              .clear();
                                                          _invoiceDateController
                                                              .clear();
                                                          _invoiceAmountController
                                                              .clear();
                                                          _towardsOfController
                                                              .clear();
                                                          _expenseHead = null;
                                                          _expenseBy = null;
                                                          _expenseApprovedBy = null;
                                                          _image = null;
                                                          _imagePicked = null;
                                                          _paymentDateController
                                                              .clear();
                                                          _paidBy = null;
                                                          _paymentApprovedBy = null;
                                                          _paidAmountController
                                                              .clear();
                                                          _paymentType = null;
                                                          _paymentMode = null;
                      
                                                          _officeController.clear();
                                                        });
                                                      }
                                                    }
                                                  }));
                                        }
                                      });
                                      if (!_validateAmount &&
                                          !_settleAmount &&
                                          !_validatePaymentMode &&
                                          !_validatePaymentType &&
                                          !_validatePaidAmount &&
                                          !_validateVendor &&
                                          !_validatePaymentDate &&
                                          !_validateTourId &&
                                          !_validateImagePicked &&
                                          !_validateExpenseBy &&
                                          !_validateExpenseHead &&
                                          !_validatePaidBy &&
                                          !_validateInvoiceAmount &&
                                          !_validateInvoiceDate &&
                                          !_validateInvoiceNo &&
                                          !_validateTowards &&
                                          !_partialAmount) {
                                        if (networkManager.connectionType.value !=
                                            0) {
                                          //   try {
                      
                                          isLoading.value = true;
                                          var rsp = await insertData(
                                              _officeController.text,
                                              _officeName!,
                                              tourValue!,
                                              // _vendorNameController.text,
                                              vendorName!,
                                              _invoiceNoController.text,
                                              _invoiceDateController.text,
                                              _invoiceAmountController.text,
                                              _towardsOfController.text,
                                              _expenseHead!,
                                              _expenseBy!,
                                              _programme!,
                                              _expenseApprovedBy == null
                                                  ? ''
                                                  : _expenseApprovedBy!,
                                              //  images64!,
                                              _paymentDateController.text,
                                              _paidBy == null ? '' : _paidBy!,
                                              _paymentApprovedBy == null
                                                  ? ''
                                                  : _paymentApprovedBy!,
                                              _paidAmountController.text,
                                              _paymentType == null
                                                  ? ''
                                                  : _paymentType!,
                                              _paymentMode == null
                                                  ? ''
                                                  : _paymentMode!,
                                              _chequeController.text,
                                              _bankController.text,
                                              GetStorage()
                                                  .read('userId')
                                                  .toString(),
                                                  _budgetHead.toString(),
                                                  );
                                          if (rsp['status'].toString() == '1') {
                                            for (int i = 0;
                                                i < images64!.length;
                                                i++) {
                                              var imagesRes = await insertImages(
                                                  rsp['id'].toString(),
                                                  images64![i]);
                                              if (imagesRes['status'].toString() ==
                                                  '1') {
                                               
                                              } else if (imagesRes['status']
                                                      .toString() ==
                                                  '0') {
                                               
                                              }
                                            }
                                            isLoading.value = false;
                                            showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    const CustomEventDialog());
                                            setState(() {
                                              _submitDateController.clear();
                                              tourValue = null;
                                              _chequeController.clear();
                                              _bankController.clear();
                                              _programme = null;
                                              images64 = [];
                                              _imageList = [];
                                              vendorName = null;
                      
                                              //_vendorNameController.clear();
                                              _invoiceNoController.clear();
                                              _invoiceDateController.clear();
                                              _invoiceAmountController.clear();
                                              _towardsOfController.clear();
                                              _expenseHead = null;
                                              _expenseBy = null;
                                              _expenseApprovedBy = null;
                                              _image = null;
                                              _imagePicked = null;
                                              _paymentDateController.clear();
                                              _paidBy = null;
                                              _paymentApprovedBy = null;
                                              _paidAmountController.clear();
                                              _paymentType = null;
                                              _paymentMode = null;
                                              _officeController.clear();
                                            });
                                          } else if (rsp['status'].toString() ==
                                              '0') {
                                            isLoading.value = false;
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Something Went Wrong'),
                                                    content:
                                                        const Text('Try Again!!'),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                 backgroundColor:
                                                                    const Color(
                                                                        0xFF8A2724),
                                                                elevation: 0),
                                                        child: const Text('OK'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      )
                                                    ],
                                                  );
                                                });
                                          } else {
                                            isLoading.value = false;
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Something Went Wrong'),
                                                    content: const Text(
                                                        'Try After Sometime!!'),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                        child: const Text('OK'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      )
                                                    ],
                                                  );
                                                });
                                          }
                                        }
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                    }
                  ),
            ),
          );
        });
  }
}

Future insertImages(
  String id,
  String image,
) async {
  print('image insert it called');
  var response =
      await http.post(Uri.parse('${MyColors.baseUrl}expenseImage.php'), headers: {
    "Accept": "Application/json"
  }, body: {
    'expense_id': id,
    'image': image,
  });
  print(response.body);
    var convertedDatatoJson = jsonDecode(response.body);
  return convertedDatatoJson;
}

Future insertData(
  String office,
  String submissionDate,
  String tourId,
  String vendorName,
  String invoiceNo,
  String dateOfInvoice,
  String invoiceAmt,
  String towardsCostOf,
  String expenseHead,
  String expenseBy,
  String programme,
  String expenseApprovedBy,
  String dateOfPayment,
  String paidBy,
  String paymentApprovedBy,
  String paidAmt,
  String typeOfPayment,
  String modeOfPayment,
  String chequeNo,
  String referenceNo,
  String userId,
  String budgetHead,
) async {
  print('inser dat i  called');
  print(office);
  print(submissionDate);
  print(tourId);
  print(vendorName);
  print(invoiceNo);
  print(dateOfInvoice);
  print(invoiceAmt);
  print(towardsCostOf);
  print(expenseHead);
  print(expenseBy);
  print(programme);
  print(expenseApprovedBy);
  print(dateOfPayment);
  print(paidBy);
  print(paymentApprovedBy);
  print(paidAmt);
  print(typeOfPayment);
  print(modeOfPayment);
  print(chequeNo);
  print(referenceNo);
  print(userId);
  print(budgetHead);
  

  var response =
      await http.post(Uri.parse('${MyColors.baseUrl}expense.php'), headers: {
    "Accept": "Application/json"
  }, body: {
    "office": office,
    "submission_date": submissionDate,
    "tour_id": tourId,
    "vendor_name": vendorName,
    "invoice_no": invoiceNo,
    "date_of_invoice": dateOfInvoice,
    "invoice_amt": invoiceAmt,
    "towards_cost_of": towardsCostOf,
    "expense_head": expenseHead,
    "expense_by": expenseBy,
    "programme": programme,
    "expense_approved_by": expenseApprovedBy,
    // "image": image.toString(),
    "date_of_payment": dateOfPayment,
    "paid_by": paidBy,
    "payment_approved_by": paymentApprovedBy,
    "paid_amt": paidAmt,
    "type_of_payment": typeOfPayment,
    "mode_of_payment": modeOfPayment,
    "cheque_no": chequeNo,
    "reference_no": referenceNo,
    "uid": userId,
    "status": 'Pending',
    "budget_head":budgetHead,
  });
  print('this is from response exepsens form');
  print(response.body);
  var convertedDatatoJson = jsonDecode(response.body);

  return convertedDatatoJson;
}

class CardListView extends StatefulWidget {
  final List<MultipleImage>? name;
  final List<String>? images;
  const CardListView({super.key, this.name, this.images});

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
        height: 250,
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
                              image: widget.name![index].image, index: index);
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

class Card1 extends StatefulWidget {
  final File? image;

  final int? index;
  final String? imageLink;
  const Card1({
    super.key,
    this.imageLink,
    this.image,
    this.index,
  });

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
            ? Get.to(() => ImageView(image: widget.image!))
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
          child: Column(
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
                      onTap: () {

                        setState(() {
                          images64!.removeAt(widget.index!);
                          _imageList.removeAt(widget.index!);
                        });
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
