import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';

class name {
  String oib;

  name(this.oib);
}

class IslamicName extends StatefulWidget {
  const IslamicName({Key? key}) : super(key: key);

  @override
  State<IslamicName> createState() => _IslamicNameState();
}

class _IslamicNameState extends State<IslamicName>
    with SingleTickerProviderStateMixin {
  static const boyNames = 'Boy Names';
  static const girlNames = 'Girls Names';
  static const favorites = 'Favorites';
  static const search = 'Search....';

  static const List<Tab> myTabs = <Tab>[
    Tab(text: boyNames),
    Tab(text: girlNames),
    Tab(text: favorites),
  ];
  late final TabController _tabController;
  final List<name> ss = [name('Ali'), name('Ali'), name('Ali'), name('Ali')];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: myTabs.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WidgetAppBar(title: 'Islamic Names'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //tabBar
          TabBar(
              controller: _tabController,
              tabs: myTabs,
              indicatorColor: AppColor.darkPink),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: TextField(
              onChanged: (value) {},
              decoration: const InputDecoration(
                hintText: search,
                suffixIcon: Icon(Icons.search, color: AppColor.darkPink),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColor.darkGreyTextColor, width: 3),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColor.darkGreyTextColor, width: 3),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
            child: Text(
              'A',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          const WidgetDivider(thickness: 3.5, height: 0),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              AzListView(
                data: ss,
                itemCount: name.length,
                itemBuilder: (context, index) => ListTile(title: Text('')),
              ),
              const Text("Articles Body"),
              const Text("User Body"),
            ]),
          ),
        ],
      ),
    );
  }
}
