import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:old17000ft/Controllers/da_controller.dart';
import 'package:old17000ft/Controllers/school_Controller.dart';
import 'package:old17000ft/Model/staff_data.dart';
import 'package:old17000ft/Model/tour.dart';
import 'package:old17000ft/custom_dialog.dart';
import '../colors.dart';
import '../home_screen.dart';
import '../my_text.dart';

ThemeData theme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF8A2724),
    onPrimary: Colors.white, // header text color
    onSurface: Colors.black, // body text color
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF8A2724), // button text color
    ),
  ),
);

class DaForm extends StatefulWidget {
  const DaForm({Key? key}) : super(key: key);

  @override
  State<DaForm> createState() => _DaFormState();
}

class _DaFormState extends State<DaForm> {
  final TextEditingController _fromController = TextEditingController();

  final TextEditingController _toController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _daController = TextEditingController();

  final DaController _newdaController = Get.put(DaController());
  @override
  String? tourValue;
  String? days;
  String? da;
  double? myda;

  // double? _grandDA = 0.0;
  // List<int>? _grandDalist = [];

  List<TourId>? _minetour = [];
  List<TourId>? get minetour => _minetour;

  bool _validateFrom = false;
  bool _validateTo = false;
  bool _validateStaff = false;
  final bool _validateStaffFrom = false;
  final bool _validateStaffTo = false;
  final bool _validateNights = false;
  bool _validateTour = false;

  var isLoading = false.obs;

  DateTime selectedDate = DateTime.now(), initialDate = DateTime.now();

  _selectDate(
    BuildContext context,
    TextEditingController date,
    String title,
  ) async {
    final DateTime? selected = await showDatePicker(
      locale: const Locale('en', 'IN'),
      context: context,
      initialDate: title == 'to' ? schoolController.from! : DateTime.now(),
      firstDate: title == 'to' ? schoolController.from! : DateTime(2017),
      lastDate: DateTime(2040),
      builder: (context, picker) {
        return Theme(data: theme, child: picker!);
      },
    );
    if (selected != null) {
      setState(() {
        selectedDate = selected;
        schoolController.setDate(selected, title);
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        date.text = formattedDate;
        if (title == 'from') {
          _toController.clear();
        }
        //    (getNumber(int.parse(DateFormat('dd').format(selectedDate))));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                'Daily Allowance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tour ID:',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: MyColors.grey_95)),
                  const SizedBox(
                    height: 15,
                  ),
                  GetBuilder<SchoolController>(
                    init: SchoolController(),
                    builder: (schoolController) {
                      schoolController.filterList(GetStorage().read('office'));

                      return Container(
                        height: 45,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: InkWell(
                          splashColor: Colors.grey,
                          child: DropdownButton<String>(
                            value: tourValue,
                            iconSize: 24,
                            elevation: 2,
                            hint: Text(
                              'Select Tour Id'.tr,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            // ignore: can_be_null_after_null_aware
                            items:
                                schoolController.schoolTourList!.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.tourId.toString(),
                                child: Text(value.tourId.toString()),
                              );
                            }).toList(),
                            onChanged: (data) {
                              setState(() {
                                tourValue = data;
                                _minetour = schoolController
                                    .mytour(tourValue.toString());
                                _fromController.text =
                                    _minetour![0].datefrom.toString();
                                _toController.text =
                                    _minetour![0].dateto.toString();
                                print("minetouur value" +
                                    _minetour![0].datefrom.toString());
                              });
                            },
                          ),
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        ),
                      );
                    },
                  ),
                  _validateTour
                      ? const Text('* Please Select Tour ID',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.red))
                      : const SizedBox(),
                  const Text('From:',
                      style: TextStyle(
                          fontSize: 18,
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
                              _selectDate(context, _fromController, 'from');
                            },
                            readOnly: true,
                            onChanged: (value) {
                              setState(() {
                                // schoolController.fromtour;
                              });
                            },
                            maxLines: 1,
                            style: MyText.body2(context)!
                                .copyWith(color: MyColors.grey_40),
                            keyboardType: TextInputType.datetime,
                            //controller: _fromController,
                            controller: _fromController,
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
                                _selectDate(context, _fromController, 'from');
                              });
                            },
                            icon: const Icon(Icons.calendar_today,
                                color: MyColors.grey_40))
                      ],
                    ),
                  ),
                  _validateFrom
                      ? const Text('Please select a date',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.red))
                      : const SizedBox(),
                  const Text('To:',
                      style: TextStyle(
                          fontSize: 18,
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
                            onTap: () async {
                              await _selectDate(context, _toController, 'to');

                              String formattedToDate = DateFormat('dd').format(
                                  DateFormat('yyyy-MM-dd')
                                      .parse(_toController.text));
                              String formattedFromDate = DateFormat('dd')
                                  .format(DateFormat('yyyy-MM-dd')
                                      .parse(_fromController.text));

                              setState(() {
                                days = ((int.parse(formattedToDate) -
                                            int.parse(formattedFromDate)) +
                                        1)
                                    .toString();
                                da = ((int.parse(formattedToDate) -
                                            int.parse(formattedFromDate) +
                                            1) *
                                        500)
                                    .toString();
                              });
                            },
                            readOnly: true,
                            onChanged: (value) {},
                            maxLines: 1,
                            style: MyText.body2(context)!
                                .copyWith(color: MyColors.grey_40),
                            keyboardType: TextInputType.datetime,
                            controller: _toController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(-12),
                                border: InputBorder.none,
                                hintText: "Ending Date(yyyy-mm-dd)",
                                hintStyle: MyText.body1(context)!
                                    .copyWith(color: MyColors.grey_40)),
                          ),
                        ),
                        IconButton(
                            onPressed: () async {
                              await _selectDate(context, _toController, 'to');
                            },
                            icon: const Icon(Icons.calendar_today,
                                color: MyColors.grey_40))
                      ],
                    ),
                  ),
                  _validateTo
                      ? const Text('Please select a date',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.red))
                      : const SizedBox(),
                  Container(height: 10),
                  Container(height: 10),
                  Row(
                    children: [
                      const Text('Staff List:',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: MyColors.grey_95)),
                      IconButton(
                          onPressed: () {
                            showStaffSheet(
                              context: context,
                              title: 'Add Staff',
                            );
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Color(0xFF8A2724),
                          ))
                    ],
                  ),
                  GetBuilder<DaController>(
                      init: DaController(),
                      builder: (_daController) {
                        return _daController.staffDetails == null
                            ? const SizedBox()
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _daController.staffDetails.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var textStyle = const TextStyle(
                                      fontWeight: FontWeight.bold);

                                  return ListTile(
                                    contentPadding:
                                        const EdgeInsets.only(bottom: 8),

                                    // title: Text( _daController.staffDetails[index].name== null
                                    //     ? ''
                                    //     : _daController.staffDetails[index].name.toString()),
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
                                            text: _daController
                                                    .staffDetails[index].name
                                                    .toString() +
                                                "\n"),
                                        TextSpan(
                                            text: "No of Days: " +
                                                _daController
                                                    .staffDetails[index].days
                                                    .toString() +
                                                "\n",
                                            style: textStyle),
                                        TextSpan(
                                            text: "No of Nights: " +
                                                _daController
                                                    .staffDetails[index].nights
                                                    .toString() +
                                                "\n",
                                            style: textStyle),
                                        TextSpan(
                                            text: "Daily Allowance: " +
                                                _daController
                                                    .staffDetails[index].empDa!
                                                    .toString(),
                                            style: textStyle),
                                      ],
                                    )),
                                    leading: Text(
                                      '(${index + 1})',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            // _daController.staffDetails.remove(
                                            //     _daController.staffDetails[index]);
                                            _daController.removeDa(_daController
                                                .staffDetails[index]);

                                            // _daController.removeDa(_daController
                                            //     .staffDetails[index].totalda!);
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 20,
                                          color: Colors.red,
                                        )),
                                    selectedTileColor: Colors.green[400],
                                    onTap: () {
                                      setState(() {});
                                    },
                                  );
                                },
                              );
                      }),
                  _validateStaff
                      ? const Text('Please select a staff',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.red))
                      : const SizedBox(),
                  Container(height: 10),
                ],
              ),
            ),
            bottomNavigationBar: GetBuilder<DaController>(
                init: DaController(),
                builder: (_daController) {
                  return Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8A2724), elevation: 0),
                          child: Row(
                            children: [
                              Text('Total DA ₹: ${_daController.grandDAList!}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              const Spacer(),
                              Text("Create DA",
                                  style: MyText.subhead(context)!
                                      .copyWith(color: Colors.white)),
                            ],
                          ),
                          onPressed: () async {
                            print("this is from tour data list");

                            setState(() {
                              tourValue == null
                                  ? _validateTour = true
                                  : _validateTour = false;

                              _fromController.text.isEmpty
                                  ? _validateFrom = true
                                  : _validateFrom = false;

                              _toController.text.isEmpty
                                  ? _validateTo = true
                                  : _validateTo = false;

                              _daController.staffDetails.isEmpty
                                  ? _validateStaff = true
                                  : _validateStaff = false;
                            });

                            if (!_validateTour &&
                                !_validateFrom &&
                                !_validateTo &&
                                !_validateStaff) {
                              isLoading.value = true;
                              print('Hello  ${_daController.empName}');

                              var rsp = await insert_tourda(
                                  tourValue!,
                                  _fromController.text,
                                  _toController.text,
                                  _daController.empName.toString(),
                                  _daController.empFrom.toString(),
                                  _daController.empTo.toString(),
                                  _daController.empDays.toString(),
                                  _daController.empNights.toString(),
                                  _daController.empDa.toString(),
                                  _daController.empRemark.toString(),
                                  _daController.grandDAList!.toString(),
                                  GetStorage().read('username'));
                              if (rsp['status'].toString() == '1') {
                                isLoading.value = false;
                                _daController.staffDetails.clear();
                                _fromController.clear();
                                _toController.clear();
                                _daController.empName.clear();
                                _daController.empFrom.clear();
                                _daController.empTo.clear();
                                _daController.empDays.clear();
                                _daController.empNights.clear();
                                _daController.empDa.clear();
                                _daController.empRemark.clear();
                                _daController
                                    .setTotalDa(_daController.grandDAList!);

                                tourValue = null;
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        const CustomEventDialog(title: 'Home'));
                                setState(() {
                                  _daController.staffDetails.clear();
                                  _fromController.clear();
                                  _toController.clear();
                                  _daController.empName.clear();
                                  _daController.empFrom.clear();
                                  _daController.empTo.clear();
                                  _daController.empDays.clear();
                                  _daController.empNights.clear();
                                  _daController.empDa.clear();
                                  _daController.empRemark.clear();
                                  _daController.grandDAList == 0.00;
                                  _daController
                                      .setTotalDa(_daController.grandDAList!);

                                  tourValue = null;
                                });
                              } else {
                                isLoading.value = false;

                                print('something went wrong');
                              }
                            }
                          }),
                    ),
                  );
                }),
          ));
  }

  Future insert_tourda(
    String tourid,
    String tourStartdate,
    String tourEnddate,
    String staffname,
    String staffFrom,
    String staffTo,
    String days,
    String nights,
    String empDa,
    String remark,
    String totalDa,
    String submittedby,
  ) async {
    print(staffname);
    var response = await http
        .post(Uri.parse(MyColors.baseUrl + 'insert_tour_da.php'), headers: {
      "Accept": "Application/json"
    }, body: {
      'tourid': tourid,
      'datefrom': tourStartdate,
      'dateto': tourEnddate,
      'emp_name': staffname,
      'emp_from': staffFrom,
      'emp_to': staffTo,
      'days': days,
      'nights': nights,
      'emp_da': empDa,   
      'remark': remark,
      'totaltourda': totalDa,
      'username': submittedby,
    });
    var convertedDatatoJson = jsonDecode(response.body);
    return convertedDatatoJson;
  }
}

//*********************Bottom sheet to add staff da***************************

void showStaffSheet({required BuildContext context, required String title}) {
  bool _validateFrom = false;

  bool _validateTo = false;
  double _grandDa = 0.0;
  //List<int>? _grandDalist =[];

  showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return GetBuilder<DaController>(
          init: DaController(),
          builder: (_daController) {
            return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.minHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Text(title,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Staff Name:',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: MyColors.grey_95)),
                        Container(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GetBuilder<StaffController>(
                                init: StaffController(),
                                builder: (staffController) {
                                  return staffController.staffList.isNotEmpty
                                      ? Flexible(
                                          child: SizedBox(
                                            child: distributeitems(
                                                context,
                                                'Select Staff',
                                                staffController
                                                    .staffList[0].data,
                                                2),
                                          ),
                                        )
                                      : buildFieldShimmer(context);
                                }),
                          ],
                        ),
                        Container(height: 10),
                        const Text('From:',
                            style: TextStyle(
                                fontSize: 18,
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: <Widget>[
                              Container(width: 15),
                              Expanded(
                                child: TextField(
                                  onTap: () {
                                    //              },
                                    //   _selectDate(context, _fromController, 'from');
                                  },
                                  readOnly: true,
                                  onChanged: (value) {},
                                  maxLines: 1,
                                  style: MyText.body2(context)!
                                      .copyWith(color: MyColors.grey_40),
                                  keyboardType: TextInputType.datetime,
                                  controller: _daController.fromController,
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
                                    _daController.selectDate(context,
                                        _daController.fromController, 'from');
                                  },
                                  icon: const Icon(Icons.calendar_today,
                                      color: MyColors.grey_40))
                            ],
                          ),
                        ),
                        const Text('To:',
                            style: TextStyle(
                                fontSize: 18,
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: <Widget>[
                              Container(width: 15),
                              Expanded(
                                child: TextField(
                                  onTap: () {
                                    _daController.selectDate(context,
                                        _daController.toController, 'to');
                                  },
                                  readOnly: true,
                                  onChanged: (value) {},
                                  maxLines: 1,
                                  style: MyText.body2(context)!
                                      .copyWith(color: MyColors.grey_40),
                                  keyboardType: TextInputType.datetime,
                                  controller: _daController.toController,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(-12),
                                      border: InputBorder.none,
                                      hintText: "Ending Date(yyyy-mm-dd)",
                                      hintStyle: MyText.body1(context)!
                                          .copyWith(color: MyColors.grey_40)),
                                ),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    await _daController.selectDate(context,
                                        _daController.toController, 'to');
                                    final birthday = DateFormat('yyyy-MM-dd')
                                        .parse(_daController.toController.text);
                                    final date2 = DateFormat('yyyy-MM-dd')
                                        .parse(
                                            _daController.fromController.text);
                                    final difference =
                                        birthday.difference(date2).inDays;

                                    _daController.daysController.text =
                                        (difference + 1).toString();
                                  },
                                  icon: const Icon(Icons.calendar_today,
                                      color: MyColors.grey_40))
                            ],
                          ),
                        ),
                        const Text('No of Days:',
                            style: TextStyle(
                                fontSize: 18,
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: <Widget>[
                              Container(width: 15),
                              Expanded(
                                child: TextField(
                                  onTap: () {
                                    // _daController.selectDate(context,
                                    //     _daController.toController, 'to');
                                  },
                                  readOnly: true,
                                  onChanged: (value) {},
                                  maxLines: 1,
                                  style: MyText.body2(context)!
                                      .copyWith(color: MyColors.grey_40),
                                  keyboardType: TextInputType.datetime,
                                  controller: _daController.daysController,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(-12),
                                      border: InputBorder.none,
                                      hintText: "No of days",
                                      hintStyle: MyText.body1(context)!
                                          .copyWith(color: MyColors.grey_40)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text('No of Nights:',
                            style: TextStyle(
                                fontSize: 18,
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: <Widget>[
                              Container(width: 15),
                              Expanded(
                                child: TextField(
                                  //readOnly: true,
                                  onChanged: (value) {
                                    _daController.totalEmpDaController.text =
                                        ((int.parse(_daController
                                                        .daysController.text) +
                                                    int.parse(value)) *
                                                250)
                                            .toString();
                                  },
                                  maxLines: 1,
                                  style: MyText.body2(context)!
                                      .copyWith(color: MyColors.grey_40),
                                  keyboardType: TextInputType.number,
                                  controller:
                                      _daController.nightcountController,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(-12),
                                      border: InputBorder.none,
                                      hintText: "No of nights",
                                      hintStyle: MyText.body1(context)!
                                          .copyWith(color: MyColors.grey_40)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text('Daily Allowance:',
                            style: TextStyle(
                                fontSize: 18,
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: <Widget>[
                              Container(width: 15),
                              Expanded(
                                child: TextField(
                                  onTap: () {
                                    // _daController.selectDate(context,
                                    //     _daController.toController, 'to');
                                  },
                                  readOnly: true,
                                  onChanged: (value) {},
                                  maxLines: 1,
                                  style: MyText.body2(context)!
                                      .copyWith(color: MyColors.grey_40),
                                  keyboardType: TextInputType.datetime,
                                  controller:
                                      _daController.totalEmpDaController,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(-12),
                                      border: InputBorder.none,
                                      hintText: "Daily Allowance",
                                      hintStyle: MyText.body1(context)!
                                          .copyWith(color: MyColors.grey_40)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(height: 10),
                        const Text('Remarks:',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: MyColors.grey_95)),
                        Container(height: 10),
                        TextField(
                          textInputAction: TextInputAction.done,
                          controller: _daController.remark,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              hintText: 'Type Something.....',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              )),
                          maxLines: 6,
                        ),
                        Container(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF8A2724),
                                  elevation: 0),
                              child: Text("Add",
                                  style: MyText.subhead(context)!
                                      .copyWith(color: Colors.white)),
                              onPressed: () async {
                                // var da =0;
                                //  da = da + int.parse( _daController.totalEmpDaController.text);
                                //   _grandDalist.add(da);
                                //  print(_grandDalist.length);

                                StaffDetails staff = StaffDetails(
                                  name: _daController.staffName,
                                  from: _daController.fromController.text,
                                  to: _daController.toController.text,
                                  days: _daController.daysController.text,
                                  nights:
                                      _daController.nightcountController.text,
                                  empDa: double.parse(
                                      _daController.totalEmpDaController.text),
                                  remark: _daController.remark.text,
                                );

                                _daController.addData(staff);
                                _daController.addDA(double.parse(
                                    _daController.totalEmpDaController.text));
                                _daController.addName(_daController.staffName!);
                                _daController
                                    .addFrom(_daController.fromController.text);
                                _daController
                                    .addTo(_daController.toController.text);
                                _daController
                                    .addDays(_daController.daysController.text);
                                _daController.addNights(
                                    _daController.nightcountController.text);
                                _daController.addEmpDa(
                                    _daController.totalEmpDaController.text);
                                _daController
                                    .addRemark(_daController.remark.text);
                                print("this is da");

                                //  print(staff.calTotalDa());
                                //  _daController.grandDA;

                                _daController.clearData();
                                Navigator.of(context).pop();
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
          },
        );
      });
  //*************************End bottomsheet to add Staff***************************
}

//*************dropdown for staff *************************************
Container distributeitems(
  BuildContext context,
  String name,
  List<Datum>? data,
  int index,
) {
  return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(color: Colors.white, spreadRadius: 1, blurRadius: 5)
        ],
      ),
      child: Stack(children: [
        DropdownButton<String>(
          value: daController.staffName,
          iconSize: 20,
          elevation: 2,
          isExpanded: true,
          hint: Text(
            name,
            style: const TextStyle(color: Colors.grey),
          ),
          items: data!.map((value) {
            return DropdownMenuItem<String>(
              value: value.firstName! + ' ' + value.lastName!,
              child: Text(value.firstName! + ' ' + value.lastName!),
            );
          }).toList(),
          onChanged: (data) {
            daController.setStaffName(data);
          },
        ),
      ]));
}
