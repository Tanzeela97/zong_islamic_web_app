import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/model/trending.dart';
import 'package:zong_islamic_web_app/src/ui/widget/video_detail_page.dart';

class HomeDetailPage extends StatelessWidget {
  final Trending trending;
  final int index;

  const HomeDetailPage({Key? key, required this.trending, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VideoDetailPage(trending: trending.data!, index: index);
  }
}
