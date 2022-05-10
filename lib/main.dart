//@dart=2.9
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zong_islamic_web_app/my_app.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  final _pref = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAosJcDBj8T31BgfRAQJ7_XvGcTEKVLuhs",
          authDomain: "zong-islamic-web-flutter.firebaseapp.com",
          projectId: "zong-islamic-web-flutter",
          storageBucket: "zong-islamic-web-flutter.appspot.com",
          messagingSenderId: "867365408352",
          appId: "1:867365408352:web:18cc7bad8175165cf4bd05",
          measurementId: "G-JYCP5ZSQK1"
      ));


  runApp( MyApp(_pref));
}
