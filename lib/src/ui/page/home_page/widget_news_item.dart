import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/model/news.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_description_text.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_heading_text.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_icon_image.dart';

class WidgetNewsItem extends StatelessWidget {
  News? newsItem;

  WidgetNewsItem({this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            newsItem!.catImage!,
            height: 120,
            width: 120,
            fit: BoxFit.fill,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: WidgetHeadingText(text: newsItem!.contentTitle!),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: WidgetDescriptionText(text: newsItem!.contentDescEn!),
              ),
              Row(
                children: [
                  WidgetIconImage(
                    icon: Icons.pause,
                    text: "${newsItem!.like ?? ""} likes",
                  ),
                  const SizedBox(width: 10,),
                  WidgetIconImage(
                    icon: Icons.motion_photos_pause,
                    text: "${newsItem!.share ?? ""} shares",
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
