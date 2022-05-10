import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zong_islamic_web_app/src/model/token_status.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';

class AppUtility extends ChangeNotifier {
  static Map<int, int> namazTrackerMap = {
    0: -1,
    1: -1,
    2: -1,
    3: -1,
    4: -1,
  };

  static Map<DateTime, bool> namazOfferedMap = {
    DateTime.now(): false,
    DateTime.now(): false,
    DateTime.now(): false,
    DateTime.now(): false,
    DateTime.now(): false,
  };
  static Map<int, String> totalNamazCount = {
    0: AppString.fajar,
    1: AppString.zohar,
    2: AppString.asr,
    3: AppString.magrib,
    4: AppString.isha,
  };

  // static Future<TokenStatus> getTokenStatus() async {
  //   var tokenStatus = await ZongIslamicRemoteDataSourceImpl().getTokenStatus();
  //   final _preferences = await SharedPreferences.getInstance();
  //   _preferences.setString(AppString.tokenStatus, tokenStatus.jwt!);
  //   return tokenStatus;
  // }
}
