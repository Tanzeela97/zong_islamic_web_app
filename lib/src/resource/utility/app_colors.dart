import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  // zong assets

  static const pinkTextColor = Colors.pink;
  static const int _greenPrimaryValue = 0xffA7D129;
  static const MaterialColor greenAppBarColor = MaterialColor(
    _greenPrimaryValue,
    <int, Color>{
      50: Color(0xFFE8F5E9),
      100: Color(0xFFC8E6C9),
      200: Color(0xFFA5D6A7),
      300: Color(0xFF81C784),
      400: Color(0xFF66BB6A),
      500: Color(_greenPrimaryValue),
      600: Color(0xFF43A047),
      700: Color(0xFF388E3C),
      800: Color(0xFF2E7D32),
      900: Color(0xFF1B5E20),
    },
  );

  static const darkGreyTextColor = Color(0xff787A91);
  static const greenTextColor = Color(0xff81B214);
  static const black = Colors.black;
  static const white = Colors.white;
  static const canvasColor = Colors.white;
  static final mainColor = Colors.orange;
  static const lightPink = Color(0xffFCDADA);
  static const lightGrey = Color(0xffF6F6F6);
  static const darkPink = Color(0xffec0081);
  static const darkPurple = Color(0xff241c34);
  static var lightGreen = Colors.lightGreen[100];
  static const red = Colors.red;
  static var activeTrackColor = Colors.blue.shade100;
  static var inactiveTrackColor = Colors.grey.shade300;
  static const transparent = Colors.transparent;
  static const teal = Colors.teal;
  static var grey = Colors.grey[200];

}
