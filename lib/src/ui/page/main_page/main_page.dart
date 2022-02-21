import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zong_islamic_web_app/route_generator.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/resource/utility/screen_arguments.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/home_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/islamic_name/islamic_name.dart';
import 'package:zong_islamic_web_app/src/ui/page/notification_page/notification_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/profile_page/profile_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/search_page/search_page.dart';
import 'package:zong_islamic_web_app/src/ui/widget/drawer_item.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';

class MainPage extends StatefulWidget {
  final Widget? currentPage;

  const MainPage({Key? key, this.currentPage}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPage = TabName.home.index;
  late final List<Widget> pageList = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    pageList.addAll(
        const [HomePage(), ProfilePage(), NotificationPage(), SearchPage()]);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _selectedPage = Provider.of<StoredAuthStatus>(context).navIndex;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('tanzeela $_selectedPage');
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Icon(
                  Icons.person,
                  size: 150,
                  color: Colors.pinkAccent,
                ),
              ),
              !Provider.of<StoredAuthStatus>(context).authStatus
                  ? const Text(
                      "Welcome",
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.start,
                    )
                  : Text(
                      Provider.of<StoredAuthStatus>(context, listen: false)
                          .authNumber,
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.start,
                    ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Divider(
                  height: 15,
                  color: Colors.grey,
                ),
              ),
              Column(
                children: [
                  Visibility(
                    visible: Provider.of<StoredAuthStatus>(context).authStatus,
                    child: DrawerItem(
                        text: "My Profile", enumOption: EnumAboutUs.MyProfile),
                  ),
                  DrawerItem(text: "About Us", enumOption: EnumAboutUs.about),
                  DrawerItem(
                      text: "Terms & Condition", enumOption: EnumAboutUs.term),
                  DrawerItem(
                      text: "Privacy Policy", enumOption: EnumAboutUs.policy),
                ],
              ),
            ],
          ),
        ),
      ),
      key: _scaffoldKey,
      appBar: WidgetAppBar(
        action: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteString.prayer,
                    arguments: ScreenArguments(buildContext: context));
              },
              icon: const Icon(Icons.location_on,
                  color: AppColor.whiteTextColor)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const IslamicName()));
              },
              icon: const Icon(Icons.phone, color: AppColor.whiteTextColor)),
        ],
        title: AppString.zongIslamic,
        scaffoldKey: _scaffoldKey,
      ),
      // body: SafeArea(
      //   child: IndexedStack(
      //     index: _selectedPage,
      //     children: pageList,
      //   ),
      // ),
      body: pageList.elementAt(_selectedPage),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.greenAppBarColor,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppColor.whiteTextColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
        ],
        currentIndex: _selectedPage,
        selectedItemColor: AppColor.pinkTextColor,
        onTap: (value) {
          if (Provider.of<StoredAuthStatus>(context, listen: false).authStatus ||
              value == TabName.home.index) {
            setState(() {
              _selectedPage = value;
            });
          } else {
            Navigator.pushNamed(context, RouteString.signIn);
          }
        },
      ),
    );
  }
}

enum TabName { home, profile, notification, search }
