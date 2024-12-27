import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:old17000ft/colors.dart';

class MultipleImage {
  File? image;

  MultipleImage({this.image});
}

class GeneralController extends GetxController {
  final bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<MultipleImage>? imageList = [];
  List<String>? images64 = [];
  String? _imagePicked;

  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  File? _image;
  Future<String> takePhoto(
    ImageSource source,
  ) async {
    _image = null;
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(
      source: source,
      imageQuality: 10,
    );
    _imageFile = pickedFile.obs();

    _image = File(_imageFile!.path);
    MultipleImage image = MultipleImage(image: _image);
    imageList!.add(image);


    String status = base64Encode(_image!.readAsBytesSync());

    return status;
  }

  Widget bottomSheet(
    BuildContext context,
  ) {
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
              // ignore: deprecated_member_use
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8A2724)),
                onPressed: () async {
                  _imagePicked = await takePhoto(ImageSource.camera);
                  print('image is picked');
                  print(_imagePicked);
                  images64!.add(_imagePicked!);
                  print(images64!.length.toString());

                  // uploadFile(userdata.read('customerID'));
                  Get.back();
                  update();
                },
                child: const Text(
                  'Camera',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8A2724)),
                onPressed: () async {
                  _imagePicked = await takePhoto(ImageSource.gallery);
                  images64!.add(_imagePicked!);
                  Get.back();
                  update();
                },
                child: const Text(
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

 
  removeImage(int index) {
    print('remove image is scalled');
    imageList!.removeAt(index);
    images64!.removeAt(index);
    update();
  }
}
