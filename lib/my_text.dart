import 'package:flutter/material.dart';

class MyText {
  static TextStyle? display4(BuildContext context) {
    return Theme.of(context).textTheme.headlineLarge;
  }



  static TextStyle? display3(BuildContext context) {
    return Theme.of(context).textTheme.headlineLarge;
  }

  static TextStyle? display2(BuildContext context) {
    return Theme.of(context).textTheme.headlineLarge;
  }

  static TextStyle? display1(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall;
  }

  static TextStyle? headline(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall;
  }

  static TextStyle? title(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall;
  }

  static TextStyle medium(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontSize: 18,
        );
  }

  static TextStyle? subhead(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall;
  }

  static TextStyle? body2(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall;
  }

  static TextStyle? body1(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall;
  }

  static TextStyle? caption(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall;
  }

  static TextStyle? button(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(letterSpacing: 1);
  }

  static TextStyle? subtitle(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall;
  }

  static TextStyle? overline(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall;
  }
}
