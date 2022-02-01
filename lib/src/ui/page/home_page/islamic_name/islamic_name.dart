import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_list_view/flutter_list_view.dart';
import 'package:section_view/section_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zong_islamic_web_app/src/cubit/favourite_cubit/favourite_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/islamic_name_cubit/islamic_name_cubit.dart';
import 'package:zong_islamic_web_app/src/model/islamic_name.dart';
import 'package:zong_islamic_web_app/src/resource/repository/favourite_repository.dart';
import 'package:zong_islamic_web_app/src/resource/repository/islamic_name_repository.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/network_constants.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/islamic_name/name_model.dart';
import 'package:zong_islamic_web_app/src/ui/widget/error_text.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_empty_box.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';
import 'package:flash/flash.dart';

enum EnumTextController { boyName, GirlName }

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
  final IslamicNameCubit islamicNameCubit =
      IslamicNameCubit(IslamicNameRepository.getInstance()!);
  final IslamicNameCubit islamicNameCubitTwo =
      IslamicNameCubit(IslamicNameRepository.getInstance()!);

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
    islamicNameCubit.close();
    islamicNameCubitTwo.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const WidgetAppBar(title: 'Islamic Names'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //tabBar
          TabBar(
              controller: _tabController,
              tabs: myTabs,
              indicatorColor: AppColor.darkPink),
          trackIndexController < 2
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.0),
                  child: TextField(
                    controller:
                        EnumTextController.values[trackIndexController] ==
                                EnumTextController.boyName
                            ? _editingControllerBoy
                            : _editingControllerGirl,
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      hintText: search,
                      suffixIcon: Icon(Icons.search, color: AppColor.darkPink),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor.darkGreyTextColor, width: 3),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor.darkGreyTextColor, width: 3),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(height: 15),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              NameList(islamicNameCubit, true, _editingControllerBoy),
              NameList(islamicNameCubitTwo, false, _editingControllerGirl),
              const FavouriteList(),
            ]),
          ),
        ],
      ),
      // body: Column(
      //   children: [
      //     BlocBuilder<IslamicNameCubit,IslamicNameState>(
      //       bloc: islamicNameCubit,
      //       builder: (context,state){
      //         if(state is IslamicNameInitial)return const EmptySizedBox();
      //         if(state is IslamicNameLoading)return const WidgetLoading();
      //         if(state is IslamicNameLoaded)return  Text(state.islamicNameModel.data.first.z.first.name!);
      //         return const ErrorText();
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}

class NameList extends StatefulWidget {
  final TextEditingController editingController;
  final bool isBoy;
  final IslamicNameCubit bloc;

  const NameList(this.bloc, this.isBoy, this.editingController, {Key? key})
      : super(key: key);

  @override
  _NameListState createState() => _NameListState();
}

class _NameListState extends State<NameList>
    with AutomaticKeepAliveClientMixin {
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

  _loadCountry(List<Data> name) async {
    List<NameModel> data = [];
    name.first.a.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.b.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.c.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.d.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.e.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.f.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.g.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.h.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.i.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.j.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.k.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.l.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.m.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.n.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.o.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.p.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.q.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.r.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.s.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.t.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.u.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.v.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.w.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.x.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.y.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    name.first.z.forEach((element) {
      data.add(NameModel(
          name: element.name!,
          detail: element.meaning!,
          nameId: element.kwid!,
          isFavourite: element.isFavourite!));
    });
    _allCountries = data;
    setState(() {
      _countries = convertListToAlphaHeader(
          data, (item) => (item.name).substring(0, 1).toUpperCase());
    });
  }

  final FavouriteCubit favouriteCubit =
      FavouriteCubit(FavouriteRepository.getInstance()!);

  @override
  void initState() {
    print('NameList initialized');
    widget.editingController.addListener(_didSearch);
    widget.bloc.getIslamicName(
        widget.isBoy ? NetworkConstant.BOY_NAME : NetworkConstant.GIRL_NAME);

    super.initState();
  }

  @override
  void dispose() {
    print('NameList disposed');
    super.dispose();
  }

  static setEnumFavourite(EnumFavourite enumFavourite) =>
      enumFavourite == EnumFavourite.isNotFavourite;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        listener: (context, state) {
          if (state is IslamicNameLoaded) {
            _loadCountry(state.islamicNameModel.data);
          }
        },
        bloc: widget.bloc,
        builder: (context, state) {
          if (state is IslamicNameError) return const ErrorText();
          if (state is IslamicNameLoading) return const WidgetLoading();
          if (state is IslamicNameLoaded)
            return SectionView<AlphabetHeader<NameModel>, NameModel>(
              source: _countries,
              onFetchListData: (header) => header.items,
              headerBuilder: getDefaultHeaderBuilder((d) => d.alphabet),
              alphabetBuilder: getDefaultAlphabetBuilder((d) => d.alphabet),
              tipBuilder: getDefaultTipBuilder((d) => d.alphabet),
              itemBuilder:
                  (context, itemData, itemIndex, headerData, headerIndex) {
                return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: BlocBuilder<FavouriteCubit, FavouriteState>(
                        bloc: favouriteCubit,
                        builder: (context, state) {
                          return ListTile(
                            onTap: () async {
                              final Completer completer = Completer();
                              context.showBlockDialog(
                                  dismissCompleter: completer);
                              await favouriteCubit
                                  .setAndGetFavorite(
                                      itemData.nameId,
                                      setEnumFavourite(EnumFavourite
                                              .values[itemData.isFavourite])
                                          ? 1
                                          : 0)
                                  .then((value) {
                                completer.complete();
                                print('setState fav loaded');
                                if (setEnumFavourite(EnumFavourite
                                    .values[itemData.isFavourite])) {
                                  setState(() {
                                    itemData.isFavourite = 1;
                                  });
                                } else {
                                  setState(() {
                                    itemData.isFavourite = 0;
                                  });
                                }
                              });
                            },
                            onLongPress: () {
                              Share.share('${itemData.name}');
                            },
                            // leading:  Icon(Icons.share, color: AppColor.darkPink, size: 18),
                            trailing: Icon(
                              setEnumFavourite(EnumFavourite
                                      .values[itemData.isFavourite])
                                  ? Icons.star_border
                                  : Icons.star,
                              color: AppColor.darkPink,
                            ),
                            title: Text(itemData.name),
                            style: ListTileStyle.drawer,
                            subtitle: Text(itemData.detail),
                          );
                        }));
              },
            );
          return const ErrorText();
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

////////////////////////////////////////////

class FavouriteList extends StatefulWidget {
  const FavouriteList({Key? key}) : super(key: key);

  @override
  _FavouriteListState createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  final FavouriteCubit favouriteCubit =
      FavouriteCubit(FavouriteRepository.getInstance()!);

  @override
  void initState() {
    favouriteCubit.setAndGetFavorite();
    super.initState();
  }

  @override
  void dispose() {
    favouriteCubit.close();
    print('FavouriteList dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
        bloc: favouriteCubit,
        builder: (context, state) {
          if (state is FavouriteLoading) return const WidgetLoading();
          if (state is FavouriteLoaded) return buildItem(state.favoriteList);
          if (state is FavouriteError) return const ErrorText();
          return ErrorText();
        });
  }

  Widget buildItem(List<A> data) => ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: ListTile(
            // leading: Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Icon(Icons.star_border, color: AppColor.darkPink, size: 18),
            //     Icon(Icons.share, color: AppColor.darkPink, size: 18),
            //   ],
            // ),
            leading: IconButton(
                onPressed: () {
                  Share.share('${data[index].name!}');
                },
                icon: Icon(Icons.share, color: AppColor.darkPink, size: 18)),
            title: Text(data[index].name!),
            style: ListTileStyle.drawer,
            subtitle: Text(data[index].meaning!),
          )));
}

enum EnumFavourite { isNotFavourite, isFavorite }
