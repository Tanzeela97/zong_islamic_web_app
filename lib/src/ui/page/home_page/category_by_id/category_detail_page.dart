import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/cubit/cate_cubit/category_cubit.dart';
import 'package:zong_islamic_web_app/src/model/news.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
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
  final String number;

  const CategoryDetailPage(this.contendId, this.number, {Key? key})
      : super(key: key);

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  void initState() {
    BlocProvider.of<CategoryCubit>(context)
        .getCategoryById(widget.contendId, widget.number);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
        if (state is CategoryInitial) {
          return const EmptySizedBox();
        } else if (state is CategoryLoadingState) {
          return const WidgetLoading();
        } else if (state is CategorySuccessState) {
          print(state.category!.title!);
          return _CategoryDetailPage(state.category!.vod!.data!,
              title: state.category!.title!);
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
  final String title;

  const _CategoryDetailPage(this.news, {Key? key, this.title = 'Islam'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        title: title,
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: EdgeInsets.only(left: 14.0),
              child: Row(
                children: [
                  const Align(
                    child: TrendingText(),
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      height: 5,
                      width: 200,
                      color: AppColor.darkPink,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VideoDetailPage(
                                    trending: news, index: index)));
                      },
                      child: VideoListTileTwo(
                        //todo update page and update like
                        shares: news[index].share!,
                        likes: news[index].like!,
                        contentTitle: news[index].contentTitle!,
                        contentSubTitle: news[index].contentCatTitle!,
                        imgUrl: news[index].catImage!,
                        highlight: false,
                        isLiked: news[index].isLike!,
                        contId: news[index].contentId!,
                        isLikedByUser: (int val) {},
                        cateId: news[index].contentCatId!,
                        page: '',
                      ),
                    ),
                separatorBuilder: (context, index) =>
                    const WidgetDivider(thickness: 2),
                itemCount: news.length),
          ])),
        ],
      ),
    );
  }
}
