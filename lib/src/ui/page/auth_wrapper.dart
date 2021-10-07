import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:zong_islamic_web_app/src/cubit/auth_cubit/login/login_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/notification_cubit/notification_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/profile_cubit/profile_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/search_cubit/search_cubit.dart';
import 'package:zong_islamic_web_app/src/resource/repository/auth_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/notification_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/profile_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/search_repository.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/page/notification_page/notification_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/profile_page/profile_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/signin_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/search_page/search_page.dart';

import 'otp_verification.dart';

class AuthWrapper extends StatelessWidget {
  final PageStatus? currentPage;

  const AuthWrapper({Key? key, this.currentPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Provider.of<StoredAuthStatus>(context).authStatus) {
      if (currentPage == PageStatus.profile) {
        return const ProfilePage();
      } else if (currentPage == PageStatus.notification) {
        return const NotificationPage();
      } else if (currentPage == PageStatus.search) {
        return const SearchPage();
      } else {
        return const ProfilePage();
      }
    } else {
      return Provider.of<StoredAuthStatus>(context).otpToggle
          ? const OTPPage()
          : const SignInPage();
    }
  }
}

enum PageStatus { profile, notification, search }
