import 'package:flutter/material.dart';
import 'package:flutter_list_view/flutter_list_view.dart';
import 'package:section_view/section_view.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/islamic_name/name_model.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';

enum EnumTextController { boyName, GirlName}

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
  late final TextEditingController _editingControllerBoy;
  late final TextEditingController _editingControllerGirl;
  static int trackIndexController = 0;

  @override
  void initState() {
    _tabController =
        TabController(vsync: this, length: myTabs.length, initialIndex: 0)
          ..addListener(() {
            setState(() {
              trackIndexController = _tabController.index;
            });
          });
    _editingControllerBoy = TextEditingController();
    _editingControllerGirl = TextEditingController();
    print('init call IslamicName');
    super.initState();
  }

  @override
  void dispose() {
    print('disposed call IslamicName');
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
          trackIndexController<2?Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.0),
            child: TextField(
              controller: EnumTextController.values[trackIndexController] ==
                      EnumTextController.boyName
                  ? _editingControllerBoy
                  : _editingControllerGirl,
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
          ):SizedBox(),
          SizedBox(height: 15),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              NameList(_editingControllerBoy),
              NameList(_editingControllerGirl),
              const Text("User Body"),
            ]),
          ),
        ],
      ),
    );
  }
}

class NameList extends StatefulWidget {
  final TextEditingController editingController;

  const NameList(this.editingController, {Key? key}) : super(key: key);

  @override
  _NameListState createState() => _NameListState();
}

class _NameListState extends State<NameList> {
  List<AlphabetHeader<NameModel>> _countries = [];
  List<NameModel> _allCountries = [];

  _constructAlphabet(Iterable<NameModel> data) {
    List<AlphabetHeader<NameModel>> _countriesData =
        convertListToAlphaHeader<NameModel>(
            data, (item) => (item.name).substring(0, 1).toUpperCase());
    if (mounted)
    setState(() {

      _countries = _countriesData;
    });
  }

  _didSearch() {
    var keyword = widget.editingController.text.trim().toLowerCase();
    var filterCountries = _allCountries
        .where((item) => item.name.toLowerCase().contains(keyword));
    _constructAlphabet(filterCountries);
  }

  _loadCountry() async {
    var data = await loadCountriesFromAsset();
    _allCountries = data;
    setState(() {
      _countries = convertListToAlphaHeader(
          data, (item) => (item.name).substring(0, 1).toUpperCase());
    });
  }

  @override
  void initState() {
    print('NameList initialized');

    widget.editingController.addListener(_didSearch);
    _loadCountry();
    super.initState();
  }

  @override
  void dispose() {
    print('NameList disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionView<AlphabetHeader<NameModel>, NameModel>(
      source: _countries,
      onFetchListData: (header) => header.items,
      headerBuilder: getDefaultHeaderBuilder((d) => d.alphabet),
      alphabetBuilder: getDefaultAlphabetBuilder((d) => d.alphabet),
      tipBuilder: getDefaultTipBuilder((d) => d.alphabet),
      itemBuilder: (context, itemData, itemIndex, headerData, headerIndex) {
        return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 Icon(Icons.star_border,color: AppColor.darkPink,size: 18),
                  Icon(Icons.share,color: AppColor.darkPink,size: 18),
                ],
              ),

              title: Text(itemData.name),
              style: ListTileStyle.drawer,
              subtitle: Text('Non Fungible Token'),
            ));
      },
    );
  }
}
