import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_category/main_menu_category_cubit.dart';

import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/category_section.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/current_detail_section.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';

import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_trending/main_menu_trending_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/slider/slider_cubit.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_news_item.dart';


import '../../../../app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MainMenuCategoryCubit>(context).getMenuCategories();
    BlocProvider.of<MainMenuTrendingCubit>(context).getTrendingNews();
    BlocProvider.of<SliderCubit>(context).getSlider();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // child: Text(AppLocalizations.of(context)!.translate('coronavirus')!),
      child: BlocBuilder<MainMenuCategoryCubit, MainMenuCategoryState>(
        builder: (context, state) {
          if (state is InitialMainMenuCategoryState) {
            return const Text('initial');
          } else if (state is MainMenuCategoryLoadingState) {
            return const Text('loading');
          } else if (state is MainMenuCategorySuccessState) {
            return _Layout(category: state.mainMenuCategoryList!,);
          } else if (state is MainMenuCategoryErrorState) {
            return Text(state.message!);
          } else {
            return const Text('lol');
          }
        },
      ),
    );
  }
}


class _Layout extends StatelessWidget {
  final List<MainMenuCategory> category;

  const _Layout({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(delegate: SliverChildListDelegate([
          const CurrentDetailSection(),
          CategorySection(category: category),
          BlocBuilder<MainMenuTrendingCubit, MainMenuTrendingState>(
            builder: (context, state) {
              if (state is MainMenuTrendingInitial) {
                return const Text('initial');
              } else if (state is MainMenuTrendingSuccessState) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return WidgetNewsItem(newsItem: state.trending!
                        .data![index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 5,
                    );
                  },
                  itemCount: state.trending!
                      .data!.length,
                );
              } else if (state is MainMenuTrendingErrorState) {
                return Text(state.message!);
              } else {
                return const Text('lol');
              }
            },
          )

        ])),
      ],
    );
  }
}

