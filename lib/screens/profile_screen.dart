// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:old17000ft/Controllers/school_Controller.dart';
import 'package:old17000ft/screens/edit_profile.dart';

import '../colors.dart';
import '../form.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwdController = TextEditingController();
  final StaffController _staffController = Get.put(StaffController());

  @override
  void initState() {
    super.initState();

    // _photograph
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = GetStorage().read('username');
    _emailController.text = _staffController.getStaffData![0].emailId!;
    _roleController.text = GetStorage().read('role');
    _phoneController.text = _staffController.getStaffData![0].mobileNo!;
    _passwdController.text = _staffController.getStaffData![0].dateOfBirth!;
    String gender = _staffController.getStaffData![0].gender!;
    String? img;
    _staffController.getStaffData![0].photograph == null
        ? img == null
        : img = _staffController.getStaffData![0].photograph!;
    String imgurl;
    if (img == null && gender == 'F') {
      imgurl =
          "https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava2-bg.webp";
    } else if (img == null && gender == 'M') {
      imgurl =
          "https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava3.webp";
    } else {
      imgurl = 'https://mis.17000ft.org/modules/EmployeeRegistration/images/Pic/$img';
    }
    print('image url is here');
    print(imgurl);

    return Scaffold(
      appBar: AppBar(
         iconTheme: const IconThemeData(color: Colors.white),
        
        title: const Text('Profile',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF8A2724),
      ),
      body: GetBuilder<StaffController>(
          init: StaffController(),
          builder: (staffController) {
            return Obx(
              () => staffController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(bottom: 90),
                                child: SizedBox(
                                  height: 180,
                                  width: 400,
                                  child: Image.network(
                                    'https://images.pexels.com/photos/618833/pexels-photo-618833.jpeg?cs=srgb&dl=pexels-sagui-andrea-618833.jpg&fm=jpg',
                                    color: const Color(0xFF8A2724),
                                    colorBlendMode: BlendMode.modulate,
                                    fit: BoxFit.cover,
                                  ),
                                  // color: Colors.green,
                                ),
                              ),
                              Positioned(
                                top: 90,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(imgurl),
                                  radius: 80,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                GetStorage().read('username'),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                '${GetStorage().read("role")}(${GetStorage().read("office")})',
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 10),
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
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          hintStyle:
                                              TextStyle(color: Colors.blue),
                                        ),
                                        controller: _nameController,
                                        readOnly: true,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: const Text('Email',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: MyColors.grey_95)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          hintStyle:
                                              TextStyle(color: Colors.blue),
                                        ),
                                        controller: _emailController,
                                        readOnly: true,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: const Text('Role',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: MyColors.grey_95)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          hintStyle:
                                              TextStyle(color: Colors.blue),
                                        ),
                                        controller: _roleController,
                                        readOnly: true,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: const Text('Phone',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: MyColors.grey_95)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          hintStyle:
                                              TextStyle(color: Colors.blue),
                                        ),
                                        controller: _phoneController,
                                        readOnly: true,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: const Text('Date of Birth',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: MyColors.grey_95)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          hintStyle:
                                              TextStyle(color: Colors.blue),
                                        ),
                                        controller: _passwdController,
                                        readOnly: true,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8A2724),
        onPressed: () {
          Get.to(() => const EditProfile());
        },
        child: const Icon(Icons.password_outlined),
      ),
    );
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
    // _imageList.add(image);
    final bytes = _image!.readAsBytesSync();

    String status = base64Encode(_image!.readAsBytesSync());

    return status;
  }
}
