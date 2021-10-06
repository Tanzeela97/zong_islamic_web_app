import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';

class StoredAuthStatus with ChangeNotifier {
  final SharedPreferences? sharedPreferences;
  StoredAuthStatus(this.sharedPreferences){
    _getAuthStatus();
  }
  bool _authStatus = false;
  bool get authStatus=>_authStatus;
  void saveAuthStatus(bool? status) {
    if (status != null) {
      sharedPreferences!.setBool(AppString.auth, status);
    } else {
      sharedPreferences!.setBool(AppString.auth, false);
    }
    _getAuthStatus();
  }

  void _getAuthStatus() {
    _authStatus= sharedPreferences!.getBool(AppString.auth)??false;
    notifyListeners();
  }
}
