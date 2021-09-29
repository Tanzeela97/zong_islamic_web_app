import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_category/main_menu_category_cubit.dart';
import 'package:zong_islamic_web_app/src/resource/repository/home_repository.dart';
import 'package:zong_islamic_web_app/src/ui/constant/constant.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/home_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case RouteString.initial:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider<MainMenuCategoryCubit>(
                      create: (context) =>
                          MainMenuCategoryCubit(HomeRepository())),
                ], child: const HomePage()));
      case '/second':
        // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => SecondPage(
              data: args,
            ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
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

class SecondPage extends StatelessWidget {
  final String data;

  const SecondPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(data),
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

class ScreenArguments<T> {
  final int? tab;
  final Widget? currentPage;
  final String? message;
  final bool? flag;
  final T? data;
  final T? secondData;
  final BuildContext? buildContext;

  ScreenArguments(
      {this.tab,
      this.currentPage,
      this.message,
      this.data,
      this.secondData,
      this.flag,
      this.buildContext});
}
