// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:old17000ft/Controllers/da_controller.dart';
import 'package:old17000ft/Controllers/networ_Controller.dart';
import 'package:old17000ft/Controllers/school_Controller.dart';
import 'package:old17000ft/colors.dart';
import 'package:old17000ft/home_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

// networkController.connectionStatus.value == 0

class Signin2Page extends StatefulWidget {
  const Signin2Page({super.key});

  @override
  _Signin2PageState createState() => _Signin2PageState();
}

class _Signin2PageState extends State<Signin2Page> {
  bool _obscureText = true;
  IconData _iconVisible = Icons.visibility_off;
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  final DaController _daController = Get.put(DaController());
  final StaffController _staffController = Get.put(StaffController());

  final Color _gradientTop = const Color.fromRGBO(211, 194, 169, 1);
  final Color _gradientBottom = const Color.fromRGBO(211, 194, 169, 1);
  final Color _mainColor = const Color(0xFF8A2724);
  final Color _underlineColor = const Color(0xFFCCCCCC);
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorkey =
      GlobalKey<RefreshIndicatorState>();
  String? myTask;

  Future _refreshList(BuildContext context) async {
    return _refreshApp(context);
  }

  Future _refreshApp(BuildContext context) async {
    _networkManager.GetConnectionType();

    setState(() {});
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
  }

  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    _staffController.fetchAllStaff();
  }

  bool _validate = false;
  bool _validate1 = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetXNetworkManager>(
        init: GetXNetworkManager(),
        builder: (networkManager) {
          networkManager.GetConnectionType();

          return RefreshIndicator(
            key: _refreshIndicatorkey,
            onRefresh: () => _refreshList(context),
            child: Scaffold(
                backgroundColor: const Color.fromRGBO(211, 194, 169, 1),
                body: Obx(() => isLoading.value
                    ? Stack(
                        children: [
                          Center(
                            child: Container(
                                color: const Color.fromRGBO(211, 194, 169, 1),
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
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          MyColors.primary),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text('Fetching Your Details...',
                                        style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        )),
                                  ],
                                ))),
                          )
                        ],
                      )
                    : AnnotatedRegion<SystemUiOverlayStyle>(
                        value: const SystemUiOverlayStyle(
                            statusBarIconBrightness: Brightness.light),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              // top blue background gradient
                              // Container(
                              //   height: MediaQuery.of(context).size.height,
                              //   width: MediaQuery.of(context).size.width,
                              //   decoration: BoxDecoration(
                              //     gradient: LinearGradient(
                              //       begin: Alignment.topCenter,
                              //       end: Alignment.bottomCenter,
                              //       colors: [_gradientTop, _gradientBottom],
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 200,
                              // ),
                              // Container(
                              //   height:
                              //       MediaQuery.of(context).size.height / 3.5,
                              //   decoration: BoxDecoration(
                              //       gradient: LinearGradient(
                              //           colors: [_gradientTop, _gradientBottom],
                              //           begin: Alignment.topCenter,
                              //           end: Alignment.bottomCenter)),
                              // ),
                              // set your logo here
                              Container(
                                  padding: const EdgeInsets.only(top: 100),
                                  alignment: Alignment.topCenter,
                                  decoration: const BoxDecoration(
                                      color: Color.fromRGBO(211, 194, 169, 1),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30))),
                                  child: Image.asset(
                                    'assets/17000ft.jpg',
                                    height: 120,
                                    width: MediaQuery.of(context).size.width,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: <Widget>[
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 15,
                                      margin: const EdgeInsets.fromLTRB(
                                          32, 30, 32, 0),
                                      color: const Color.fromRGBO(
                                          211, 194, 169, 1),
                                      child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              24, 0, 24, 20),
                                          child: Column(
                                            children: <Widget>[
                                              const SizedBox(
                                                height: 40,
                                              ),
                                              Center(
                                                child: Text(
                                                  'SIGN IN',
                                                  style: TextStyle(
                                                      color: _mainColor,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ),
                                              Text(
                                                (networkManager
                                                            .connectionType ==
                                                        0)
                                                    ? '(You are Offline)'
                                                    : (networkManager
                                                                .connectionType ==
                                                            1)
                                                        ? '(You are Connected to Wifi)'
                                                        : '(You are Connected to Mobile Internet)',
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              TextFormField(
                                                //  validator: validateEmail,

                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                controller: _userController,
                                                decoration: InputDecoration(
                                                    errorText: _validate
                                                        ? "This field can't be empty"
                                                        : null,
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    Colors.grey[
                                                                        600]!)),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              _underlineColor),
                                                    ),
                                                    labelText: 'Username',
                                                    labelStyle: TextStyle(
                                                        color:
                                                            Colors.grey[700])),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              TextField(
                                                obscureText: _obscureText,
                                                controller: _passController,
                                                decoration: InputDecoration(
                                                  errorText: _validate1
                                                      ? "This field can't be empty"
                                                      : null,
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                          .grey[
                                                                      600]!)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: _underlineColor),
                                                  ),
                                                  labelText: 'Password',
                                                  labelStyle: TextStyle(
                                                      color: Colors.grey[700]),
                                                  suffixIcon: IconButton(
                                                      icon: Icon(_iconVisible,
                                                          color:
                                                              Colors.grey[700],
                                                          size: 20),
                                                      onPressed: () {
                                                        _toggleObscureText();
                                                      }),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              SizedBox(
                                                width: double.maxFinite,
                                                child: TextButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>(
                                                        (Set<MaterialState>
                                                                states) =>
                                                            _mainColor,
                                                      ),
                                                      overlayColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .transparent),
                                                      shape: MaterialStateProperty
                                                          .all(
                                                              RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      )),
                                                    ),
                                                    onPressed: () async {
                                                      if ((networkManager
                                                              .connectionType
                                                              .value !=
                                                          0)) {
                                                        _passController
                                                                .text.isEmpty
                                                            ? _validate1 = true
                                                            : _validate1 =
                                                                false;
                                                        _userController
                                                                .text.isEmpty
                                                            ? _validate = true
                                                            : _validate = false;

                                                        if (!_validate1 &&
                                                            !_validate) {
                                                          isLoading.value =
                                                              true;

                                                          var rsp = await loginUser(
                                                                  _userController
                                                                      .text,
                                                                  _passController
                                                                      .text);
                                                          if (rsp['status']
                                                                  .toString() ==
                                                              '1') {
                                                                print('1 bye status');
                                                            var uid =
                                                                rsp['emp_id'];

                                                            GetStorage().write(
                                                                'isLogged',
                                                                true);
                                                            GetStorage().write(
                                                                'username',
                                                                rsp['username']);
                                                                GetStorage().write(
                                                                    'office',
                                                                    rsp['office']);
                                                            GetStorage().write(
                                                                'userId',
                                                                rsp['emp_id']);
                                                            GetStorage().write(
                                                                'empda',
                                                                rsp['emp_da']);
                                                            GetStorage().write(
                                                                'officeId',
                                                                rsp['office_id']);

                                                            GetStorage().write(
                                                                'version',
                                                                rsp['version']);
                                                            PackageInfo
                                                                packageInfo =
                                                                await PackageInfo
                                                                    .fromPlatform();

                                                            var version =
                                                                await insertVersion(
                                                              uid: rsp['emp_id']
                                                                  .toString(),
                                                              version:
                                                                  packageInfo
                                                                      .version,
                                                            );
                                                            print(packageInfo
                                                                .version);
                                                            print(
                                                                '{ this is reposne from version $version}');

                                                            GetStorage().write(
                                                                'role',
                                                                rsp['role_name']);

                                                            List<String>
                                                                office =
                                                                rsp['office_name']
                                                                    .split(',');

                                                            if (office.length ==
                                                                1) {
                                                              GetStorage().write(
                                                                  'office',
                                                                  rsp['office_name']);
                                                              GetStorage().write(
                                                                  'officeId',
                                                                  rsp['office_id']);

                                                              isLoading.value =
                                                                  false;
                                                              Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          500),
                                                                  () {
                                                                Get.offAll(() =>
                                                                    const HomeScreen());
                                                              });
                                                            } else if (office
                                                                    .length >
                                                                1) {
                                                              // _daController
                                                              //     .addOffice(
                                                              //         _office);
                                                              GetStorage().write(
                                                                  'officeList',
                                                                  office
                                                                      .toList());
                                                              if (kDebugMode) {
                                                                print(office);
                                                              }
                                                              showDailog(
                                                                  context,
                                                                  office);

                                                              isLoading.value =
                                                                  false;
                                                            }
                                                          } else if (rsp[
                                                                      'status']
                                                                  .toString() ==
                                                              '0') {
                                                                 print('0 bye status');
                                                            isLoading.value =
                                                                false;

                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title: const Text(
                                                                        'Invalid Credentials'),
                                                                    content:
                                                                        const Text(
                                                                            'Fill Correct Details'),
                                                                    actions: <Widget>[
                                                                      ElevatedButton(
                                                                        child: const Text(
                                                                            'OK'),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      )
                                                                    ],
                                                                  );
                                                                });
                                                          } else {
                                                             print('error');
                                                            isLoading
                                                            .value =
                                                                false;

                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title: const Text(
                                                                        'Error'),
                                                                    content:
                                                                        Text(rsp[
                                                                            'message']),
                                                                    actions: <Widget>[
                                                                      ElevatedButton(
                                                                        child: const Text(
                                                                            'OK'),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      )
                                                                    ],
                                                                  );
                                                                });
                                                            isLoading.value =
                                                                false;
                                                          }
                                                        }
                                                        isLoading.value = false;
                                                      } else {
                                                        _passController
                                                                .text.isEmpty
                                                            ? _validate1 = true
                                                            : _validate1 =
                                                                false;
                                                        _userController
                                                                .text.isEmpty
                                                            ? _validate = true
                                                            : _validate = false;

                                                        if (!_validate1 &&
                                                            !_validate) {
                                                          isLoading.value =
                                                              true;
                                                          // AdminLogin rsp =
                                                          //     Controller().loginUser(
                                                          //         _userController
                                                          //             .text,
                                                          //         _passController
                                                          //             .text);
                                                          // if (kDebugMode) {
                                                          //   print(
                                                          //       'response is here $rsp');
                                                          // }
                                                        } else {
                                                          print(
                                                              "something went wrong");
                                                        }
                                                      }
                                                    },
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5),
                                                      child: Text(
                                                        'LOGIN',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Color.fromRGBO(
                                                                    211,
                                                                    194,
                                                                    169,
                                                                    1)),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    // create sign up link
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ))),
          );
        });
  }

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!) || value.isEmpty) {
      return 'Enter a valid email address';
    } else {
      return '';
    }
  }
}

Future loginUser(String uname, String upass) async {
  var response = await http.post(Uri.parse('${MyColors.baseUrl}new_login.php'),
      headers: {"Accept": "Application/json"},
      body: {'username': uname, 'password': upass});
  var convertedDatatoJson = jsonDecode(response.body);
  return convertedDatatoJson;
}

// UserModel offlineLogin(String username, String password) {
//   UserModel? verifiedUser;
//   for (var element in DataModel().user) {
//     if (element.username == username && element.password == password) {
//       verifiedUser = element;
//     }
//   }
//   return verifiedUser!;
// }

showDailog(BuildContext context, List<String> list) {
  GetStorage().write('office', list[0]);

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<DaController>(
            init: DaController(),
            builder: (daController) {
              return AlertDialog(
                contentPadding: const EdgeInsets.all(20),
                title: const Center(
                  child: Text('Select Office',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      for (var i = 0; i < list.length; i++)
                        RadioListTile(
                          title: Text(list[i],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xFF8A2724))),
                          value: list[i],
                          groupValue: daController.selectedRadio,
                          onChanged: (String? value) {
                            daController.setRadio(value);
                            GetStorage().write('office', list[i]);
                            schoolController
                                .filterList(GetStorage().read('office'));
                          },
                        ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  Center(
                    child: SizedBox(
                      width: double.maxFinite,
                      child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) =>
                                  const Color(0xFF8A2724),
                            ),
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                          ),
                          child: const Text('OK',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(211, 194, 169, 1))),
                          onPressed: () {
                            Get.offAll(() => const HomeScreen());
                          }),
                      // FlatButton(
                      //   child: const Text('SUBMIT'),
                      //   onPressed: () {
                      //     Get.offAll(() => const HomeScreen());
                      //   },
                      // ),
                    ),
                  )
                ],
              );
            });
      });
}

Future insertVersion({String? uid, String? version}) async {
  var response = await http.post(Uri.parse('${MyColors.baseUrl}version.php'),
      headers: {"Accept": "Application/json"},
      body: {'uid': uid, 'version': '1.3'});
  var convertedDatatoJson = jsonDecode(response.body);
  return convertedDatatoJson;
}
