import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/cubit/cate_cubit/category_cubit.dart';

import 'package:zong_islamic_web_app/src/model/news.dart';
import 'package:zong_islamic_web_app/src/ui/widget/error_text.dart';

import 'package:zong_islamic_web_app/src/ui/widget/trending_text.dart';
import 'package:zong_islamic_web_app/src/ui/widget/video_detail_page.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_empty_box.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_video_tile.dart';

class CategoryDetailPage extends StatefulWidget {
  final String contendId;

  const CategoryDetailPage(this.contendId, {Key? key}) : super(key: key);

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  void initState() {
    BlocProvider.of<CategoryCubit>(context).getCategoryById(widget.contendId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WidgetAppBar(
        title: 'Islam',
      ),
      body:
          BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
            if(state is CategoryInitial) {
              return const EmptySizedBox();
            }else if (state is CategoryLoadingState) {
              return const WidgetLoading();
            } else if (state is CategorySuccessState) {
              return _CategoryDetailPage(state.category!.vod!.data!);
            } else if (state is CategoryErrorState) {
              return Text(state.message!);
            } else {
              return const ErrorText();
        }
      }),
    );
  }
}

class _CategoryDetailPage extends StatelessWidget {
  final List<News> news;

  const _CategoryDetailPage(this.news, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          const TrendingText(),
          const SizedBox(height: 10),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoDetailPage(
                                  trending: news, index: index)));
                    },
                    child: VideoListTile(
                      shares: '0',
                      likes: '0',
                      contentTitle: news[index].contentTitle!,
                      contentSubTitle: news[index].contentCatTitle!,
                      imgUrl: news[index].catImage!,
                      highlight: false,
                    ),
                  ),
              separatorBuilder: (context, index) =>
                  const WidgetDivider(thickness: 2),
              itemCount: news.length),
        ])),
      ],
    );
  }
}
