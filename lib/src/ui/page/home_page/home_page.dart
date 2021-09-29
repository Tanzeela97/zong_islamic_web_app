import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_category/main_menu_category_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_trending/main_menu_trending_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/slider/slider_cubit.dart';
import 'package:zong_islamic_web_app/src/ui/widget/app_appbar.dart';

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
    BlocProvider.of<SliderCubit>(context).getSlider();
    BlocProvider.of<MainMenuTrendingCubit>(context).getTrendingNews();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        // child: Text(AppLocalizations.of(context)!.translate('coronavirus')!),
        child: BlocBuilder<MainMenuCategoryCubit, MainMenuCategoryState>(
          builder: (context, state) {
            if (state is InitialMainMenuCategoryState) {
              return const Text('initial');
            } else if (state is MainMenuCategoryLoadingState) {
              return const Text('loading');
            } else if (state is MainMenuCategorySuccessState) {
              return const Text('success');
            } else if (state is MainMenuCategoryErrorState) {
              return Text(state.message!);
            }else if (state is MainMenuCategorySuccessState) {
              return  Text(state.mainMenuCategoryList![0].title);
            }else if (state is MainMenuCategoryErrorState) {
              return  const Text('error');
            }else{

              return const Text('lol');
            }
          },
        ),
      ),
    );
  }
}
