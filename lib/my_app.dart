import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zong_islamic_web_app/route_generator.dart';
import 'package:zong_islamic_web_app/src/geo_location/geo_location.dart';
import 'package:zong_islamic_web_app/src/resource/repository/location_repository.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_theme.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_utility.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/namaz_provider/namaz_provider.dart';

import 'app_localizations.dart';

class MyApp extends StatefulWidget {
  final SharedPreferences _preferences;

  const MyApp(this._preferences, {Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // bool isTokenAvailable = false;
  late StreamSubscription streamSubscription;

  @override
  void initState() {
    // checkTokenStatus();
    scheduleMicrotask(() {
      precacheImage(ImageResolver.scaffoldBackGround, context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppUtility>(create: (context) => AppUtility()),

        // ChangeNotifierProvider<CalenderProvider>(
        //     create: (context) => CalenderProvider()),
        ChangeNotifierProvider(
            create: (context) => NamazData(widget._preferences)),
        // FutureProvider<SharedPreferences?>(
        //     lazy: false,
        //     create: (context) => SharedPreferences.getInstance(),
        //     initialData: null),
        // ProxyProvider<SharedPreferences?,NamazData>(
        //   update: (context,prefs,namaz)=>NamazData(prefs),
        // ),
        // Provider<LocationRepository>(create: (context) => LocationRepository(),lazy: false),
        // ChangeNotifierProxyProvider<LocationRepository, GeoLocationProvider>(
        //    // lazy: false,
        //     create: (context) =>
        //         GeoLocationProvider(context.read<LocationRepository>()),
        //     update: (context, geoAccess, geoPro) =>
        //         GeoLocationProvider(geoAccess)),
        ChangeNotifierProvider(
            create: (context) => GeoLocationProvider(LocationRepository())),
        // ChangeNotifierProxyProvider<SharedPreferences?, StoredAuthStatus>(
        //   create: (context) =>
        //       StoredAuthStatus(),
        //   update: (context, pref, auth) => StoredAuthStatus(),
        // ),
        ChangeNotifierProvider<StoredAuthStatus>(
            create: (context) => StoredAuthStatus())
      ],
      child: MaterialApp(
        theme: AppTheme.zongTheme,
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
        initialRoute: RouteString.initial,
        //home: LocalNotification(),
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
        routes: {},
        navigatorObservers: [
          RouteObservers.routeObserver,
        ],
      ),
    );
    // if (isTokenAvailable) {
    //   return MultiProvider(
    //     providers: [
    //       ChangeNotifierProvider<AppUtility>(create: (context) => AppUtility()),
    //
    //       // ChangeNotifierProvider<CalenderProvider>(
    //       //     create: (context) => CalenderProvider()),
    //       ChangeNotifierProvider(
    //           create: (context) => NamazData(widget._preferences)),
    //       // FutureProvider<SharedPreferences?>(
    //       //     lazy: false,
    //       //     create: (context) => SharedPreferences.getInstance(),
    //       //     initialData: null),
    //       // ProxyProvider<SharedPreferences?,NamazData>(
    //       //   update: (context,prefs,namaz)=>NamazData(prefs),
    //       // ),
    //       // Provider<LocationRepository>(create: (context) => LocationRepository(),lazy: false),
    //       // ChangeNotifierProxyProvider<LocationRepository, GeoLocationProvider>(
    //       //    // lazy: false,
    //       //     create: (context) =>
    //       //         GeoLocationProvider(context.read<LocationRepository>()),
    //       //     update: (context, geoAccess, geoPro) =>
    //       //         GeoLocationProvider(geoAccess)),
    //       ChangeNotifierProvider(
    //           create: (context) => GeoLocationProvider(LocationRepository())),
    //       // ChangeNotifierProxyProvider<SharedPreferences?, StoredAuthStatus>(
    //       //   create: (context) =>
    //       //       StoredAuthStatus(),
    //       //   update: (context, pref, auth) => StoredAuthStatus(),
    //       // ),
    //       ChangeNotifierProvider<StoredAuthStatus>(
    //           create: (context) => StoredAuthStatus())
    //     ],
    //     child: MaterialApp(
    //       theme: AppTheme.zongTheme,
    //       debugShowCheckedModeBanner: false,
    //       builder: (context, widget) => ResponsiveWrapper.builder(
    //         BouncingScrollWrapper.builder(context, widget!),
    //         maxWidth: 1200,
    //         minWidth: 450,
    //         defaultScale: true,
    //         breakpoints: const [
    //           ResponsiveBreakpoint.resize(450, name: MOBILE),
    //           ResponsiveBreakpoint.autoScale(800, name: TABLET),
    //           ResponsiveBreakpoint.autoScale(1000, name: TABLET),
    //           ResponsiveBreakpoint.resize(1200, name: DESKTOP),
    //           ResponsiveBreakpoint.autoScale(2460, name: "4K"),
    //         ],
    //       ),
    //       locale:
    //           const Locale.fromSubtags(countryCode: 'US', languageCode: 'en'),
    //       initialRoute: RouteString.initial,
    //       //home: LocalNotification(),
    //       onGenerateRoute: RouteGenerator.generateRoute,
    //       supportedLocales: const [
    //         Locale('en', 'US'),
    //         Locale('ur', 'PK'),
    //       ],
    //       localizationsDelegates: const [
    //         AppLocalizations.delegate,
    //         GlobalMaterialLocalizations.delegate,
    //         GlobalWidgetsLocalizations.delegate,
    //       ],
    //       localeResolutionCallback: (locale, supportedLocales) {
    //         for (var supportedLocale in supportedLocales) {
    //           if (supportedLocale.languageCode == locale!.languageCode &&
    //               supportedLocale.countryCode == locale.countryCode) {
    //             return supportedLocale;
    //           }
    //         }
    //         // If the locale of the device is not supported, use the first one
    //         // from the list (English, in this case).
    //         return supportedLocales.first;
    //       },
    //       routes: {},
    //       navigatorObservers: [
    //         RouteObservers.routeObserver,
    //       ],
    //     ),
    //   );
    // } else {
    //   return Material(
    //       child: Center(child: CircularProgressIndicator()));
    // }
  }

// void checkTokenStatus() async {
//   String token = widget._preferences.getString(AppString.tokenStatus) ?? "";
//   print(token);
//   if (token.isEmpty) {
//     await AppUtility.getTokenStatus();
//     setState(() {
//       isTokenAvailable = true;
//     });
//   } else {
//     setState(() {
//       isTokenAvailable = true;
//     });
//   }
// }
}

class RouteObservers {
  RouteObservers._();

  static RouteObserver<void> routeObserver = RouteObserver<PageRoute>();
}

class RouteAwareWidget extends StatefulWidget {
  final String name;
  final Widget child;

  const RouteAwareWidget(this.name, {required this.child});

  @override
  State<RouteAwareWidget> createState() => RouteAwareWidgetState();
}

class RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware {
  @override
  void didChangeDependencies() {
    print(widget.name);
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
