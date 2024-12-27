import 'dart:io';

import 'package:flutter/material.dart';

import 'colors.dart';

class ImageView extends StatelessWidget {
  final File? image;
  final String? link;
  const ImageView({Key? key, this.image, this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primary,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.close),
      ),
      body: Center(
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: link == null
                ? Image.file(
                    image!,
                    fit: BoxFit.fitHeight,
                  )
                : Image.network(
                    link!,
                    fit: BoxFit.fitHeight,
                  ),
          ),
        ),
      ),
    );
  }
}

class ImageView1 extends StatelessWidget {
  final String? image;
  const ImageView1({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primary,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.close),
      ),
      body: Center(
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              image!,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }
}
