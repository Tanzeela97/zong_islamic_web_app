import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/cubit/auth_cubit/login/login_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/auth_cubit/otp/otp_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/cate_cubit/category_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_category/main_menu_category_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_trending/main_menu_trending_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/slider/slider_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/notification_cubit/notification_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/profile_cubit/profile_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/search_cubit/search_cubit.dart';
import 'package:zong_islamic_web_app/src/resource/repository/auth_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/cate_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/home_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/notification_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/profile_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/search_repository.dart';
import 'package:zong_islamic_web_app/src/resource/utility/category_enum.dart';
import 'package:zong_islamic_web_app/src/resource/utility/screen_arguments.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/category_by_id/category_detail_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/category_by_id/pillar_of_islam.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/category_by_id/quran_translation.dart';
import 'package:zong_islamic_web_app/src/ui/page/main_page/main_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/otp_verification.dart';
import 'package:zong_islamic_web_app/src/ui/page/signin_page.dart';

import 'my_app.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args;
    if (settings.arguments != null) {
      args = settings.arguments as ScreenArguments;
    } else {
      args = ScreenArguments();
    }
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
                          create: (context) =>
                              SliderCubit(HomeRepository.getInstance()!)),
                      BlocProvider<ProfileCubit>(
                          create: (context) =>
                              ProfileCubit(ProfileRepository.getInstance()!)),
                      BlocProvider<NotificationCubit>(
                          create: (context) => NotificationCubit(
                              NotificationRepository.getInstance()!)),
                      BlocProvider<SearchCubit>(
                          create: (context) =>
                              SearchCubit(SearchRepository.getInstance()!)),
                      BlocProvider<LoginCubit>(
                          create: (context) =>
                              LoginCubit(AuthRepository.getInstance()!)),
                      BlocProvider<CategoryCubit>(
                          create: (context) =>
                              CategoryCubit(CategoryRepository.getInstance()!)),
                    ],
                    child: const RouteAwareWidget(RouteString.initial,
                        child: MainPage())));
      case RouteString.categoryDetail:
        //category id;
        args.data as String;
        if (args.data != null) {
          switch (args.data) {
            case CategoryEnum.namazTracker: //namazTracker
              return _errorRoute();
            case CategoryEnum.pillarIslam: //pillar of Islam
              return MaterialPageRoute<PillarOfIslam>(
                  builder: (_) => BlocProvider.value(
                        value:
                            BlocProvider.of<CategoryCubit>(args.buildContext!),
                        child:  PillarOfIslam(args.data),
                      ));
            case CategoryEnum.quranTranslation: // Quran and Translation
              return MaterialPageRoute<QuranAndTranslation>(
                builder: (context)=>const QuranAndTranslation();
              );
            default:
              return MaterialPageRoute<CategoryDetailPage>(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<CategoryCubit>(args.buildContext!),
                  child: CategoryDetailPage(args.data),
                ),
              );
          }
        } else {
          return _errorRoute();
        }
      case RouteString.signIn:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider<LoginCubit>(
                          create: (context) =>
                              LoginCubit(AuthRepository.getInstance()!)),
                    ],
                    child: const RouteAwareWidget(RouteString.signIn,
                        child: SignInPage())));
      case RouteString.otp:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider<OtpCubit>(
                          create: (context) =>
                              OtpCubit(AuthRepository.getInstance()!)),
                    ],
                    child: const RouteAwareWidget(RouteString.otp,
                        child: OTPPage())));
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
  static const String categoryDetail = 'categoryDetail';
  static const String signIn = 'signIn';
  static const String otp = 'otp';
}
