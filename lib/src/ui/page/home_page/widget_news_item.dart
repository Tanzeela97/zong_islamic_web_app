import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/model/trending.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_icon_image.dart';

import 'home_detail_page.dart';

class TrendingSection extends StatefulWidget {
  final Trending trending;

  const TrendingSection({Key? key, required this.trending}) : super(key: key);

  @override
  State<TrendingSection> createState() => _TrendingSectionState();
}

class _TrendingSectionState extends State<TrendingSection> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.trending.data!.length,
        separatorBuilder: (context, index) => const WidgetDivider(
              indent: 18.0,
              endIndent: 18.0,
              thickness: 2.5,
            ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeDetailPage(
                            trending: widget.trending, index: index)));
              },
              leading: SizedBox(
                height: 250,
                width: 80,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    FadeInImage.assetNetwork(
                      placeholder: ImageResolver.placeHolderImage,
                      image: widget.trending.data![index].catImage!,
                      fit: BoxFit.cover,
                    ),
                    Icon(Icons.play_arrow_rounded,
                        color: AppColor.darkPink, size: 35)
                  ],
                ),
              ),
              title: Text(
                widget.trending.data![index].contentTitle!,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.black, overflow: TextOverflow.ellipsis),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.trending.data![index].contentDescEn!),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      WidgetIconImage(
                        iconOne: Icons.thumb_up_off_alt,
                        like: widget.trending.data![index].like,
                        share:widget.trending.data![index].share,
                        iconTwo: Icons.share,
                        page: widget.trending.page,
                        cateId: widget.trending.data![index].contentCatId,
                        contId: widget.trending.data![index].contentId,
                        isLiked: widget.trending.data![index].isLike,
                        isLikedByUser: (val) {

                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
enum enumUpdateLike{
  decrement,increment
}