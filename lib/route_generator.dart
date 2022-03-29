import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/SpeechScreen.dart';
import 'package:zong_islamic_web_app/src/cubit/auth_cubit/login/login_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/auth_cubit/otp/otp_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/cate_cubit/category_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/city_cubit/city_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/list_category/list_category_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_category/main_menu_category_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_trending/main_menu_trending_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/slider/slider_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/notification_cubit/notification_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/profile_cubit/profile_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/search_cubit/search_cubit.dart';
import 'package:zong_islamic_web_app/src/resource/repository/auth_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/cate_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/city_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/home_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/notification_repository.dart';

import 'package:zong_islamic_web_app/src/resource/repository/profile_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/search_repository.dart';
import 'package:zong_islamic_web_app/src/resource/utility/category_enum.dart';
import 'package:zong_islamic_web_app/src/resource/utility/screen_arguments.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/category_by_id/category_detail_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/category_by_id/pillar_of_islam.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/category_by_id/quran_and_translation/quran_translation.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/namaz_tracker.dart';
import 'package:zong_islamic_web_app/src/ui/page/main_page/main_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/mufti_view/four_content_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/mufti_view/live_mufti_streaming.dart';
import 'package:zong_islamic_web_app/src/ui/page/mufti_view/mufti_view.dart';

import 'package:zong_islamic_web_app/src/ui/page/otp_verification.dart';
import 'package:zong_islamic_web_app/src/ui/page/prayerInfo_page/prayer_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/quran_planner/quran_planner_view.dart';
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
    //final args = settings.arguments as ScreenArguments;
    switch (settings.name) {
      case RouteString.initial:
        //return MaterialPageRoute(builder: (_)=>const QuranPlanner());
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
                      BlocProvider<ListCategoryCubit>(
                          create: (context) =>
                              ListCategoryCubit(HomeRepository.getInstance()!)),
                    ],
                    child: RouteAwareWidget(RouteString.initial,
                        child: MainPage())));
      case RouteString.prayer:
        if (true) {
          return MaterialPageRoute<PrayerInfoPage>(
            builder: (_) => BlocProvider.value(
              value: BlocProvider.of<SliderCubit>(args.buildContext!),
              child: PrayerInfoPage(
                date: args.data,
              ),
            ),
          );

          return MaterialPageRoute(
              builder: (_) => BlocProvider<CityCubit>(
                    create: (context) =>
                        CityCubit(CityRepository.getInstance()!),
                    child: const RouteAwareWidget(RouteString.prayer,
                        child: PrayerInfoPage(
                          date: [],
                        )),
                  ));
        } else {
          return _errorRoute();
        }
      case RouteString.categoryDetail:
        //category id;

        args.data as String;
        args.secondData as String;
        print(args.data);
        print(args.secondData);
        if (args.data != null) {
          switch (args.data) {
            case CategoryEnum.namazTracker: //namazTracker
              return MaterialPageRoute<PillarOfIslam>(
                  builder: (_) => BlocProvider.value(
                        value:
                            BlocProvider.of<CategoryCubit>(args.buildContext!),
                        child: NamazTracker(),
                      ));
            case CategoryEnum.pillarIslam: //pillar of Islam
              return MaterialPageRoute<PillarOfIslam>(
                  builder: (_) => BlocProvider.value(
                        value:
                            BlocProvider.of<CategoryCubit>(args.buildContext!),
                        child: PillarOfIslam(args.data, args.secondData),
                      ));
            case CategoryEnum.quranTranslation: // Quran and Translation
              return MaterialPageRoute<QuranAndTranslation>(
                builder: (context) => BlocProvider.value(
                    value: BlocProvider.of<CategoryCubit>(args.buildContext!),
                    child: QuranAndTranslation(args.data, args.secondData)),
              );
            default:
              return MaterialPageRoute<CategoryDetailPage>(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<CategoryCubit>(args.buildContext!),
                  child: CategoryDetailPage(args.data, args.secondData),
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
                    child: RouteAwareWidget(RouteString.signIn,
                        child: SignInPage(
                          isFromNotification: args.flag,
                          categoryId: args.data,
                        ))));
      case RouteString.otp:
        print(args.message);
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider<CategoryCubit>(
                          create: (context) =>
                              CategoryCubit(CategoryRepository.getInstance()!)),
                      BlocProvider<OtpCubit>(
                          create: (context) =>
                              OtpCubit(AuthRepository.getInstance()!)),
                    ],
                    child: RouteAwareWidget(RouteString.otp,
                        child: OTPPage(
                          args.message!,
                          categoryId: args.data!,
                          isFromNotification: args.flag!,
                        ))));
      case RouteString.namazTracker:
        return MaterialPageRoute(
            builder: (_) => const RouteAwareWidget(RouteString.namazTracker,
                child: NamazTracker()));
      case RouteString.quranPlanner:
        return MaterialPageRoute(
            builder: (_) => RouteAwareWidget(RouteString.quranPlanner,
                child: const QuranPlanner()));
      case RouteString.liveStreaming:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider<ListCategoryCubit>(
                          create: (context) =>
                              ListCategoryCubit(HomeRepository.getInstance()!)),
                    ],
                    child: RouteAwareWidget(RouteString.liveStreaming,
                        child: LiveMuftiStreaming(url: args.message!))));
      case RouteString.mufti:
        return MaterialPageRoute(
            builder: (_) =>
                RouteAwareWidget(RouteString.mufti, child: MuftiView()));
      case RouteString.fourcontent:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider<ListCategoryCubit>(
                          create: (context) =>
                              ListCategoryCubit(HomeRepository.getInstance()!)),
                    ],
                    child: RouteAwareWidget(RouteString.fourcontent,
                        child: FourContentPage())));
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
  const RouteString._();

  static const String namazTracker = 'namazTracker';
  static const String initial = '/';
  static const String categoryDetail = 'categoryDetail';
  static const String signIn = 'signIn';
  static const String otp = 'otp';
  static const String prayer = 'prayer';
  static const String quranPlanner = 'quranPlanner';
  static const String mufti = 'mufti';
  static const String liveStreaming = 'liveStreaming';
  static const String fourcontent = 'fourContent';
}
