import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/cubit/auth_cubit/login/login_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/notification_cubit/notification_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/profile_cubit/profile_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/search_cubit/search_cubit.dart';
import 'package:zong_islamic_web_app/src/resource/repository/auth_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/notification_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/profile_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/search_repository.dart';
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
    if (false) {
      if (currentPage == PageStatus.profile) {
        return BlocProvider(
            create: (context) => ProfileCubit(ProfileRepository.getInstance()!),
            child: const ProfilePage());
      } else if (currentPage == PageStatus.notification) {
        return BlocProvider(
            create: (context) => NotificationCubit(NotificationRepository.getInstance()!),
            child: const NotificationPage());
      } else if (currentPage == PageStatus.search) {
        return BlocProvider(
            create: (context) => SearchCubit(SearchRepository.getInstance()!),
            child: const SearchPage());
      } else {
        return BlocProvider(
            create: (context) => ProfileCubit(ProfileRepository.getInstance()!),
            child: const ProfilePage());
      }
    } else {
      return BlocProvider(
          create: (context) => LoginCubit(AuthRepository.getInstance()!),
          child: const SignInPage());
    }
  }
}

enum PageStatus { profile, notification, search }
