import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/cubit/auth_cubit/login/login_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_category/main_menu_category_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_trending/main_menu_trending_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/slider/slider_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/notification_cubit/notification_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/profile_cubit/profile_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/search_cubit/search_cubit.dart';
import 'package:zong_islamic_web_app/src/resource/repository/auth_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/home_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/notification_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/profile_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/search_repository.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/home_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/main_page/main_page.dart';

import 'my_app.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteString.initial:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider<MainMenuCategoryCubit>(
                          create: (context) => MainMenuCategoryCubit(
                              HomeRepository.getInstance()!)),
                      BlocProvider<MainMenuTrendingCubit>(
                          create: (context) => MainMenuTrendingCubit(
                              HomeRepository.getInstance()!)),
                      BlocProvider<SliderCubit>(
                          create: (context) => SliderCubit(
                              HomeRepository.getInstance()!)),
                      BlocProvider<ProfileCubit>(
                          create: (context) => ProfileCubit(
                              ProfileRepository.getInstance()!)),
                      BlocProvider<NotificationCubit>(
                          create: (context) => NotificationCubit(
                              NotificationRepository.getInstance()!)),
                      BlocProvider<SearchCubit>(
                          create: (context) => SearchCubit(
                              SearchRepository.getInstance()!)),
                      BlocProvider<LoginCubit>(
                          create: (context) => LoginCubit(
                              AuthRepository.getInstance()!)),
                    ],
                    child: RouteAwareWidget(RouteString.initial,
                        child:  const MainPage())));
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

class RouteString {
  static const String initial = '/';
}
