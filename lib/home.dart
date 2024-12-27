// // ignore_for_file: deprecated_member_use

// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:form/Controllers/networ_Controller.dart';
// import 'package:form/Controllers/pendingExpenses_Controller.dart';
// import 'package:form/Model/pending_expenses.dart';
// import 'package:form/data.dart';
// import 'package:form/forms/tour_da.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';

// import 'package:http/http.dart' as http;

// import '../colors.dart';
// import '../custom_dialog.dart';
// import '../image_view.dart';
// import '../my_text.dart';

// final PendingController _pendingController = Get.put(PendingController());

// class PendingForm extends StatefulWidget {
//   final PendingExpense? pendingExpense;

//   const PendingForm({Key? key, this.pendingExpense}) : super(key: key);

//   @override
//   PendingFormState createState() => PendingFormState();
// }

// TextEditingController _officeController = TextEditingController();

// class PendingFormState extends State<PendingForm> {
//   @override
//   void initState() {
//     super.initState();
//     _expenseHead = widget.pendingExpense!.expenseHead.toString();
//     _project = widget.pendingExpense!.project.toString();
//     _sponsor = widget.pendingExpense!.sponsor.toString();
//     _expenseBy = widget.pendingExpense!.expenseBy.toString();
//     _expenseApprovedBy = widget.pendingExpense!.expenseApprovedBy.toString();
//     _imagePicked = widget.pendingExpense!.image.toString();
//     _paidBy = widget.pendingExpense!.paidBy.toString();
//     _paymentApprovedBy =
//         widget.pendingExpense!.paymentApprovedBy.toString() == 'null'
//             ? "NA"
//             : widget.pendingExpense!.paymentApprovedBy.toString();
//     _paidAmountController.text = widget.pendingExpense!.paidAmt.toString();
//     _paymentType = widget.pendingExpense!.typeOfPayment.toString();
//     _tourIdController.text = widget.pendingExpense!.tourId.toString();
//     _invoiceAmountController.text =
//         widget.pendingExpense!.invoiceAmt.toString();
//     _vendorNameController.text = widget.pendingExpense!.vendorName.toString();
//     _invoiceNoController.text = widget.pendingExpense!.invoiceNo.toString();
//     _invoiceDateController.text =
//         (widget.pendingExpense!.dateOfInvoice.toString());
//     _towardsOfController.text = widget.pendingExpense!.towardsCost.toString();
//     _submitDateController.text =
//         (widget.pendingExpense!.submissionDate.toString());
//     _paymentDateController.text =
//         (widget.pendingExpense!.paymentDate.toString());

//     _paymentMode = widget.pendingExpense!.modeOfPayment.toString() == 'null'
//         ? 'NA'
//         : widget.pendingExpense!.modeOfPayment.toString();

//     _officeController.text = GetStorage().read('office').toString();
//     print(GetStorage().read('userId').toString());
//   }

//   // String? _selectedState;
//   String? _officeName;
//   String? _expenseHead;
//   String? _project;
//   String? _sponsor;
//   String? _expenseBy;
//   String? _expenseApprovedBy;
//   String? _imagePicked;
//   String? _paidBy;
//   String? _paymentApprovedBy;
//   String? _paymentMode;
//   String? _paymentType;

//   //bool _validateState = false;
//   bool _validateoffice = false;
//   bool _validateSubmitDate = false;
//   bool _validateTourId = false;
//   bool _validateVendor = false;
//   bool _validateInvoiceNo = false;
//   bool _validateInvoiceDate = false;
//   bool _validateInvoiceAmount = false;
//   bool _validateTowards = false;
//   bool _validatePaymentDate = false;
//   bool _validateExpenseHead = false;
//   bool _validateProject = false;
//   bool _validateSponsor = false;
//   bool _validateExpenseBy = false;
//   bool _validateExpenseApprovedBy = false;
//   bool _validateImagePicked = false;
//   bool _validatePaidBy = false;
//   bool _validatePaymentApprovedBy = false;
//   bool _validatePaidAmount = false;
//   bool _validatePaymentMode = false;
//   bool _validatePaymentType = false;
//   bool _validateAmount = false;
//   bool _settleAmount = false;
//   var isLoading = false.obs;

//   DateTime selectedDate = DateTime.now(), initialDate = DateTime.now();

//   _selectDate(BuildContext context, TextEditingController date) async {
//     final DateTime? selected = await showDatePicker(
//       locale: const Locale('en', 'IN'),
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2015),
//       context: context,
//       lastDate: DateTime(2030),
//       builder: (context, picker) {
//         return Theme(data: theme, child: picker!);
//       },
//     );
//     if (selected != null) {
//       setState(() {
//         selectedDate = selected;
//         String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
//         date.text = formattedDate;
//       });
//     }
//   }

//   PickedFile? _imageFile;
//   final ImagePicker _picker = ImagePicker();
//   File? _image;

//   Future<String> takePhoto(ImageSource source) async {
// //      ignore: deprecated_member_use
//     final pickedFile = await _picker.getImage(source: source);
//     _imageFile = pickedFile.obs();

//     _image = File(_imageFile!.path);
//     String status = base64Encode(_image!.readAsBytesSync());

//     return status;
//   }

//   TextEditingController _submitDateController = TextEditingController();
//   TextEditingController _tourIdController = TextEditingController();
//   TextEditingController _vendorNameController = TextEditingController();
//   TextEditingController _invoiceNoController = TextEditingController();
//   TextEditingController _invoiceDateController = TextEditingController();
//   TextEditingController _invoiceAmountController = TextEditingController();
//   TextEditingController _towardsOfController = TextEditingController();
//   TextEditingController _paymentDateController = TextEditingController();
//   TextEditingController _paidAmountController = TextEditingController();
//   TextEditingController _imageController = TextEditingController();

//   Widget bottomSheet(BuildContext context) {
//     return Container(
//       color: MyColors.primary,
//       height: 100,
//       width: double.infinity,
//       margin: const EdgeInsets.symmetric(
//         horizontal: 20,
//         vertical: 20,
//       ),
//       child: Column(
//         children: <Widget>[
//           const Text(
//             "Select Image",
//             style: const TextStyle(fontSize: 20.0, color: Colors.white),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               // ignore: deprecated_member_use
//               FlatButton.icon(
//                 onPressed: () async {
//                   _imagePicked = await takePhoto(ImageSource.camera);

//                   // uploadFile(userdata.read('customerID'));
//                   Navigator.pop(context);
//                   setState(() {});
//                 },
//                 icon: const Icon(
//                   Icons.camera,
//                   color: Colors.white,
//                 ),
//                 label: const Text(
//                   'Camera',
//                   style: const TextStyle(fontSize: 20.0, color: Colors.white),
//                 ),
//               ),
//               // ignore: deprecated_member_use
//               FlatButton.icon(
//                 onPressed: () async {
//                   _imagePicked = await takePhoto(ImageSource.gallery);

//                   // uploadFile(userdata.read('customerID'));

//                   Navigator.pop(context);
//                   setState(() {});
//                   //     takePhoto(ImageSource.gallery);
//                 },
//                 icon: const Icon(
//                   Icons.image,
//                   color: Colors.white,
//                 ),
//                 label: const Text(
//                   'Gallery',
//                   style: const TextStyle(fontSize: 20.0, color: Colors.white),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<GetXNetworkManager>(
//         init: GetXNetworkManager(),
//         builder: (networkManager) {
//           return Scaffold(
//             backgroundColor: MyColors.grey_5,
//             appBar: AppBar(
//               backgroundColor: const Color(0xFF8A2724),
//               title: const Text(
//                 'Complete Your Form',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//             body: Obx(
//               () => isLoading.value
//                   ? Stack(
//                       children: [
//                         Center(
//                           child: Container(
//                               color: Colors.white,
//                               child: Center(
//                                   child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                     'assets/17000ft.jpg',
//                                     height: 60,
//                                     width: 60,
//                                   ),
//                                   const CircularProgressIndicator(
//                                     valueColor: AlwaysStoppedAnimation<Color>(
//                                         MyColors.primary),
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   const Text('Please wait...',
//                                       style: TextStyle(
//                                         decoration: TextDecoration.none,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black,
//                                       ))
//                                 ],
//                               ))),
//                         )
//                       ],
//                     )
//                   : SingleChildScrollView(
//                       padding: const EdgeInsets.all(20),
//                       scrollDirection: Axis.vertical,
//                       child: Align(
//                         alignment: Alignment.topCenter,
//                         child: Container(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Container(height: 5),
//                               // const Text('State:',
//                               //     style: TextStyle(
//                               //         fontSize: 16,
//                               //         fontWeight: FontWeight.bold,
//                               //         color: MyColors.grey_95)),
//                               // Container(height: 10),
//                               // Container(
//                               //   height: 45,
//                               //   decoration: const BoxDecoration(
//                               //       color: Colors.white,
//                               //       borderRadius: const BorderRadius.all(Radius.circular(4))),
//                               //   alignment: Alignment.centerLeft,
//                               //   padding: const EdgeInsets.symmetric(horizontal: 25),
//                               //   child: InkWell(
//                               //     splashColor: Colors.grey,
//                               //     child: DropdownButton<String>(
//                               //       value: _selectedState,
//                               //       iconSize: 24,
//                               //       elevation: 2,
//                               //       items: DataModel().state.map((String value) {
//                               //         return DropdownMenuItem<String>(
//                               //           value: value,
//                               //           child: Text(value),
//                               //         );
//                               //       }).toList(),
//                               //       onChanged: (String? data1) {
//                               //         setState(() {
//                               //           _selectedState = data1!;
//                               //         });
//                               //       },
//                               //       isExpanded: true,
//                               //       hint: Text("State",
//                               //           style: MyText.body1(context)!
//                               //               .copyWith(color: MyColors.grey_40)),
//                               //       iconDisabledColor: Colors.black,
//                               //     ),
//                               //     onTap: () {},
//                               //   ),
//                               // ),
//                               // _validateState
//                               //     ? const Text('Please select a state',
//                               //         style: TextStyle(
//                               //             fontSize: 12,
//                               //             fontWeight: FontWeight.bold,
//                               //             color: Colors.red))
//                               //     : const SizedBox(),
//                               // Container(height: 15),
//                               const Text('Center:',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColors.grey_95)),
//                               Container(height: 10),
//                               Container(
//                                 height: 45,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(4))),
//                                 alignment: Alignment.centerLeft,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 25),
//                                 child: TextField(
//                                   readOnly: true,
//                                   maxLines: 1,
//                                   controller: _officeController,
//                                   decoration: InputDecoration(
//                                       contentPadding: const EdgeInsets.all(-12),
//                                       border: InputBorder.none,
//                                       hintText: "Center Name",
//                                       hintStyle: MyText.body1(context)!
//                                           .copyWith(color: MyColors.grey_40)),
//                                 ),
//                               ),
//                               _validateoffice
//                                   ? const Text('Please fill Center name',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red))
//                                   : const SizedBox(),
//                               Container(height: 15),
//                               const Text('Tour ID:',
//                                   style: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColors.grey_95)),
//                               Container(height: 10),
//                               Container(
//                                 height: 45,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(4))),
//                                 alignment: Alignment.centerLeft,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 25),
//                                 child: TextField(
//                                   maxLines: 1,
//                                   controller: _tourIdController,
//                                   decoration: InputDecoration(
//                                       contentPadding: const EdgeInsets.all(-12),
//                                       border: InputBorder.none,
//                                       hintText: "Tour ID",
//                                       hintStyle: MyText.body1(context)!
//                                           .copyWith(color: MyColors.grey_40)),
//                                 ),
//                               ),
//                               _validateTourId
//                                   ? const Text('Please fill Tour Id',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red))
//                                   : const SizedBox(),
//                               Container(height: 15),
//                               const Text('Vendor Name:',
//                                   // ignore: unnecessary_const
//                                   style: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColors.grey_95)),
//                               Container(height: 10),
//                               Container(
//                                 height: 45,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(4))),
//                                 alignment: Alignment.centerLeft,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 25),
//                                 child: TextField(
//                                   maxLines: 1,
//                                   controller: _vendorNameController,
//                                   decoration: InputDecoration(
//                                       contentPadding: const EdgeInsets.all(-12),
//                                       border: InputBorder.none,
//                                       hintText: "Vendor Name",
//                                       hintStyle: MyText.body1(context)!
//                                           .copyWith(color: MyColors.grey_40)),
//                                 ),
//                               ),
//                               _validateVendor
//                                   ? const Text('Please fill Vendor name',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red))
//                                   : const SizedBox(),
//                               Container(height: 15),
//                               const Text('Invoice No:',
//                                   // ignore: unnecessary_const
//                                   style: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColors.grey_95)),
//                               Container(height: 10),
//                               Container(
//                                 height: 45,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     // ignore: unnecessary_const
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(4))),
//                                 alignment: Alignment.centerLeft,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 25),
//                                 child: TextField(
//                                   maxLines: 1,
//                                   controller: _invoiceNoController,
//                                   decoration: InputDecoration(
//                                       contentPadding: const EdgeInsets.all(-12),
//                                       border: InputBorder.none,
//                                       hintText: "Invoice No:",
//                                       hintStyle: MyText.body1(context)!
//                                           .copyWith(color: MyColors.grey_40)),
//                                 ),
//                               ),
//                               _validateInvoiceNo
//                                   ? const Text('Please fill Invoice No',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red))
//                                   : const SizedBox(),
//                               Container(height: 15),
//                               const Text('Date of Invoice:',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColors.grey_95)),
//                               Container(height: 10),
//                               Container(
//                                 height: 45,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(4))),
//                                 alignment: Alignment.centerLeft,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Row(
//                                   children: <Widget>[
//                                     Container(width: 15),
//                                     Expanded(
//                                       child: TextField(
//                                         onChanged: (value) => setState(() {}),
//                                         readOnly: true,
//                                         onTap: () {
//                                           _selectDate(
//                                               context, _invoiceDateController);
//                                         },
//                                         maxLines: 1,
//                                         keyboardType: TextInputType.datetime,
//                                         controller: _invoiceDateController,
//                                         decoration: InputDecoration(
//                                             contentPadding:
//                                                 const EdgeInsets.all(-12),
//                                             border: InputBorder.none,
//                                             hintText:
//                                                 "Date of Invoice(dd-mm-yyyy)",
//                                             hintStyle: MyText.body1(context)!
//                                                 .copyWith(
//                                                     color: MyColors.grey_40)),
//                                       ),
//                                     ),
//                                     IconButton(
//                                         onPressed: () {
//                                           _selectDate(
//                                               context, _invoiceDateController);
//                                         },
//                                         icon: const Icon(Icons.calendar_today,
//                                             color: MyColors.grey_40))
//                                   ],
//                                 ),
//                               ),
//                               _validateInvoiceDate
//                                   ? const Text('Please select date',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red))
//                                   : const SizedBox(),
//                               Container(height: 15),
//                               const Text('Invoice Amount:',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColors.grey_95)),
//                               Container(height: 10),
//                               Container(
//                                 height: 45,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(4))),
//                                 alignment: Alignment.centerLeft,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 25),
//                                 child: TextField(
//                                   maxLines: 1,
//                                   keyboardType: TextInputType.number,
//                                   controller: _invoiceAmountController,
//                                   decoration: InputDecoration(
//                                       contentPadding: const EdgeInsets.all(-12),
//                                       border: InputBorder.none,
//                                       hintText: "Invoice Amount",
//                                       hintStyle: MyText.body1(context)!
//                                           .copyWith(color: MyColors.grey_40)),
//                                 ),
//                               ),
//                               _validateInvoiceAmount
//                                   ? const Text('Please fill Amount',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red))
//                                   : const SizedBox(),
//                               Container(height: 15),
//                               const Text('Expense Description:',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColors.grey_95)),
//                               Container(height: 10),
//                               Container(
//                                 height: 45,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(4))),
//                                 alignment: Alignment.centerLeft,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 25),
//                                 child: TextField(
//                                   maxLines: 1,
//                                   controller: _towardsOfController,
//                                   decoration: InputDecoration(
//                                       contentPadding: const EdgeInsets.all(-12),
//                                       border: InputBorder.none,
//                                       hintText: "Expense Description:",
//                                       hintStyle: MyText.body1(context)!
//                                           .copyWith(color: MyColors.grey_40)),
//                                 ),
//                               ),
//                               _validateTowards
//                                   ? const Text(
//                                       'Please fill Expense Description',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red))
//                                   : const SizedBox(),
//                               Container(height: 15),
//                               const Text('Expense Head:',
//                                   style: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColors.grey_95)),
//                               Container(height: 10),
//                               Container(
//                                 height: 45,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(4))),
//                                 alignment: Alignment.centerLeft,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 25),
//                                 child: InkWell(
//                                   splashColor: Colors.grey,
//                                   child: DropdownButton<String>(
//                                     value: _expenseHead,
//                                     iconSize: 24,
//                                     elevation: 2,
//                                     items: DataModel()
//                                         .expenseHead
//                                         .map((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                     onChanged: (String? v) {
//                                       setState(() {
//                                         _expenseHead = v;
//                                       });
//                                     },
//                                     isExpanded: true,
//                                     hint: Text("Expense Head",
//                                         style: MyText.body1(context)!
//                                             .copyWith(color: MyColors.grey_40)),
//                                     iconDisabledColor: Colors.black,
//                                   ),
//                                   onTap: () {},
//                                 ),
//                               ),
//                               _validateExpenseHead
//                                   ? const Text('Please select a Expense Head',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red))
//                                   : const SizedBox(),
//                               Container(height: 15),
//                               const Text('Programme Name:',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColors.grey_95)),
//                               Container(height: 10),
//                               Container(
//                                 height: 45,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(4))),
//                                 alignment: Alignment.centerLeft,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 25),
//                                 child: InkWell(
//                                   splashColor: Colors.grey,
//                                   child: DropdownButton<String>(
//                                     value: _project,
//                                     iconSize: 24,
//                                     elevation: 2,
//                                     items: DataModel()
//                                         .programName
//                                         .map((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                     onChanged: (dynamic v) {
//                                       setState(() {
//                                         _project = v;
//                                       });
//                                     },
//                                     isExpanded: true,
//                                     hint: Text("Select Programme",
//                                         style: MyText.body1(context)!
//                                             .copyWith(color: MyColors.grey_40)),
//                                     iconDisabledColor: Colors.black,
//                                   ),
//                                   onTap: () {},
//                                 ),
//                               ),
//                               _validateProject
//                                   ? const Text('Please select a programme',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red))
//                                   : const SizedBox(),

//                               // Container(
//                               //   height: 45,
//                               //   // ignore: prefer_const_constructors
//                               //   decoration: BoxDecoration(
//                               //       color: Colors.white,
//                               //       borderRadius: const BorderRadius.all(
//                               //           Radius.circular(4))),
//                               //   alignment: Alignment.centerLeft,
//                               //   padding:
//                               //       const EdgeInsets.symmetric(horizontal: 25),
//                               //   child: InkWell(
//                               //     splashColor: Colors.grey,
//                               //     child: DropdownButton<String>(
//                               //       value: _officeController.text,
//                               //       iconSize: 24,
//                               //       elevation: 2,
//                               //       items:
//                               //           DataModel().Office.map((String value) {
//                               //         return DropdownMenuItem<String>(
//                               //           value: value,
//                               //           child: Text(value),
//                               //         );
//                               //       }).toList(),
//                               //       onChanged: (dynamic v) {
//                               //         setState(() {
//                               //           _officeController.text = v;
//                               //         });
//                               //       },
//                               //       isExpanded: true,
//                               //       hint: Text("Select office",
//                               //           style: MyText.body1(context)!
//                               //               .copyWith(color: MyColors.grey_40)),
//                               //       iconDisabledColor: Colors.black,
//                               //     ),
//                               //     onTap: () {},
//                               //   ),
//                               // ),
//                               // _validateoffice
//                               //     ? const Text('Please select a office',
//                               //         style: TextStyle(
//                               //             fontSize: 12,
//                               //             fontWeight: FontWeight.bold,
//                               //             color: Colors.red))
//                               //     : const SizedBox(),
//                               Container(height: 15),
//                               const Text('Expense By:',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColors.grey_95)),
//                               Container(height: 10),
//                               Container(
//                                 height: 45,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(4))),
//                                 alignment: Alignment.centerLeft,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 25),
//                                 child: InkWell(
//                                   splashColor: Colors.grey,
//                                   child: DropdownButton<String>(
//                                     value: _expenseBy,
//                                     iconSize: 24,
//                                     elevation: 2,
//                                     items: DataModel()
//                                         .expenseBy
//                                         .map((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                     onChanged: (dynamic v) {
//                                       setState(() {
//                                         _expenseBy = v;
//                                       });
//                                     },
//                                     isExpanded: true,
//                                     hint: Text("Expense By",
//                                         style: MyText.body1(context)!
//                                             .copyWith(color: MyColors.grey_40)),
//                                     iconDisabledColor: Colors.black,
//                                   ),
//                                   onTap: () {},
//                                 ),
//                               ),
//                               _validateExpenseBy
//                                   ? const Text('Please select Expense By',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red))
//                                   : const SizedBox(),
//                               Container(height: 15),
//                               const Text('Upload Image:',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColors.grey_95)),
//                               Container(height: 10),
//                               Container(
//                                 height: 45,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(4))),
//                                 alignment: Alignment.centerLeft,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Row(
//                                   children: <Widget>[
//                                     Container(width: 15),
//                                     Expanded(
//                                       child: TextField(
//                                         readOnly: true,
//                                         onTap: () {
//                                           showModalBottomSheet(
//                                               backgroundColor: MyColors.primary,
//                                               context: context,
//                                               builder: ((builder) =>
//                                                   bottomSheet(context)));
//                                         },
//                                         maxLines: 1,
//                                         keyboardType: TextInputType.text,
//                                         controller: _imageController,
//                                         decoration: InputDecoration(
//                                             contentPadding:
//                                                 const EdgeInsets.all(-12),
//                                             border: InputBorder.none,
//                                             hintText:
//                                                 "Upload Image of Invoice with Approval",
//                                             hintStyle: MyText.body1(context)!
//                                                 .copyWith(
//                                                     color: MyColors.grey_40)),
//                                       ),
//                                     ),
//                                     CircleAvatar(
//                                         radius: 55,
//                                         backgroundColor: Colors.white,
//                                         child: _image != null
//                                             ? InkWell(
//                                                 onTap: () {
//                                                   Get.to(() => ImageView(
//                                                       image: _image!));
//                                                 },
//                                                 child: ClipRRect(
//                                                   borderRadius:
//                                                       BorderRadius.circular(50),
//                                                   child: Image.file(
//                                                     _image!,
//                                                     width: 100,
//                                                     height: 100,
//                                                     fit: BoxFit.fitHeight,
//                                                   ),
//                                                 ),
//                                               )
//                                             : Image.network(_imagePicked!)),
//                                     IconButton(
//                                         icon: const Icon(Icons.camera,
//                                             color: MyColors.grey_40),
//                                         onPressed: () {
//                                           showModalBottomSheet(
//                                               backgroundColor: MyColors.primary,
//                                               context: context,
//                                               builder: ((builder) =>
//                                                   bottomSheet(context)));
//                                         }),
//                                   ],
//                                 ),
//                               ),
//                               _validateImagePicked
//                                   ? const Text('Upload Image',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red))
//                                   : const SizedBox(),
//                               Container(height: 15),
//                               const Text('Type of Payment:',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColors.grey_95)),
//                               Container(height: 10),
//                               Container(
//                                 height: 45,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(4))),
//                                 alignment: Alignment.centerLeft,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 25),
//                                 child: InkWell(
//                                   splashColor: Colors.grey,
//                                   child: DropdownButton<String>(
//                                     value: _paymentType,
//                                     iconSize: 24,
//                                     elevation: 2,
//                                     items: DataModel()
//                                         .paymentType
//                                         .map((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                     onChanged: (dynamic v) {
//                                       setState(() {
//                                         _paymentType = v;
//                                       });
//                                     },
//                                     isExpanded: true,
//                                     hint: Text("Type of Payment",
//                                         style: MyText.body1(context)!
//                                             .copyWith(color: MyColors.grey_40)),
//                                     iconDisabledColor: Colors.black,
//                                   ),
//                                   onTap: () {},
//                                 ),
//                               ),
//                               _validatePaymentType
//                                   ? const Text('Please select Payment type',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red))
//                                   : const SizedBox(),
//                               Container(height: 15),
//                               const Text('Date of Payment:',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColors.grey_95)),
//                               Container(height: 10),
//                               Container(
//                                 height: 45,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(4))),
//                                 alignment: Alignment.centerLeft,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Row(
//                                   children: <Widget>[
//                                     Container(width: 15),
//                                     Expanded(
//                                       child: TextField(
//                                         readOnly: true,
//                                         onTap: () {
//                                           _selectDate(
//                                               context, _paymentDateController);
//                                         },
//                                         onChanged: (dynamic v) {
//                                           setState(() {});
//                                         },
//                                         maxLines: 1,
//                                         keyboardType: TextInputType.datetime,
//                                         controller: _paymentDateController,
//                                         decoration: InputDecoration(
//                                             contentPadding:
//                                                 const EdgeInsets.all(-12),
//                                             border: InputBorder.none,
//                                             hintText:
//                                                 "Date of Payment(dd-mm-yyyy)",
//                                             hintStyle: MyText.body1(context)!
//                                                 .copyWith(
//                                                     color: MyColors.grey_40)),
//                                       ),
//                                     ),
//                                     IconButton(
//                                         onPressed: () {
//                                           _selectDate(
//                                               context, _paymentDateController);
//                                         },
//                                         icon: const Icon(Icons.calendar_today,
//                                             color: MyColors.grey_40))
//                                   ],
//                                 ),
//                               ),
//                               _validatePaymentDate
//                                   ? const Text('Please select a date',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red))
//                                   : const SizedBox(),
//                               Container(height: 15),
//                               const Text('Paid By:',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColors.grey_95)),
//                               Container(height: 10),
//                               Container(
//                                 height: 45,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(4))),
//                                 alignment: Alignment.centerLeft,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 25),
//                                 child: InkWell(
//                                   splashColor: Colors.grey,
//                                   child: DropdownButton<String>(
//                                     value: _paidBy,
//                                     iconSize: 24,
//                                     elevation: 2,
//                                     items:
//                                         DataModel().paidBy.map((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                     onChanged: (dynamic v) {
//                                       setState(() {
//                                         _paidBy = v;
//                                       });
//                                     },
//                                     isExpanded: true,
//                                     hint: Text("Paid By",
//                                         style: MyText.body1(context)!
//                                             .copyWith(color: MyColors.grey_40)),
//                                     iconDisabledColor: Colors.black,
//                                   ),
//                                   onTap: () {},
//                                 ),
//                               ),
//                               _validatePaidBy
//                                   ? const Text('Please fill Name',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red))
//                                   : const SizedBox(),
//                               Container(height: 15),
//                               const Text('Paid Amount:',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColors.grey_95)),
//                               Container(height: 10),
//                               Container(
//                                 height: 45,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(4))),
//                                 alignment: Alignment.centerLeft,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 25),
//                                 child: TextField(
//                                   maxLines: 1,
//                                   keyboardType: TextInputType.number,
//                                   controller: _paidAmountController,
//                                   decoration: InputDecoration(
//                                       contentPadding: const EdgeInsets.all(-12),
//                                       border: InputBorder.none,
//                                       hintText: "Paid Amount",
//                                       hintStyle: MyText.body1(context)!
//                                           .copyWith(color: MyColors.grey_40)),
//                                 ),
//                               ),
//                               _validatePaidAmount
//                                   ? const Text('Please fill Paid Amount',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red))
//                                   : const SizedBox(),
//                               Container(height: 15),
//                               const Text('Mode of Payment:',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: MyColors.grey_95)),
//                               Container(height: 10),
//                               Container(
//                                 height: 45,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(4))),
//                                 alignment: Alignment.centerLeft,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 25),
//                                 child: InkWell(
//                                   splashColor: Colors.grey,
//                                   child: DropdownButton<String>(
//                                     value: _paymentMode,
//                                     iconSize: 24,
//                                     elevation: 2,
//                                     items: DataModel()
//                                         .paymentMode
//                                         .map((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                     onChanged: (dynamic v) {
//                                       setState(() {
//                                         _paymentMode = v;
//                                       });
//                                     },
//                                     isExpanded: true,
//                                     hint: Text("Mode of Payment",
//                                         style: MyText.body1(context)!
//                                             .copyWith(color: MyColors.grey_40)),
//                                     iconDisabledColor: Colors.black,
//                                   ),
//                                   onTap: () {},
//                                 ),
//                               ),
//                               _validatePaymentMode
//                                   ? const Text('Please select Payment Mode',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red))
//                                   : const SizedBox(),
//                               // Container(height: 15),
//                               // const Text('Submission Date:',
//                               //     style: TextStyle(
//                               //         fontSize: 16,
//                               //         fontWeight: FontWeight.bold,
//                               //         color: MyColors.grey_95)),
//                               // Container(height: 10),
//                               // Container(
//                               //   height: 45,
//                               //   decoration: const BoxDecoration(
//                               //       color: Colors.white,
//                               //       borderRadius:
//                               //           BorderRadius.all(Radius.circular(4))),
//                               //   alignment: Alignment.centerLeft,
//                               //   padding:
//                               //       const EdgeInsets.symmetric(horizontal: 10),
//                               //   child: Row(
//                               //     children: <Widget>[
//                               //       Container(width: 15),
//                               //       Expanded(
//                               //         child: TextField(
//                               //           onTap: () {
//                               //             // _selectDate(
//                               //             //     context, _submitDateController);
//                               //           },
//                               //           readOnly: true,
//                               //           onChanged: (value) {
//                               //             setState(() {});
//                               //           },
//                               //           maxLines: 1,
//                               //           style: MyText.body2(context)!
//                               //               .copyWith(color: MyColors.grey_40),
//                               //           keyboardType: TextInputType.datetime,
//                               //           controller: _submitDateController,
//                               //           decoration: InputDecoration(
//                               //               contentPadding:
//                               //                   const EdgeInsets.all(-12),
//                               //               border: InputBorder.none,
//                               //               hintText:
//                               //                   "Submission Date(dd-mm-yyyy)",
//                               //               hintStyle: MyText.body1(context)!
//                               //                   .copyWith(
//                               //                       color: MyColors.grey_40)),
//                               //         ),
//                               //       ),
//                               //       IconButton(
//                               //           onPressed: () {
//                               //             // setState(() {
//                               //             //   _selectDate(
//                               //             //       context, _submitDateController);
//                               //             //   });
//                               //           },
//                               //           icon: const Icon(Icons.calendar_today,
//                               //               color: MyColors.grey_40))
//                               //     ],
//                               //   ),
//                               // ),
//                               // _validateSubmitDate
//                               //     ? const Text('Please select a date',
//                               //         style: TextStyle(
//                               //             fontSize: 12,
//                               //             fontWeight: FontWeight.bold,
//                               //             color: Colors.red))
//                               //     : const SizedBox(),

//                               // Container(height: 15),
//                               // const Text('Project:',
//                               //     style: const TextStyle(
//                               //         fontSize: 16,
//                               //         fontWeight: FontWeight.bold,
//                               //         color: MyColors.grey_95)),
//                               // Container(height: 10),
//                               // Container(
//                               //   height: 45,
//                               //   decoration: const BoxDecoration(
//                               //       color: Colors.white,
//                               //       borderRadius: const BorderRadius.all(
//                               //           Radius.circular(4))),
//                               //   alignment: Alignment.centerLeft,
//                               //   padding:
//                               //       const EdgeInsets.symmetric(horizontal: 25),
//                               //   child: InkWell(
//                               //     splashColor: Colors.grey,
//                               //     child: DropdownButton<String>(
//                               //       value: _project,
//                               //       iconSize: 24,
//                               //       elevation: 2,
//                               //       items:
//                               //           DataModel().project.map((String value) {
//                               //         return DropdownMenuItem<String>(
//                               //           value: value,
//                               //           child: Text(value),
//                               //         );
//                               //       }).toList(),
//                               //       onChanged: (dynamic v) {
//                               //         setState(() {
//                               //           _project = v;
//                               //         });
//                               //       },
//                               //       isExpanded: true,
//                               //       hint: Text("Select Project",
//                               //           style: MyText.body1(context)!
//                               //               .copyWith(color: MyColors.grey_40)),
//                               //       iconDisabledColor: Colors.black,
//                               //     ),
//                               //     onTap: () {},
//                               //   ),
//                               // ),
//                               // _validateProject
//                               //     ? const Text('Please select a Project',
//                               //         style: TextStyle(
//                               //             fontSize: 12,
//                               //             fontWeight: FontWeight.bold,
//                               //             color: Colors.red))
//                               //     : const SizedBox(),
//                               // Container(height: 15),
//                               // const Text('Sponsor:',
//                               //     style: const TextStyle(
//                               //         fontSize: 16,
//                               //         fontWeight: FontWeight.bold,
//                               //         color: MyColors.grey_95)),
//                               // Container(height: 10),
//                               // Container(
//                               //   height: 45,
//                               //   decoration: const BoxDecoration(
//                               //       color: Colors.white,
//                               //       borderRadius:
//                               //           BorderRadius.all(Radius.circular(4))),
//                               //   alignment: Alignment.centerLeft,
//                               //   padding:
//                               //       const EdgeInsets.symmetric(horizontal: 25),
//                               //   child: InkWell(
//                               //     splashColor: Colors.grey,
//                               //     child: DropdownButton<String>(
//                               //       value: _sponsor,
//                               //       iconSize: 24,
//                               //       elevation: 2,
//                               //       items:
//                               //           DataModel().sponsor.map((String value) {
//                               //         return DropdownMenuItem<String>(
//                               //           value: value,
//                               //           child: Text(value),
//                               //         );
//                               //       }).toList(),
//                               //       onChanged: (dynamic v) {
//                               //         setState(() {
//                               //           _sponsor = v;
//                               //         });
//                               //       },
//                               //       isExpanded: true,
//                               //       hint: Text("Select Sponsor",
//                               //           style: MyText.body1(context)!
//                               //               .copyWith(color: MyColors.grey_40)),
//                               //       iconDisabledColor: Colors.black,
//                               //     ),
//                               //     onTap: () {},
//                               //   ),
//                               // ),
//                               // _validateSponsor
//                               //     ? const Text('Please select a Sponsor',
//                               //         style: TextStyle(
//                               //             fontSize: 12,
//                               //             fontWeight: FontWeight.bold,
//                               //             color: Colors.red))
//                               //     : const SizedBox(),

//                               // Container(height: 15),
//                               // const Text('Expense Approved By:',
//                               //     style: TextStyle(
//                               //         fontSize: 16,
//                               //         fontWeight: FontWeight.bold,
//                               //         color: MyColors.grey_95)),
//                               // Container(height: 10),
//                               // Container(
//                               //   height: 45,
//                               //   decoration: const BoxDecoration(
//                               //       color: Colors.white,
//                               //       borderRadius: const BorderRadius.all(
//                               //           Radius.circular(4))),
//                               //   alignment: Alignment.centerLeft,
//                               //   padding:
//                               //       const EdgeInsets.symmetric(horizontal: 25),
//                               //   child: InkWell(
//                               //     splashColor: Colors.grey,
//                               //     child: DropdownButton<String>(
//                               //       value: _expenseApprovedBy,
//                               //       iconSize: 24,
//                               //       elevation: 2,
//                               //       items: DataModel()
//                               //           .expenseApprovedBy
//                               //           .map((String value) {
//                               //         return DropdownMenuItem<String>(
//                               //           value: value,
//                               //           child: Text(value),
//                               //         );
//                               //       }).toList(),
//                               //       onChanged: (dynamic v) {
//                               //         setState(() {
//                               //           _expenseApprovedBy = v;
//                               //         });
//                               //       },
//                               //       isExpanded: true,
//                               //       hint: Text("Expense Approved By",
//                               //           style: MyText.body1(context)!
//                               //               .copyWith(color: MyColors.grey_40)),
//                               //       iconDisabledColor: Colors.black,
//                               //     ),
//                               //     onTap: () {},
//                               //   ),
//                               // ),
//                               // _validateExpenseApprovedBy
//                               //     ? const Text(
//                               //         'Please select Expense Approved By',
//                               //         style: TextStyle(
//                               //             fontSize: 12,
//                               //             fontWeight: FontWeight.bold,
//                               //             color: Colors.red))
//                               //     : const SizedBox(),

//                               // Container(height: 15),
//                               // const Text('Payment Approved By:',
//                               //     style: TextStyle(
//                               //         fontSize: 16,
//                               //         fontWeight: FontWeight.bold,
//                               //         color: MyColors.grey_95)),
//                               // Container(height: 10),
//                               // Container(
//                               //   height: 45,
//                               //   decoration: const BoxDecoration(
//                               //       color: Colors.white,
//                               //       borderRadius:
//                               //           BorderRadius.all(Radius.circular(4))),
//                               //   alignment: Alignment.centerLeft,
//                               //   padding:
//                               //       const EdgeInsets.symmetric(horizontal: 25),
//                               //   child: InkWell(
//                               //     splashColor: Colors.grey,
//                               //     child: DropdownButton<String>(
//                               //       value: _paymentApprovedBy,
//                               //       iconSize: 24,
//                               //       elevation: 2,
//                               //       items: DataModel()
//                               //           .paymentApprovedBy
//                               //           .map((String value) {
//                               //         return DropdownMenuItem<String>(
//                               //           value: value,
//                               //           child: Text(value),
//                               //         );
//                               //       }).toList(),
//                               //       onChanged: (dynamic v) {
//                               //         setState(() {
//                               //           _paymentApprovedBy = v;
//                               //         });
//                               //       },
//                               //       isExpanded: true,
//                               //       hint: Text("Payment Approved By",
//                               //           style: MyText.body1(context)!
//                               //               .copyWith(color: MyColors.grey_40)),
//                               //       iconDisabledColor: Colors.black,
//                               //     ),
//                               //     onTap: () {},
//                               //   ),
//                               // ),
//                               // _validatePaymentApprovedBy
//                               //     ? const Text(
//                               //         'Please select Payment Approved By',
//                               //         style: TextStyle(
//                               //             fontSize: 12,
//                               //             fontWeight: FontWeight.bold,
//                               //             color: Colors.red))
//                               //     : const SizedBox(),

//                               const SizedBox(height: 10),
//                               _validateAmount
//                                   ? const Text(
//                                       '* Paid Amount Should not be greater than Invoice Amount',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red))
//                                   : const SizedBox(),
//                               _settleAmount
//                                   ? const Text(
//                                       '* You have selected  settlement mode Please fill Same amount as Invoice Amount',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red))
//                                   : const SizedBox(),

//                               Container(height: 15),
//                               SizedBox(
//                                 width: double.infinity,
//                                 height: 45,
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                       primary: const Color(0xFF8A2724),
//                                       elevation: 0),
//                                   child: Text("SUBMIT",
//                                       style: MyText.subhead(context)!
//                                           .copyWith(color: Colors.white)),
//                                   onPressed: () async {
//                                     setState(() {
//                                       //  _validateAmount
//                                       _officeController.text.isNotEmpty
//                                           ? _validateoffice = false
//                                           : _validateoffice = true;
//                                       _submitDateController.text.isNotEmpty
//                                           ? _validateSubmitDate = false
//                                           : _validateSubmitDate = true;
//                                       _tourIdController.text.isNotEmpty
//                                           ? _validateTourId = false
//                                           : _validateTourId = true;
//                                       _vendorNameController.text.isNotEmpty
//                                           ? _validateVendor = false
//                                           : _validateVendor = true;
//                                       _invoiceNoController.text.isNotEmpty
//                                           ? _validateInvoiceNo = false
//                                           : _validateInvoiceNo = true;

//                                       _invoiceDateController.text.isNotEmpty
//                                           ? _validateInvoiceDate = false
//                                           : _validateInvoiceDate = true;
//                                       _invoiceAmountController.text.isNotEmpty
//                                           ? _validateInvoiceAmount = false
//                                           : _validateInvoiceAmount = true;
//                                       _towardsOfController.text.isNotEmpty
//                                           ? _validateTowards = false
//                                           : _validateTowards = true;
//                                       _expenseHead != null
//                                           ? _validateExpenseHead = false
//                                           : _validateExpenseHead = true;
//                                       _project != null
//                                           ? _validateProject = false
//                                           : _validateProject = true;
//                                       _sponsor != null
//                                           ? _validateSponsor = false
//                                           : _validateSponsor = true;
//                                       _expenseBy != null
//                                           ? _validateExpenseBy = false
//                                           : _validateExpenseBy = true;
//                                       _expenseApprovedBy != null
//                                           ? _validateExpenseApprovedBy = false
//                                           : _validateExpenseApprovedBy = true;
//                                       _imagePicked != null
//                                           ? _validateImagePicked = false
//                                           : _validateImagePicked = true;
//                                       _paymentDateController.text.isNotEmpty
//                                           ? _validatePaymentDate = false
//                                           : _validatePaymentDate = true;
//                                       _paidBy != null
//                                           ? _validatePaidBy = false
//                                           : _validatePaidBy = true;

//                                       _paymentApprovedBy != null
//                                           ? _validatePaymentApprovedBy = false
//                                           : _validatePaymentApprovedBy = true;
//                                       _paidAmountController.text.isNotEmpty
//                                           ? _validatePaidAmount = false
//                                           : _validatePaidAmount = true;
//                                       _paymentType != null
//                                           ? _validatePaymentType = false
//                                           : _validatePaymentType = true;
//                                       _paymentMode != null
//                                           ? _validatePaymentMode = false
//                                           : _validatePaymentMode = true;

//                                       String _invoiceAmount =
//                                           _invoiceAmountController.text;
//                                       String _paidAmount =
//                                           _paidAmountController.text;
//                                       double.parse(_invoiceAmount) <
//                                               double.parse(_paidAmount)
//                                           ? _validateAmount = true
//                                           : _validateAmount = false;

//                                       if (_paymentType == 'Settlement') {
//                                         double.parse(_invoiceAmount) ==
//                                                 double.parse(_paidAmount)
//                                             ? _settleAmount = false
//                                             : _settleAmount = true;
//                                       }
//                                     });
//                                     if (!_validateAmount &&
//                                         !_settleAmount &&
//                                         !_validatePaymentMode &&
//                                         !_validatePaymentType &&
//                                         !_validatePaidAmount &&
//                                         !_validatePaymentApprovedBy &&
//                                         !_validateSubmitDate &&
//                                         !_validateVendor &&
//                                         !_validatePaymentDate &&
//                                         !_validateTourId &&
//                                         !_validateoffice &&
//                                         !_validateImagePicked &&
//                                         !_validateExpenseApprovedBy &&
//                                         !_validateExpenseBy &&
//                                         !_validateExpenseHead &&
//                                         !_validateProject &&
//                                         !_validateSponsor &&
//                                         !_validatePaidBy &&
//                                         !_validateInvoiceAmount &&
//                                         !_validateInvoiceDate &&
//                                         !_validateInvoiceNo &&
//                                         !_validateTowards) {
//                                       if (networkManager.connectionType != 0) {
//                                         isLoading.value = true;
//                                         var rsp = await insertData(
//                                             widget.pendingExpense!.expenseId!,
//                                             _officeController.text,
//                                             _submitDateController.text,
//                                             _tourIdController.text,
//                                             _vendorNameController.text,
//                                             _invoiceNoController.text,
//                                             _invoiceDateController.text,
//                                             _invoiceAmountController.text,
//                                             _towardsOfController.text,
//                                             _expenseHead!,
//                                             _project!,
//                                             _sponsor!,
//                                             _expenseBy!,
//                                             _expenseApprovedBy!,
//                                             _imagePicked!,
//                                             _paymentDateController.text,
//                                             _paidBy!,
//                                             _paymentApprovedBy!,
//                                             _paidAmountController.text,
//                                             _paymentType!,
//                                             _paymentMode!,
//                                             GetStorage()
//                                                 .read('userId')
//                                                 .toString());

//                                         if (rsp['status'].toString() == '1') {
//                                           isLoading.value = false;
//                                           showDialog(
//                                               context: context,
//                                               builder: (_) =>
//                                                   const CustomEventDialog(
//                                                     title: 'Home',
//                                                   ));
//                                           setState(() {
//                                             _submitDateController.clear();
//                                             _tourIdController.clear();
//                                             _vendorNameController.clear();
//                                             _invoiceNoController.clear();
//                                             _invoiceDateController.clear();
//                                             _invoiceAmountController.clear();
//                                             _towardsOfController.clear();
//                                             _expenseHead = null;
//                                             _project = null;
//                                             _sponsor = null;
//                                             _expenseBy = null;
//                                             _expenseApprovedBy = null;
//                                             _image = null;
//                                             _paymentDateController.clear();
//                                             _paidBy = null;
//                                             _paymentApprovedBy = null;
//                                             _paidAmountController.clear();
//                                             _paymentType = null;
//                                             _paymentMode = null;
//                                             //   _selectedState = null;
//                                             _officeController.clear();
//                                           });
//                                           _pendingController.fetchPending();
//                                         } else if (rsp['status'].toString() ==
//                                             '0') {
//                                           isLoading.value = false;
//                                           showDialog(
//                                               context: context,
//                                               builder: (BuildContext context) {
//                                                 return AlertDialog(
//                                                   title: const Text(
//                                                       'Something Went Wrong'),
//                                                   content:
//                                                       const Text('Try Again!!'),
//                                                   actions: <Widget>[
//                                                     FlatButton(
//                                                       child: const Text('OK'),
//                                                       onPressed: () {
//                                                         Navigator.of(context)
//                                                             .pop();
//                                                       },
//                                                     )
//                                                   ],
//                                                 );
//                                               });
//                                         } else {
//                                           isLoading.value = false;
//                                           showDialog(
//                                               context: context,
//                                               builder: (BuildContext context) {
//                                                 return AlertDialog(
//                                                   title: const Text(
//                                                       'Something Went Wrong'),
//                                                   content: const Text(
//                                                       'Try After Sometime!!'),
//                                                   actions: <Widget>[
//                                                     FlatButton(
//                                                       child: const Text('OK'),
//                                                       onPressed: () {
//                                                         Navigator.of(context)
//                                                             .pop();
//                                                       },
//                                                     )
//                                                   ],
//                                                 );
//                                               });
//                                         }
//                                       } else {
//                                         print('Not Connected');
//                                         //   ExpenseModel offlineData = ExpenseModel(
//                                         //     office: _officeController.text,
//                                         //     submissionDate:
//                                         //         _submitDateController.text,
//                                         //     tourID: _tourIdController.text,
//                                         //     vendorName:
//                                         //         _vendorNameController.text,
//                                         //     invoiceNumber:
//                                         //         _invoiceNoController.text,
//                                         //     invoiceDate:
//                                         //         _invoiceDateController.text,
//                                         //     invoiceAmount:
//                                         //         _invoiceAmountController.text,
//                                         //     towardsCost:
//                                         //         _towardsOfController.text,
//                                         //     expenseHead: _expenseHead!,
//                                         //     projectName: _project!,
//                                         //     sponsorName: _sponsor!,
//                                         //     expenseBy: _expenseBy!,
//                                         //     expenseApprovedBy:
//                                         //         _expenseApprovedBy!,
//                                         //     invoiceImage: _imagePicked!,
//                                         //     dateOfPayment:
//                                         //         _paymentDateController.text,
//                                         //     paidBy: _paidBy!,
//                                         //     paymentApprovedBy:
//                                         //         _paymentApprovedBy!,
//                                         //     paidAmount:
//                                         //         _paidAmountController.text,
//                                         //     paymentType: _paymentType!,
//                                         //     paymentMode: _paymentMode!,
//                                         //     userId: GetStorage()
//                                         //         .read('userId')
//                                         //         .toString(),
//                                         //   );

//                                         //   _offlineHandler
//                                         //       .addAndStoreTask(offlineData);
//                                         //   isLoading.value = false;
//                                         //   showDialog(
//                                         //       context: context,
//                                         //       builder: (_) =>
//                                         //           const CustomEventDialog(
//                                         //             desc:
//                                         //                 'Stored On Device Sync when Internet is Available',
//                                         //           ));
//                                         //   setState(() {
//                                         //     _submitDateController.clear();
//                                         //     _tourIdController.clear();
//                                         //     _vendorNameController.clear();
//                                         //     _invoiceNoController.clear();
//                                         //     _invoiceDateController.clear();
//                                         //     _invoiceAmountController.clear();
//                                         //     _towardsOfController.clear();
//                                         //     _expenseHead = null;
//                                         //     _project = null;
//                                         //     _sponsor = null;
//                                         //     _expenseBy = null;
//                                         //     _expenseApprovedBy = null;
//                                         //     _image = null;
//                                         //     _paymentDateController.clear();
//                                         //     _paidBy = null;
//                                         //     _paymentApprovedBy = null;
//                                         //     _paidAmountController.clear();
//                                         //     _paymentType = null;
//                                         //     _paymentMode = null;
//                                         //     //   _selectedState = null;
//                                         //     _officeController.clear();
//                                         //   });
//                                       }
//                                     }
//                                   },
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//             ),
//           );
//         });
//   }
// }

// Future insertData(
//     String expenseId,
//     String office,
//     String submission_date,
//     String tour_id,
//     String vendor_name,
//     String invoice_no,
//     String date_of_invoice,
//     String invoice_amt,
//     String towards_cost_of,
//     String expense_head,
//     String project,
//     String sponsor,
//     String expense_by,
//     String expense_approved_by,
//     String image,
//     String date_of_payment,
//     String paid_by,
//     String payment_approved_by,
//     String paid_amt,
//     String type_of_payment,
//     String mode_of_payment,
//     String userId

//     // String state,
//     ) async {
//   var response =
//       await http.post(Uri.parse(MyColors.baseUrl + 'update_expense'), headers: {
//     "Accept": "Application/json"
//   }, body: {
//     "expense_id": expenseId,
//     "office": office,
//     "submission_date": submission_date,
//     "tour_id": tour_id,
//     "vendor_name": vendor_name,
//     "invoice_no": invoice_no,
//     "date_of_invoice": date_of_invoice,
//     "invoice_amt": invoice_amt,
//     "towards_cost_of": towards_cost_of,
//     "expense_head": expense_head,
//     "project": project,
//     "sponsor": sponsor,
//     "expense_by": expense_by,
//     "expense_approved_by": expense_approved_by,
//     "image": image,
//     "date_of_payment": date_of_payment,
//     "paid_by": paid_by,
//     "payment_approved_by": payment_approved_by,
//     "paid_amt": paid_amt,
//     "type_of_payment": type_of_payment,
//     "mode_of_payment": mode_of_payment,
//     "uid": userId
//   });
//   var convertedDatatoJson = jsonDecode(response.body);
//   return convertedDatatoJson;
// }
