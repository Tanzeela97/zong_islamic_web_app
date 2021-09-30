import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/ui/page/profile_page/profile_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/profile_page/signin_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return false?const ProfilePage():const SignInPage();
  }
}
