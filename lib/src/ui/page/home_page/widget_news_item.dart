
import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/model/trending.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/ui/widget/video_detail_page.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_icon_image.dart';

import 'home_detail_page.dart';

class TrendingSection extends StatefulWidget {
  final Trending trending;
  final String catName;

  const TrendingSection(
      {Key? key, required this.trending, required this.catName})
      : super(key: key);

  @override
  State<TrendingSection> createState() => _TrendingSectionState();
}

class _TrendingSectionState extends State<TrendingSection> {
  late final PageController controller;

  @override
  void initState() {
    controller = PageController(viewportFraction: 0.34, initialPage: 0);
    controller.addListener(listenToChanges);
    super.initState();
  }

  ValueNotifier<int> highlight = ValueNotifier(1);

  void listenToChanges() {}

  @override
  void dispose() {
    controller.dispose();
    highlight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
          child: Row(
            children: [
              Text(widget.catName.toUpperCase(),
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColor.blackTextColor)),
              const Spacer(),

            ],
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          height: 150,
          child: PageView.builder(
              onPageChanged: (val) {
                setState(() {
                  highlight.value = val + 1;
                });
              },
              padEnds: false,
              controller: controller,
              itemCount: widget.trending.data!.length,
              itemBuilder: (_, index) {
                // return Align(
                //   child: Container(
                //     color: highlight.value==index?Colors.amber:Colors.red,
                //     height: highlight.value==index?100:80,
                //     margin: const EdgeInsets.symmetric(horizontal: 2.0),
                //   ),
                // );
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoDetailPage(
                                trending: widget.trending.data!,
                                index: index)));
                  },
                  child: Align(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: highlight.value == index ? 0 : 10),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: SizedBox(
                              height: highlight.value == index ? 120 : 90,
                              child: Image.network(
                                widget.trending.data![index].catImage!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, obj, trace) =>
                                    Image(image: ImageResolver.fourZeroFour),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            widget.trending.data![index].contentCatTitle!,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontSize: 16,fontWeight: highlight.value == index?FontWeight.bold:null),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
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
                        share: widget.trending.data![index].share,
                        iconTwo: Icons.share,
                        page: widget.trending.page,
                        cateId: widget.trending.data![index].contentCatId,
                        contId: widget.trending.data![index].contentId,
                        isLiked: widget.trending.data![index].isLike,
                        isLikedByUser: (val) {},
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

enum enumUpdateLike { decrement, increment }
