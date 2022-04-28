import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData zongTheme = theme1;

}

ThemeData theme1 = ThemeData(
  primaryColor: AppColor.mainColor,
  brightness: Brightness.light,
  primarySwatch: AppColor.greenAppBarColor,
  scaffoldBackgroundColor: AppColor.canvasColor,
  hintColor: Colors.grey,
  primaryColorLight: AppColor.darkPink,
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 60, color: AppColor.black),
    headline5: TextStyle(color: AppColor.white),
    headline4: TextStyle(color: AppColor.white),
    bodyText1: TextStyle(color: AppColor.black),
    subtitle1: TextStyle(
        color: AppColor.darkGreyTextColor), //define your customize setting
  ),
);

