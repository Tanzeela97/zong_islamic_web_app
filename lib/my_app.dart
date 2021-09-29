import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zong_islamic_web_app/route_generator.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_category/main_menu_category_cubit.dart';
import 'package:zong_islamic_web_app/src/resource/repository/home_repository.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_config.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme:ThemeData(
      //   fontFamily: 'Roboto',
      //   primaryColor: Colors.white,
      //   scaffoldBackgroundColor: Color(0xFFFFFFFF),
      //   accentColor: AppColors(context).mainColor(1),
      //   focusColor: AppColors(context).accentColor(1),
      //   hintColor: AppColors.timberWolf,
      //   canvasColor: Colors.transparent,
      //   unselectedWidgetColor: AppColors(context).mainColor(1),
      //   elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(AppColors.greenColor)),
      //   ),
      //   textTheme: TextTheme(
      //     //used as drawer items
      //     headline1: TextStyle(
      //       fontWeight: FontWeight.w500,
      //       fontFamily: 'RobotoCondensed',
      //       fontSize: AppConfig.of(context).appWidth(5),
      //       // color: AppColors.black,
      //     ),
      //     //used as main headline items
      //     headline2: TextStyle(
      //       fontWeight: FontWeight.w500,
      //       fontFamily: 'RobotoCondensed',
      //       fontSize: AppConfig.of(context).appWidth(7),
      //     ),
      //     //used as item text 1
      //     headline3: TextStyle(
      //       fontFamily: 'RobotoCondensed',
      //       fontSize: AppConfig.of(context).appWidth(4),
      //       fontWeight: FontWeight.w600,
      //     ),
      //     //used as item text 2
      //     headline4: TextStyle(
      //       fontFamily: 'RobotoCondensed',
      //       fontSize: AppConfig.of(context).appWidth(4.3),
      //       fontWeight: FontWeight.w400,
      //     ),
      //     //used as item descriptio
      //     // n
      //     headline5: TextStyle(
      //       fontFamily: 'Roboto',
      //       fontSize: AppConfig.of(context).appWidth(3.2),
      //       fontWeight: FontWeight.w400,
      //     ),
      //     headline6: TextStyle(
      //       fontFamily: 'Roboto',
      //       fontSize: AppConfig.of(context).appWidth(5),
      //       fontWeight: FontWeight.w500,
      //       color: AppColors.black,
      //     ),
      //     subtitle1: TextStyle(
      //         fontSize: 25.0,
      //         fontWeight: FontWeight.w600,
      //         color: AppColors(context).mainColor(1)),
      //     subtitle2: TextStyle(
      //         fontFamily: 'RobotoCondensed',
      //         fontSize: AppConfig.of(context).appWidth(4.5),
      //         fontWeight: FontWeight.w300,
      //         color: AppColors(context).secondColor(0.7)),
      //     bodyText1: TextStyle(
      //         fontFamily: 'RobotoCondensed',
      //         fontSize: AppConfig.of(context).appWidth(5),
      //         fontWeight: FontWeight.w400,
      //         color: AppColors(context).secondColor(0.6)),
      //     bodyText2: TextStyle(
      //         fontWeight: FontWeight.w500,
      //         fontFamily: 'RobotoCondensed',
      //         fontSize: AppConfig.of(context).appWidth(4.2),
      //         color: AppColors(context).secondColor(1)),
      //   ),
      // ) ,
      debugShowCheckedModeBanner: false,
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
      ),
      locale: const Locale.fromSubtags(countryCode: 'US', languageCode: 'en'),
      initialRoute: RouteNames.INITIAL,
      onGenerateRoute: RouteGenerator.generateRoute,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ur', 'PK'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
      navigatorObservers: [
        RouteObservers.routeObserver,
      ],
    );
  }
}

class RouteObservers {
  static RouteObserver<void> routeObserver = RouteObserver<PageRoute>();
}

class RouteAwareWidget extends StatefulWidget {
  final String name;
  final Widget child;

  RouteAwareWidget(this.name, {required this.child});

  @override
  State<RouteAwareWidget> createState() => RouteAwareWidgetState();
}

class RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RouteObservers.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    RouteObservers.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {}

  @override
  // Called when the top route has been popped off, and the current route shows up.
  void didPopNext() {}

  @override
  Widget build(BuildContext context) => widget.child;
}
