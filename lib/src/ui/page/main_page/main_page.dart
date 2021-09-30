import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/home_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/notification_page/notification_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/profile_page/auth_wrapper.dart';
import 'package:zong_islamic_web_app/src/ui/page/profile_page/signin_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/search_page/search_page.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';

class MainPage extends StatefulWidget {
  final Widget? currentPage;

  const MainPage({Key? key, this.currentPage}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPage = 0;
  final List<Widget> pageList =  [];

  @override
  void initState() {
    pageList.add(const HomePage());
    pageList.add(const AuthWrapper());
    pageList.add(const NotificationPage());
    pageList.add(const SearchPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WidgetAppBar(
        title: 'Zong Islamic',
      ),
      body: IndexedStack(
        index: _selectedPage,
        children: pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
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
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }


}
