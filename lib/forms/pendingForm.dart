// ignore_for_file: deprecated_member_use, avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:old17000ft/Controllers/networ_Controller.dart';
import 'package:old17000ft/Controllers/school_Controller.dart';
import 'package:old17000ft/Model/expense_model.dart';
import 'package:old17000ft/Model/pending_expenses.dart';
import 'package:old17000ft/custom_dialog.dart';
import '../colors.dart';
import '../db.dart';
import '../form.dart';
import '../home_screen.dart';
import '../my_text.dart';
import 'package:http/http.dart' as http;

import 'da.dart';
import 'travel_Requisition.dart';

final StaffController _staffController = Get.put(StaffController());

class PendingForm extends StatefulWidget {
  final PendingExpense? pendingExpense;

  const PendingForm({Key? key, this.pendingExpense}) : super(key: key);

  @override
  PendingFormState createState() => PendingFormState();
}

TextEditingController _officeController = TextEditingController();

List<String> programs = [];
List<String> payMentMethod = [];

class PendingFormState extends State<PendingForm> {
  @override
  void initState() {
    super.initState();

    _officeController.text = GetStorage().read('office').toString();
    _expenseApprovedBy = '';

    for (var element in schoolController.programme!) {
      programs.add(element.program!);
    }

    _paymentApprovedBy = '';
    _officeName = DateFormat('dd-MM-yyyy').format(DateTime.now());
    _tourIdController.text = widget.pendingExpense!.tourId.toString();
    _vendorNameController.text = widget.pendingExpense!.vendorName.toString();
    _invoiceNoController.text = widget.pendingExpense!.invoiceNo.toString();
    _invoiceDateController.text =
        (widget.pendingExpense!.dateOfInvoice.toString());
    _invoiceAmountController.text =
        widget.pendingExpense!.invoiceAmt.toString();
    _towardsOfController.text = widget.pendingExpense!.towardsCost.toString();
    _expenseHeadController.text = widget.pendingExpense!.expenseHead.toString();
    _budgetHeadController.text = widget.pendingExpense!.budgetHead.toString();
    _programme = widget.pendingExpense!.programme?.toString();
    _expenseBy = widget.pendingExpense!.expenseBy.toString();
    _imageList.addAll(widget.pendingExpense!.image!.split(','));
    _imageList.removeAt(0);
    _paymentType = widget.pendingExpense!.typeOfPayment.toString();

    _expenseid = widget.pendingExpense!.expenseId.toString();
    _paymentDateController.text =
        (widget.pendingExpense!.paymentDate.toString());
    if (_paymentType != 'Pending') {
      _paidBy = widget.pendingExpense!.paidBy.toString();
      _paymentMode = widget.pendingExpense!.modeOfPayment.toString() == 'null'
          ? 'NA'
          : widget.pendingExpense!.modeOfPayment.toString();

      _bankController.text = widget.pendingExpense!.referenceNo.toString();
      _chequeController.text = widget.pendingExpense!.chequeNo.toString();
    }
    // _paidAmountController.text = widget.pendingExpense!.paidAmt.toString();
    _txnid = widget.pendingExpense!.txnid.toString();
    _amt = widget.pendingExpense!.finalamt.toString() == 'NA' ? widget.pendingExpense!.finalamt = '0.0' :  widget.pendingExpense!.finalamt.toString() ;

    // _remainingamt == null
    //     ? null
    //     : _remainingamt = double.parse(widget.pendingExpense!.invoiceAmt!) -
    //         double.parse(_amt!);
    // print("this is reaming amt");
    // print(_remainingamt);
  }

  String? _amt;
  String? _officeName;
  String? _expenseHead;
   String? _budgetHead;
  String? _programme;
  String? _sponsor;
  String? _expenseBy;
  String? _expenseApprovedBy;
  String? _imagePicked;
  String? _paidBy;
  String? _paymentApprovedBy;
  String? _paymentMode;
  String? _paymentType;
  String? _expenseid;
  String? _txnid;
  double? _remainingamt;
  final List<String> _imageList = [];

  bool _validateoffice = false;
  bool _validateTourId = false;
  bool _validateVendor = false;
  bool _validateInvoiceNo = false;
  bool _validateInvoiceDate = false;
  bool _validateInvoiceAmount = false;
  bool _validateTowards = false;
  bool _validatePaymentDate = false;
  bool _validateExpenseHead = false;
  bool _validateExpenseBy = false;
  bool _validateBudgetHead = false;
  //bool _validateImagePicked = false;
  bool _validatePaidBy = false;
  bool _validatePaidAmount = false;
  bool _validatePaymentMode = false;
  bool _validatePaymentType = false;
  bool _validateAmount = false;
  bool _validateProgramme = false;

  bool _validateAmount1 = false;
  bool _settleAmount = false;
  bool _settleAmount1 = false;
  bool _validatetype = false;
  bool _validateAmountPartial = false;
  bool _validateAmountPartial1 = false;
  bool _validateAmountPartial2 = false;
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
    final pickedFile = await _picker.getImage(
      source: source,
      imageQuality: 10,
    );
    _imageFile = pickedFile.obs();

    _image = File(_imageFile!.path);
    final bytes = _image!.readAsBytesSync();

    String status = base64Encode(_image!.readAsBytesSync());

    return status;
  }

  final TextEditingController _submitDateController = TextEditingController();
  final TextEditingController _tourIdController = TextEditingController();
  final TextEditingController _vendorNameController = TextEditingController();
  final TextEditingController _invoiceNoController = TextEditingController();
  final TextEditingController _invoiceDateController = TextEditingController();
  final TextEditingController _invoiceAmountController = TextEditingController();
  final TextEditingController _towardsOfController = TextEditingController();
  final TextEditingController _paymentDateController = TextEditingController();
  final TextEditingController _paidAmountController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _expenseHeadController = TextEditingController();
  final TextEditingController _budgetHeadController = TextEditingController();
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
            //_expenseHead!,
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () async {
                  _imagePicked = await takePhoto(
                    ImageSource.camera,
                  );

                  Navigator.pop(context);
                  setState(() {});
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
                onPressed: () async {
                  _imagePicked = await takePhoto(ImageSource.gallery);

                  Navigator.pop(context);
                  setState(() {});
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
    print(widget.pendingExpense!.typeOfPayment);
    print(programs);
    return GetBuilder<GetXNetworkManager>(
        init: GetXNetworkManager(),
        builder: (networkManager) {
          return Scaffold(
            backgroundColor: MyColors.grey_5,
            appBar: AppBar(
              backgroundColor: const Color(0xFF8A2724),
              title: const Text(
                'Complete your payments',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            body: Obx(
              () => isLoading.value || _staffController.isLoading.value
                  ? const loadingWidget()
                  : SingleChildScrollView(
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
                                enabled: false,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              alignment: Alignment.centerLeft,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextField(
                                textInputAction: TextInputAction.next,
                                readOnly: true,
                                enabled: false,
                                onSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(_vendorNode);
                                },
                                focusNode: _tourNode,
                                maxLines: 1,
                                controller: _tourIdController,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(-12),
                                    border: InputBorder.none,
                                    hintText: "Tour ID",
                                    hintStyle: MyText.body1(context)!
                                        .copyWith(color: MyColors.grey_40)),
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
                                enabled: false,
                                onSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(_invoiceNode);
                                },
                                focusNode: _vendorNode,
                                textInputAction: TextInputAction.next,
                                maxLines: 1,
                                controller: _vendorNameController,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(-12),
                                    border: InputBorder.none,
                                    hintText: "Vendor Name",
                                    hintStyle: MyText.body1(context)!
                                        .copyWith(color: MyColors.grey_40)),
                              ),
                            ),
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
                                readOnly: true,
                                enabled: false,
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
                                    child: TextField(
                                      // onChanged: (value) => setState(() {}),
                                      readOnly: true,
                                      enabled: false,
                                      onTap: () {
                                        // _selectDate(
                                        //     context, _invoiceDateController);
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
                                readOnly: true,
                                enabled: false,
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
                                readOnly: true,
                                enabled: false,
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
                                ? const Text('Please fill Towards Cost of',
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
                              child: TextField(
                                readOnly: true,
                                enabled: false,
                                focusNode: _towardsNode,
                                textInputAction: TextInputAction.next,
                                maxLines: 1,
                                controller: _expenseHeadController,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(-12),
                                    border: InputBorder.none,
                                    hintText: "Expense Head:",
                                    hintStyle: MyText.body1(context)!
                                        .copyWith(color: MyColors.grey_40)),
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
                              child: TextField(
                                readOnly: true,
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                maxLines: 1,
                                controller: _budgetHeadController,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(-12),
                                    border: InputBorder.none,
                                    hintText: "Budget Head:",
                                    hintStyle: MyText.body1(context)!
                                        .copyWith(color: MyColors.grey_40)),
                              ),
                            ),
                                _validateBudgetHead
                                    ? const Text('Please select a Budget Head',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))
                                    : const SizedBox(),
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
                                  items: programs.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
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
                                      value: "${value.firstName!} ${value.lastName!}",
                                      child: Text('${value.firstName!} ${value.lastName!}'),
                                    );
                                  }).toList(),
                                  onChanged: null,
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
                            const Text('Uploaded Images:',
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
                                      maxLines: 1,
                                      keyboardType: TextInputType.text,
                                      controller: _imageController,
                                      showCursor: false,
                                      enabled: false,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(-12),
                                          border: InputBorder.none,
                                          hintText: 'Uploaded Images',
                                          hintStyle: MyText.body1(context)!
                                              .copyWith(
                                                  color: MyColors.grey_40)),
                                    ),
                                  ),
                                  // CircleAvatar(
                                  //     radius: 55,
                                  //     backgroundColor: Colors.white,
                                  //     child: _imagePicked != null
                                  //         ? InkWell(
                                  //             onTap: () {
                                  //               print('ImageView1 is called');
                                  //               Get.to(() => ImageView1(
                                  //                   image: _imagePicked!));
                                  //             },
                                  //             child: ClipRRect(
                                  //               borderRadius:
                                  //                   BorderRadius.circular(50),
                                  //               child: Image.network(
                                  //                 _imagePicked!,
                                  //                 width: 100,
                                  //                 height: 100,
                                  //                 fit: BoxFit.fitHeight,
                                  //               ),
                                  //             ),
                                  //           )
                                  //         : Image.network(_imagePicked!)),
                                ],
                              ),
                            ),
                            _imageList.isNotEmpty
                                ? CardListView(
                                    images: _imageList,
                                  )
                                : const SizedBox(),
                            // _validateImagePicked
                            //     ? const Text('Uploaded Images',
                            //         style: TextStyle(
                            //             fontSize: 12,
                            //             fontWeight: FontWeight.bold,
                            //             color: Colors.red))
                            //     : const SizedBox(),
                            Container(height: 15),
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
                                  items: <String>[
                                    'Pending',
                                    'Partial',
                                    'Settlement'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (dynamic v) {
                                    setState(() {
                                      if (_paymentType == 'Pending') {}
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
                            _validatetype
                                ? const Text(
                                    'Please select Partial or Settlement mode',
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
                                            enabled: false,
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
                                              value: '${value.firstName!} ${value.lastName!}',
                                              child: Text('${value.firstName!} ${value.lastName!}'));
                                        }).toList(),
                                        onChanged: (dynamic v) {
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
                                : Text('Paid Amount:  ($_amt)',
                                    style: const TextStyle(
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
                            _validateAmountPartial1
                                ? const Text(
                                    '*You selected partial type of payment paid amount should be less than invoice amount',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red))
                                : const SizedBox(),
                            _validateAmountPartial2
                                ? const Text(
                                    '*You selected partial type of payment paid amount should be less than remaining amount',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red))
                                : const SizedBox(),
                             //done   
                            _validateAmount
                                ? const Text(
                                    '* Paid Amount Should not be greater than invoice Amount',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red))
                                : const SizedBox(),
                            _validateAmount1
                                ? const Text(
                                    '* Paid Amount Should not be greater than remaining Amount',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red))
                                : const SizedBox(),
                            _validateAmountPartial
                                ? const Text(
                                    '*partial Paid Amount Should not be greater than remaining Amount',
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
                                        items: <String>[
                                          'Cash',
                                          'Cheque',
                                          'Bank Transfer'
                                        ].map((String value) {
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
                                    //  tourValue != null
                                    //           ? _validateTourId = false
                                    //           : _validateTourId = true;
                                    _programme != null
                                        ? _validateProgramme = false
                                        : _validateProgramme = true;

                                    _validateAmountPartial2 = false;
                                    _validateAmountPartial = false;
                                    _validatetype = false;
                                    _settleAmount = false;
                                    _settleAmount1 = false;
                                    _validateAmountPartial1 = false;
                                    _officeController.text.isNotEmpty
                                        ? _validateoffice = false
                                        : _validateoffice = true;
                                    _tourIdController.text.isNotEmpty
                                        ? _validateTourId = false
                                        : _validateTourId = true;
                                    _vendorNameController.text.isNotEmpty
                                        ? _validateVendor = false
                                        : _validateVendor = true;
                                    _invoiceNoController.text.isNotEmpty
                                        ? _validateInvoiceNo = false
                                        : _validateInvoiceNo = true;

                                    _invoiceDateController.text.isNotEmpty
                                        ? _validateInvoiceDate = false
                                        : _validateInvoiceDate = true;
                                    _invoiceAmountController.text.isNotEmpty
                                        ? _validateInvoiceAmount = false
                                        : _validateInvoiceAmount = true;
                                    _towardsOfController.text.isNotEmpty
                                        ? _validateTowards = false
                                        : _validateTowards = true;
                                    _expenseHeadController.text.isNotEmpty
                                        ? _validateExpenseHead = false
                                        : _validateExpenseHead = true;
                                    _budgetHeadController.text.isNotEmpty
                                        ? _validateBudgetHead = false
                                        : _validateBudgetHead = true;
                                    _expenseBy != null
                                        ? _validateExpenseBy = false
                                        : _validateExpenseBy = true;
                                    // _imageList.isNotEmpty
                                    //     ? _validateImagePicked = false
                                    //     : _validateImagePicked = true;
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

                                    //pending to pending mode of payment
                                    if (_paymentType == 'Pending') {
                                      _validatetype = true;
                                    }

                                    // pending to partial paid amt shouldn't be equal to invoice amt
                                    if (_paymentType == 'Partial' &&
                                        _amt == '0.00') {
                                      double.parse(invoiceAmount) ==
                                              double.parse(paidAmount)
                                          ? _validateAmountPartial1 = true
                                          : _validateAmountPartial1 = false;
                                    }

                                    //partial to partial paid amt shouldn't be equal to  remaining amt
                                    if (_paymentType == 'Partial' &&
                                        _amt != '0.00') {
                                      _remainingamt =
                                          double.parse(invoiceAmount) -
                                              double.parse(_amt!);
                                      _remainingamt! ==
                                              double.parse(paidAmount)
                                          ? _validateAmountPartial2 = true
                                          : _validateAmountPartial2 = false;
                                    }

                                    // pending to partial paid amt shouldn't be greater than  invoice amt
                                    if (_paymentType == 'Partial' &&
                                        _amt == '0.00') {
                                      double.parse(invoiceAmount) <
                                              double.parse(paidAmount)
                                          ? _validateAmount = true
                                          : _validateAmount = false;
                                    }

                                    // partial to partial paid amt shouldn't be greater than  remaining amt
                                    if (_paymentType == 'Partial' &&
                                        _amt != '0.00') {
                                      print(
                                          'this is amt  by partial to partial');
                                      print(_amt);

                                      _remainingamt =
                                          double.parse(invoiceAmount) -
                                              double.parse(_amt!);
                                      print(_remainingamt);
                                      _remainingamt! < double.parse(paidAmount)
                                          ? _validateAmountPartial = true
                                          : _validateAmountPartial = false;
                                    }

                                    //pending to settlement paid amt should be equal to invoice amt
                                    if (_paymentType == 'Settlement' &&
                                        _amt == '0.00') {
                                      double.parse(invoiceAmount) ==
                                              double.parse(paidAmount)
                                          ? _settleAmount = false
                                          : _settleAmount = true;
                                    }

                                    //pending to settlement paid amt should not be greater than invoice amt
                                    if (_paymentType == 'Settlement' &&
                                        _amt == '0.00') {
                                      print('Helllo');

                                      setState(() {
                                        double.parse(invoiceAmount) <
                                                double.parse(paidAmount)
                                            ? _validateAmount = true
                                            : _validateAmount = false;
                                      });
                                    }

                                    //partial to settlement paid amt should not be greater than remaining amt
                                    if (_paymentType == 'Settlement' &&
                                        _amt != '0.00') {
                                      _remainingamt =
                                          double.parse(invoiceAmount) -
                                              double.parse(_amt!);

                                      setState(() {
                                        _remainingamt! <
                                                double.parse(paidAmount)
                                            ? _validateAmount1 = true
                                            : _validateAmount1 = false;
                                      });
                                    }

                                    //partial to settlement paid amt should be equal to remaining amt
                                    if (_paymentType == 'Settlement' &&
                                        _amt != '0.00') {
                                      _remainingamt =
                                          double.parse(invoiceAmount) -
                                              double.parse(_amt!);

                                      _remainingamt == double.parse(paidAmount)
                                          ? _settleAmount1 = false
                                          : _settleAmount1 = true;
                                    }

                                    if ((_settleAmount &&
                                            double.parse(
                                                    _invoiceAmountController
                                                        .text) >
                                                double.parse(
                                                    _paidAmountController
                                                        .text)) ||
                                        (_settleAmount1 &&
                                            _remainingamt! >
                                                double.parse(
                                                    _paidAmountController
                                                        .text))) {
                                      showDialog(
                                          context: context,
                                          builder: (_) => Confirmation(
                                              desc:
                                                  'You have selected  settlement mode. Is it Okay?',
                                              title: 'Alert',
                                              onPressed: () async {
                                                print('Hello');
                                                setState(() {
                                                  print(
                                                      'at the time of partial to settlement');
                                                  print(_settleAmount);
                                                  _settleAmount1 = false;
                                                });

                                                if (!_validateAmount &&
                                                    !_validateBank &&
                                                    !_validateChequeNo &&
                                                    !_settleAmount &&
                                                    !_settleAmount1 &&
                                                    !_validatetype &&
                                                    !_validateProgramme &&
                                                    !_validatePaymentMode &&
                                                    !_validatePaymentType &&
                                                    !_validatePaidAmount &&
                                                    !_validateVendor &&
                                                    !_validatePaymentDate &&
                                                    !_validateTourId &&
                                                    // !_validateImagePicked &&
                                                    !_validateExpenseBy &&
                                                    !_validateExpenseHead &&
                                                    !_validatePaidBy &&
                                                    !_validateInvoiceAmount &&
                                                    !_validateInvoiceDate &&
                                                    !_validateInvoiceNo &&
                                                    !_validateTowards &&
                                                    !_validateAmountPartial &&
                                                    !_validateAmountPartial1 &&
                                                    !_validateAmountPartial2 &&
                                                    !_validateAmount1) {
                                                  if (networkManager
                                                          .connectionType
                                                          .value !=
                                                      0) {
                                                    Navigator.of(context).pop();

                                                    isLoading.value = true;
                                                    var rsp = await insertData(
                                                        _expenseid!,
                                                        _officeController.text,
                                                        _officeName!,
                                                        _tourIdController.text,
                                                        _vendorNameController
                                                            .text,
                                                        _invoiceNoController
                                                            .text,
                                                        _invoiceDateController
                                                            .text,
                                                        _invoiceAmountController
                                                            .text,
                                                        _towardsOfController
                                                            .text,
                                                        _expenseHeadController
                                                            .text,
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
                                                        GetStorage()
                                                            .read('userId')
                                                            .toString(),
                                                        _txnid!,
                                                        _budgetHeadController.text.toString(),
                                                        );

                                                    if (rsp['status']
                                                            .toString() ==
                                                        '1') {
                                                      isLoading.value = false;
                                                      showDialog(
                                                          context: context,
                                                          builder: (_) =>
                                                              const CustomEventDialog(
                                                                  title:
                                                                      'Home'));
                                                      setState(() {
                                                        _submitDateController
                                                            .clear();
                                                        _tourIdController
                                                            .clear();
                                                        _vendorNameController
                                                            .clear();
                                                        _invoiceNoController
                                                            .clear();
                                                        _invoiceDateController
                                                            .clear();
                                                        _invoiceAmountController
                                                            .clear();
                                                        _towardsOfController
                                                            .clear();
                                                        _expenseHeadController
                                                            .clear();
                                                            _budgetHeadController.clear();
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
                                                        _imageController
                                                            .clear();
                                                        _imagePicked = null;
                                                        _paymentType = null;
                                                        _paymentMode = null;
                                                        _bankController.clear();
                                                        _chequeController
                                                            .clear();
                                                        _officeController
                                                            .clear();
                                                        _txnid = null;
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
                                                          _vendorNameController
                                                              .text
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
                                                      expenseHead:
                                                          _expenseHeadController
                                                              .text
                                                              .toString(),
                                                      budgetHead: _budgetHeadController.text.toString(),        
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
                                                                    title:
                                                                        'Home'));
                                                      } else {}
                                                    });
                                                    setState(() {
                                                      _submitDateController
                                                          .clear();
                                                      _tourIdController.clear();
                                                      _vendorNameController
                                                          .clear();
                                                      _invoiceNoController
                                                          .clear();
                                                      _invoiceDateController
                                                          .clear();
                                                      _invoiceAmountController
                                                          .clear();
                                                      _towardsOfController
                                                          .clear();
                                                      _expenseHeadController
                                                          .clear();
                                                       _budgetHeadController.clear();   
                                                      _imageController.clear();
                                                      _imagePicked = null;
                                                      _expenseBy = null;
                                                      _expenseApprovedBy = null;
                                                      _image = null;
                                                      _paymentDateController
                                                          .clear();
                                                      _paidBy = null;
                                                      _paymentApprovedBy = null;
                                                      _paidAmountController
                                                          .clear();
                                                      _paymentType = null;
                                                      _paymentMode = null;
                                                      _officeController.clear();
                                                      _txnid = null;
                                                    });
                                                  }
                                                }
                                              }));
                                    }
                                  });
                                  if (!_validateAmount &&
                                      !_validatetype &&
                                      !_validateBank &&
                                      !_validateChequeNo &&
                                      !_settleAmount &&
                                      !_validateProgramme &&
                                      !_settleAmount1 &&
                                      !_validatePaymentMode &&
                                      !_validatePaymentType &&
                                      !_validatePaidAmount &&
                                      !_validateVendor &&
                                      !_validatePaymentDate &&
                                      !_validateTourId &&
                                      // !_validateImagePicked &&
                                      !_validateExpenseBy &&
                                      !_validateExpenseHead &&
                                      !_validatePaidBy &&
                                      !_validateInvoiceAmount &&
                                      !_validateInvoiceDate &&
                                      !_validateInvoiceNo &&
                                      !_validateTowards &&
                                      !_validateAmountPartial &&
                                      !_validateAmountPartial1 &&
                                      !_validateAmountPartial2 &&
                                      !_validateAmount1) {
                                    if (networkManager.connectionType.value !=
                                        0) {
                                      isLoading.value = true;
                                      var rsp = await insertData(
                                          _expenseid!,
                                          _officeController.text,
                                          _officeName!,
                                          _tourIdController.text,
                                          _vendorNameController.text,
                                          _invoiceNoController.text,
                                          _invoiceDateController.text,
                                          _invoiceAmountController.text,
                                          _towardsOfController.text,
                                          _expenseHeadController.text,
                                          _expenseBy!,
                                          _programme!,
                                          _expenseApprovedBy!,
                                          _paymentDateController.text,
                                          _paidBy!,
                                          _paymentApprovedBy.toString(),
                                          _paidAmountController.text,
                                          _paymentType.toString(),
                                          _paymentMode.toString(),
                                          GetStorage()
                                              .read('userId')
                                              .toString(),
                                          _txnid!,
                                          _budgetHeadController.text.toString());

                                      if (rsp['status'].toString() == '1') {
                                        isLoading.value = false;
                                        showDialog(
                                            context: context,
                                            builder: (_) =>
                                                const CustomEventDialog(
                                                    title: 'Home'));
                                        setState(() {
                                          _submitDateController.clear();
                                          _tourIdController.clear();
                                          _vendorNameController.clear();
                                          _invoiceNoController.clear();
                                          _invoiceDateController.clear();
                                          _invoiceAmountController.clear();
                                          _towardsOfController.clear();
                                          _expenseHeadController.clear();
                                          _budgetHeadController.clear();
                                          _expenseBy = null;
                                          _expenseApprovedBy = null;
                                          _imageController.clear();
                                          _imagePicked = null;
                                          _paymentDateController.clear();
                                          _paidBy = null;
                                          _paymentApprovedBy = null;
                                          _paidAmountController.clear();
                                          _paymentType = null;
                                          _paymentMode = null;
                                          _officeController.clear();
                                          _bankController.clear();
                                          _chequeController.clear();
                                          _txnid = null;
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
                                    } else {
                                      ExpenseModel contactinfoModel =
                                          ExpenseModel(
                                        office:
                                            _officeController.text.toString(),
                                        submissionDate: _officeName!,
                                        tourId:
                                            _tourIdController.text.toString(),
                                        vendorName: _vendorNameController.text
                                            .toString(),
                                        invoiceNumber: _invoiceNoController.text
                                            .toString(),
                                        invoiceDate: _invoiceDateController.text
                                            .toString(),
                                        invoiceAmount: _invoiceAmountController
                                            .text
                                            .toString(),
                                        towardsCost: _towardsOfController.text
                                            .toString(),
                                        expenseHead: _expenseHeadController.text
                                            .toString(),
                                            budgetHead: _budgetHeadController.text.toString(),
                                        expenseBy: _expenseBy.toString(),
                                        expenseApprovedBy:
                                            _expenseApprovedBy.toString(),
                                        invoiceImage: _imagePicked,
                                        dateOfPayment: _paymentDateController
                                            .text
                                            .toString(),
                                        paidBy: _paidBy.toString(),
                                        paymentApprovedBy:
                                            _paymentApprovedBy.toString(),
                                        paidAmount: _paidAmountController.text
                                            .toString(),
                                        paymentType: _paymentType.toString(),
                                        paymentMode: _paymentMode.toString(),
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
                                                    desc: 'Data Submitted',
                                                  ));
                                        } else {}
                                      });
                                      setState(() {
                                        _submitDateController.clear();
                                        _tourIdController.clear();
                                        _vendorNameController.clear();
                                        _invoiceNoController.clear();
                                        _invoiceDateController.clear();
                                        _invoiceAmountController.clear();
                                        _towardsOfController.clear();
                                        _expenseHeadController.clear();
                                        _budgetHeadController.clear();
                                        _expenseBy = null;
                                        _expenseApprovedBy = null;
                                        _imageController.clear();
                                        _imagePicked = null;
                                        _paymentDateController.clear();
                                        _paidBy = null;
                                        _paymentApprovedBy = null;
                                        _paidAmountController.clear();
                                        _paymentType = null;
                                        _paymentMode = null;
                                        _officeController.clear();
                                        _txnid = null;
                                      });
                                    }
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            ),
          );
        });
  }
}

Future insertData(
    String expenseid,
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
    String program,
    String expenseApprovedBy,
    String dateOfPayment,
    String paidBy,
    String paymentApprovedBy,
    String paidAmt,
    String typeOfPayment,
    String modeOfPayment,
    String userId,
    String txnid,
    String budgetHead) async {
  print('expenseid: $expenseid');
  print('office: $office');
  print('submissionDate: $submissionDate');
  print('tourId: $tourId');
  print('vendorName: $vendorName');
  print('invoiceNo: $invoiceNo');
  print('dateOfInvoice: $dateOfInvoice');
  print('invoiceAmt: $invoiceAmt');
  print('towardsCostOf: $towardsCostOf');
  print('expenseHead: $expenseHead');
  print('expenseBy: $expenseBy');
  print('program: $program');
  print('expenseApprovedBy: $expenseApprovedBy');
  print('dateOfPayment: $dateOfPayment');
  print('paidBy: $paidBy');
  print('paymentApprovedBy: $paymentApprovedBy');
  print('paidAmt: $paidAmt');
  print('typeOfPayment: $typeOfPayment');
  print('modeOfPayment: $modeOfPayment');
  print('userId: $userId');
  print('txnid: $txnid');

  var response = await http
      .post(Uri.parse('${MyColors.baseUrl}testupdate_expense.php'), headers: {
    "Accept": "Application/json"
  }, body: {
    "expense_id": expenseid,
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
    "expense_approved_by": expenseApprovedBy,
    "date_of_payment": dateOfPayment,
    "paid_by": paidBy,
    "payment_approved_by": paymentApprovedBy,
    "paid_amt": paidAmt,
    "type_of_payment": typeOfPayment,
    "mode_of_payment": modeOfPayment,
    "uid": userId,
    "txn_id": txnid,
    "project": program,
    "budget_head": budgetHead,
  });
  print('tghus is resonse from pending payemtn ${response.body}');
  var convertedDatatoJson = jsonDecode(response.body);
 
  print(convertedDatatoJson);
  return convertedDatatoJson;
}
