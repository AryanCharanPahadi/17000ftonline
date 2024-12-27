import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:old17000ft/Controllers/expenseclaim_controller.dart';
import 'package:old17000ft/Model/expenseclaim_model.dart';
import 'package:old17000ft/colors.dart';
import 'package:old17000ft/forms/issue_tracker.dart';
import 'package:old17000ft/forms/travel_Requisition.dart';

import '../custom_dialog.dart';
import '../da_form.dart';
import '../image_view.dart';
import '../my_text.dart';

class MultipleImage {
  File? image;

  MultipleImage({this.image});
}

List<MultipleImage> _imageList = [];
List<String>? images64 = [];

class ExpenseClaimForm extends StatefulWidget {
  const ExpenseClaimForm({Key? key}) : super(key: key);

  @override
  State<ExpenseClaimForm> createState() => _ExpenseClaimFormState();
}

class _ExpenseClaimFormState extends State<ExpenseClaimForm> {
  @override
  void initState() {
    super.initState();

    // for (var element in schoolController.programme!) {
    //   program.add(element.program!);
    // }

    _imageList = [];
    images64 = [];
  }

  final TextEditingController _Datecontroller = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final ExpenseClaimContoller _myclaimController = ExpenseClaimContoller();
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  bool _validateDate = false;
  bool _validateAmount = false;
  bool _validateDescription = false;

  String? expenseHead;
  bool _validateExpenseHead = false;

  final FocusNode _amountNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();

  DateTime selectedDate = DateTime.now(), initialDate = DateTime.now();

  _selectDate(
    BuildContext context,
    TextEditingController date,
  ) async {
    final DateTime? selected = await showDatePicker(
      locale: const Locale('en', 'IN'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2017),
      lastDate: DateTime(2030),
      builder: (context, picker) {
        return Theme(data: theme, child: picker!);
      },
    );
    if (selected != null) {
      setState(() {
        selectedDate = selected;
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        date.text = formattedDate;
      });
    }
  }

  String? _imagePicked;
  bool _validateImagePicked = false;

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

  Widget bottomSheet(BuildContext context) {
    schoolController.getPaymentMode();
    schoolController.getPaymentType();
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
                style:
                    ElevatedButton.styleFrom(backgroundColor: MyColors.primary),
                onPressed: () async {
                  _imagePicked = await takePhoto(ImageSource.gallery);
                  images64!.add(_imagePicked!);
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

  var isLoading = false.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => isLoading.value
          ? const loadingWidget()
          : Scaffold(
              appBar: AppBar(
                  iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: MyColors.primary,
                title: const Text('Expense Claim Form',style: TextStyle(color: Colors.white),),
              ),
              body: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 10),
                      const Text('Date:',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MyColors.grey_95)),
                      Container(height: 10),
                      Container(
                        height: 45,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: <Widget>[
                            Container(width: 15),
                            Expanded(
                              child: TextField(
                                onTap: () {
                                  _selectDate(
                                    context,
                                    _Datecontroller,
                                  );
                                },
                                readOnly: true,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                maxLines: 1,
                                style: MyText.body2(context)!
                                    .copyWith(color: MyColors.grey_40),
                                keyboardType: TextInputType.datetime,
                                controller: _Datecontroller,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(-12),
                                    border: InputBorder.none,
                                    hintText: "Starting Date(yyyy-mm-dd)",
                                    hintStyle: MyText.body1(context)!
                                        .copyWith(color: MyColors.grey_40)),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _selectDate(
                                      context,
                                      _Datecontroller,
                                    );
                                  });
                                },
                                icon: const Icon(Icons.calendar_today,
                                    color: MyColors.grey_40))
                          ],
                        ),
                      ),
                      _validateDate
                          ? const Text('Please select a date',
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
                      //dropdown
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.white,
                                spreadRadius: 1,
                                blurRadius: 5)
                          ],
                        ),
                        child: Stack(children: [
                          DropdownButton<String>(
                            value: expenseHead,
                            iconSize: 24,
                            elevation: 2,
                            hint: const Text(
                              'Expense Head',
                              style: TextStyle(color: Colors.grey),
                            ),
                            items:
                                schoolController.expenseheadClaim!.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.expenseheadname.toString(),
                                child: Text(value.expenseheadname.toString()),
                              );
                            }).toList(),
                            onChanged: (data) {
                              setState(() {
                                expenseHead = data;
                              });
                            },
                          ),
                        ]),
                      ),
                      _validateExpenseHead
                          ? const Text('Please select a Expense Head',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red))
                          : const SizedBox(),
                      Container(height: 15),
                      const Text('Amount',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MyColors.grey_95)),
                      Container(height: 10),
                      Container(
                        height: 45,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(
                          onSubmitted: (value) {
                            //     FocusScope.of(context).requestFocus(_toNode);
                          },
                          focusNode: _amountNode,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[0-9.,]+')),
                          ],
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          maxLines: 1,
                          controller: _amountController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(-12),
                              border: InputBorder.none,
                              hintText: 'Enter Amount',
                              hintStyle: MyText.body1(context)!
                                  .copyWith(color: MyColors.grey_40)),
                        ),
                      ),
                      _validateAmount
                          ? const Text('Please fill the amount',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red))
                          : const SizedBox(),

                      Container(height: 15),

                      buildList(
                          context,
                          'Description',
                          _descriptionNode,
                          _descriptionController,
                          'Enter Description',
                          _validateDescription,
                          'Please fill the description'),

                      Container(height: 15),
                      const Text('Pics for Supporting: ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MyColors.grey_95)),
                      Container(height: 10),
                      Container(
                        height: 45,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                    contentPadding: const EdgeInsets.all(-12),
                                    border: InputBorder.none,
                                    hintText: "Upload Supporting Images",
                                    hintStyle: MyText.body1(context)!
                                        .copyWith(color: MyColors.grey_40)),
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
                      _imageList.isNotEmpty
                          ? const SizedBox(
                              height: 20,
                            )
                          : const SizedBox(),
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
                      Container(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8A2724),
                                elevation: 0),
                            child: Text("Add ",
                                style: MyText.subhead(context)!.copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () async {
                              setState(() {
                                _Datecontroller.text.isNotEmpty
                                    ? _validateDate = false
                                    : _validateDate = true;

                                _amountController.text.isNotEmpty
                                    ? _validateAmount = false
                                    : _validateAmount = true;
                                _descriptionController.text.isNotEmpty
                                    ? _validateDescription = false
                                    : _validateDescription = true;
                                _imageList.isNotEmpty
                                    ? _validateImagePicked = false
                                    : _validateImagePicked = true;

                                expenseHead != null
                                    ? _validateExpenseHead = false
                                    : _validateExpenseHead = true;
                              });

                              if (!_validateDate &&
                                  !_validateExpenseHead &&
                                  !_validateAmount &&
                                  !_validateDescription &&
                                  !_validateImagePicked) {
                                ExpenseClaim expenseClaimList = ExpenseClaim(
                                    submittedBy: GetStorage().read('userId'),
                                    date: _Datecontroller.text,
                                    expenseHead: expenseHead.toString(),
                                    amount: _amountController.text,
                                    description: _descriptionController.text,
                                    image: images64);
                                print('length of image before add expense');
                                print(images64!.length);
                                _myclaimController
                                    .addExpense(expenseClaimList);
                                print('check list values');
                                images64 = [];

                                setState(() {
                                  isLoading.value = false;
                                  _Datecontroller.clear();
                                  _amountController.clear();
                                  _descriptionController.clear();
                                  _imageList.clear();
                                  _imagePicked = null;
                                  images64!.clear();
                                  expenseHead = null;
                                });
                                print('length of image after add expense');
                                print(images64!.length);
                              }
                            }),
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: Text('Expense Form List',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: MyColors.grey_95)),
                      ),
                      GetBuilder<ExpenseClaimContoller>(
                          init: ExpenseClaimContoller(),
                          builder: (claimController) {
                            // return claimController.finalExpenseClaimList.isEmpty
                            //     ? Center(
                            //         heightFactor: 5.00,
                            //         child: Text(claimController
                            //             .finalExpenseClaimList.length
                            //             .toString()))
                            //     :
                            return _myclaimController
                                    .finalExpenseClaimList.isNotEmpty
                                ? Column(
                                    children: [
                                      ListView.builder(
                                          itemCount: _myclaimController
                                              .finalExpenseClaimList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            var textStyle = const TextStyle(
                                                fontWeight: FontWeight.bold);
                                            return ListTile(
                                              subtitle: RichText(
                                                  text: TextSpan(
                                                // ignore: prefer_const_constructors
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                ),
                                                children: <TextSpan>[
                                                  // ignore: unnecessary_new
                                                  new TextSpan(
                                                      text: "Date: ${_myclaimController
                                                              .finalExpenseClaimList[
                                                                  index]
                                                              .date}\n",
                                                      style: textStyle),
                                                  TextSpan(
                                                      text: "Expense Head: ${_myclaimController
                                                              .finalExpenseClaimList[
                                                                  index]
                                                              .expenseHead}\n",
                                                      style: textStyle),
                                                  TextSpan(
                                                      text: "Amount: ${_myclaimController
                                                              .finalExpenseClaimList[
                                                                  index]
                                                              .amount}",
                                                      style: textStyle),
                                                ],
                                              )),
                                              title: Text(_myclaimController
                                                  .finalExpenseClaimList[index]
                                                  .expenseHead!),
                                              leading: Text(
                                                '(${index + 1})',
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              trailing: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _myclaimController
                                                          .removeClaim(index);
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    size: 20,
                                                    color: Colors.red,
                                                  )),
                                              selectedTileColor:
                                                  Colors.green[400],
                                              onTap: () {
                                                setState(() {});
                                              },
                                            );
                                          }),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 45,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xFF8A2724),
                                                elevation: 0),
                                            child: Text("Submit ",
                                                style: MyText.subhead(context)!
                                                    .copyWith(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            onPressed: () async {
                                              isLoading.value = true;
                                              var uniqueId = getRandomString(8);
                                              print(_myclaimController
                                                  .finalExpenseClaimList[0]
                                                  .image!
                                                  .length);
                                              print('final submit is called');
                                              print(uniqueId);
                                              print(_myclaimController
                                                  .finalExpenseClaimList
                                                  .length);
                                              for (int i = 0;
                                                  i <
                                                      _myclaimController
                                                          .finalExpenseClaimList
                                                          .length;
                                                  i++) {
                                                print('loop is called');
                                                var rsp = await insertClaim(
                                                    GetStorage().read('userId'),
                                                    _myclaimController
                                                        .finalExpenseClaimList[
                                                            i]
                                                        .date!,
                                                    uniqueId,
                                                    _myclaimController
                                                        .finalExpenseClaimList[
                                                            i]
                                                        .expenseHead!,
                                                    _myclaimController
                                                        .finalExpenseClaimList[
                                                            i]
                                                        .amount!,
                                                    _myclaimController
                                                        .finalExpenseClaimList[
                                                            i]
                                                        .description!);
                                                print(
                                                    '{ we gert reponse from $rsp}');

                                                // print(images64!.length.toString());
                                                // print(images64![0]);
                                                // if (rsp['status'] == '1') {
                                                print(_myclaimController
                                                    .finalExpenseClaimList[i]
                                                    .image!
                                                    .length);
                                                for (int j = 0;
                                                    j <=
                                                        _myclaimController
                                                                .finalExpenseClaimList[
                                                                    i]
                                                                .image!
                                                                .length -
                                                            1;
                                                    j++) {
                                                  print('loop is here ');

                                                  var afjal = await insertImages(
                                                      rsp['id'].toString(),
                                                      _myclaimController
                                                          .finalExpenseClaimList[
                                                              i]
                                                          .image![j]);
                                                  print(afjal);
                                                }
                                                // }
                                                if (i ==
                                                    _myclaimController
                                                            .finalExpenseClaimList
                                                            .length -
                                                        1) {
                                                  if (rsp['status'] == 1) {
                                                    isLoading.value = false;
                                                    showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            const CustomEventDialog(
                                                                title: 'Home'));
                                                  }
                                                }
                                              }
                                            }),
                                      ),
                                    ],
                                  )
                                : const SizedBox(
                                    child:
                                        Center(child: Text('No records found')),
                                  );
                          })
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

Future insertImages(
  String id,
  String image,
) async {
  var response = await http
      .post(Uri.parse('${MyColors.baseUrl}insert_expenseImg.php'), headers: {
    "Accept": "Application/json"
  }, body: {
    'expense_claim_id': id,
    'image': image,
  });
  print('insert expense claim response ${response.body}');
  var convertedDatatoJson = jsonDecode(response.body);
  return convertedDatatoJson;
}

Future insertClaim(
  String userid,
  String date,
  String uniqueId,
  String expenseHead,
  String amount,
  String description,
) async {
  var response = await http
      .post(Uri.parse('${MyColors.baseUrl}insert_expense_claim.php'), headers: {
    "Accept": "Application/json"
  }, body: {
    'submitted_by': userid,
    'date': date,
    'unique_id': uniqueId,
    'expense_head': expenseHead,
    'amount': amount,
    'description': description,
  });
  print('this is my response body by expense claim ${response.body}');
  var convertedDatatoJson = jsonDecode(response.body);
  return convertedDatatoJson;
}

class CardListView extends StatefulWidget {
  final List<MultipleImage>? name;
  final List<String>? images;
  const CardListView({Key? key, this.name, this.images}) : super(key: key);

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
    Key? key,
    this.imageLink,
    this.image,
    this.index,
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
                      onTap: () {
                        print('image is remove at');
                        print(widget.index);
                        setState(() {
                          images64!.removeAt(widget.index!);
                          _imageList.removeAt(widget.index!);
                        });
                        setState(() {});
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

