import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/injection_container.dart';
import 'package:zong_islamic_web_app/my_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

