import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_category/main_menu_category_cubit.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/category_section.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/current_detail_section.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_trending/main_menu_trending_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/slider/slider_cubit.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/widget_news_item.dart';


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
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          BlocBuilder<SliderCubit, SliderState>(
            builder: (context, state) {
              if (state is SliderInitial) {
                return const Text('initial');
              } else if (state is SliderLoadingState) {
                return Center(child: const Text('loading'));
              } else if (state is SliderSuccessState) {
                return CurrentDetailSection(
                  backGroundImage: state.slider!.first.sliderImage!,
                );
              } else if (state is SliderErrorState) {
                return Text("state.message!");
              } else {
                return const Text('lol');
              }
            },
          ),
          BlocBuilder<MainMenuCategoryCubit, MainMenuCategoryState>(
            builder: (context, state) {
              if (state is InitialMainMenuCategoryState) {
                return const Text('initial');
              } else if (state is MainMenuCategoryLoadingState) {
                return Center(child: const Text('loading'));
              } else if (state is MainMenuCategorySuccessState) {
                return CategorySection(category: state.mainMenuCategoryList!);
              } else if (state is MainMenuCategoryErrorState) {
                return Text('error');
              } else {
                return const Text('lol');
              }
            },
          ),
          const _TrendingText(),
          BlocBuilder<MainMenuTrendingCubit, MainMenuTrendingState>(
            builder: (context, state) {
              if (state is MainMenuTrendingInitial) {
                return const Text('initial');
              } else if (state is MainMenuTrendingLoadingState) {
                return Center(child: const Text('Loading'));
              } else if (state is MainMenuTrendingSuccessState) {
                return TrendingSection(trending: state.trending!);
              } else if (state is MainMenuTrendingErrorState) {
                return Text("state.message!");
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

class _TrendingText extends StatelessWidget {
  const _TrendingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Center(
          child: Text('TRENDING',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(letterSpacing: 1, color: Colors.pink))),
    );
  }
}
