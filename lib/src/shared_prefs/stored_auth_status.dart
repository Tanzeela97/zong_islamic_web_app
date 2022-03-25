import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';

class StoredAuthStatus with ChangeNotifier {
  SharedPreferences? sharedPreferences;

  StoredAuthStatus() {
    SharedPreferences.getInstance().then((value) {
      sharedPreferences = value;
      _getAuthStatus();
      getQuranPlannerStatus();
    });
  }

  bool _authStatus = false;

  bool get authStatus => _authStatus;
  int _navIndex = 0;

  int get navIndex => _navIndex;
  String _authNumber = '';

  String get authNumber => _authNumber;

  bool _isQuranPlannerActivated = false;

  bool get isQuranPlannerActivated => _isQuranPlannerActivated;

  void setBottomNav(int? value) {
    _navIndex = value ?? 0;
    notifyListeners();
  }

  void saveQuranPlannerStatus(bool? status) {
    if (status != null) {
      sharedPreferences!.setBool(AppString.quranPlaner, status);
      notifyListeners();
    }
  }

  void getQuranPlannerStatus() {
    _isQuranPlannerActivated =
        sharedPreferences!.getBool(AppString.quranPlaner) ?? false;
    notifyListeners();
  }

  void saveAuthStatus(bool? status, [String? number]) {
    if (status != null) {
      sharedPreferences!.setBool(AppString.auth, status);
      sharedPreferences!.setString(AppString.authNumber, number!);
      notifyListeners();
    } else {
      sharedPreferences!.setBool(AppString.auth, false);
      sharedPreferences!.setString(AppString.authNumber, '');
      notifyListeners();
    }
    _getAuthStatus();
  }

  void _getAuthStatus() {
    _authStatus = sharedPreferences!.getBool(AppString.auth) ?? false;
    _authNumber = sharedPreferences!.getString(AppString.authNumber) ?? '';
    notifyListeners();
  }
}
