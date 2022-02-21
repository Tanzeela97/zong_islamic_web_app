import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/model/news.dart';
import 'package:zong_islamic_web_app/src/ui/widget/video_detail_page.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_video_tile.dart';

class ParaWisePage extends StatelessWidget {
  final List<News> news;

  const ParaWisePage(this.news, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoDetailPage(
                            appBar: true, trending: news, index: index)));
              },
              child: VideoListTileTwo(
                //todo page and like update
                shares: news[index].share!,
                likes: news[index].like!,
                contentTitle: news[index].contentTitle!,
                contentSubTitle: news[index].contentCatTitle!,
                imgUrl: news[index].catImage!,
                highlight: false,
                isLiked: news[index].isLike!,
                page: '',
                contId: news[index].contentId!,
                isLikedByUser: (int val) {},
                cateId: news[index].contentCatId!,
              ),
            ),
        separatorBuilder: (context, index) => const WidgetDivider(thickness: 2),
        itemCount: news.length);
  }
}
