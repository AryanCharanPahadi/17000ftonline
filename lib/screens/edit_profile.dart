// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../colors.dart';
import '../custom_dialog.dart';
import '../my_text.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _validatepassword = false;

  @override
  Widget build(BuildContext context) {
    _userController.text = GetStorage().read('username');
    // _passwordController.text = 'hey';
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Change Password',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF8A2724),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Form(
              child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: const Text('Username',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyColors.grey_95)),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.blue),
                    ),
                    readOnly: true,
                    controller: _userController,
                    onChanged: (value) {
                      _userController.text = value;
                      _userController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _userController.text.length));
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: const Text('Change Password',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyColors.grey_95)),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    controller: _passwordController,
                    onChanged: (value) {
                      _passwordController.text = value;
                      _passwordController.selection =
                          TextSelection.fromPosition(TextPosition(
                              offset: _passwordController.text.length));
                    }),
              ),
              _validatepassword
                  ? Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: const Text('**Please fill password',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
            ],
          )),
          SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8A2724), elevation: 0),
                  child: Text("Save Changes",
                      style: MyText.subhead(context)!
                          .copyWith(color: Colors.white)),
                  onPressed: () async {
                    setState(() {
                      _passwordController.text.isEmpty
                          ? _validatepassword = true
                          : _validatepassword = false;
                    });
                    if (!_validatepassword) {
                      var rsp = await changePassword(
                          _userController.text,
                          _passwordController.text,
                          GetStorage().read('userId'));
                      print(rsp);
                      if (rsp['status'] == 1) {
                        _passwordController.clear();
                        print('Inserted Successfully');
                        showDialog(
                            context: context,
                            builder: (_) => const CustomEventDialog(
                                  title: 'Login',
                                  head: 'Password Changed',
                                  desc: 'Successfull',
                                ));
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Something Went Wrong'),
                                content: const Text('Try Again!!'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      }
                    }
                  }))
        ],
      ),
    );
  }

  Future changePassword(
    String? username,
    String? passwd,
    String? userId,
  ) async {
    var response = await http
        .post(Uri.parse('${MyColors.baseUrl}edit_profile.php'), headers: {
      "Accept": "Application/json"
    }, body: {
      'username': username,
      'password': passwd,
      'user_id': userId,
    });
    var convertedDatatoJson = jsonDecode(response.body);
    return convertedDatatoJson;
  }
}
