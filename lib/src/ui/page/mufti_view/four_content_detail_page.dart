import 'package:better_player/better_player.dart';

import 'package:flutter/material.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:zong_islamic_web_app/src/model/news.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';

import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_video_tile.dart';
import 'package:zong_islamic_web_app/src/ui/widget/youtube_app_demo.dart';

class FourContentDetailPage extends StatefulWidget {
  final List<News> trending;
  final int index;
  final bool appBar;

  const FourContentDetailPage(
      {Key? key,
      required this.trending,
      required this.index,
      this.appBar = true})
      : super(key: key);

  @override
  State<FourContentDetailPage> createState() => _FourContentDetailPageState();
}

class _FourContentDetailPageState extends State<FourContentDetailPage> {
  late final YoutubePlayerController controller;
  late int currentIndex;
  bool? isMp4;
  String? video;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    currentIndex = widget.index;
    isMp4 = widget.trending[widget.index].catVideo!.endsWith(".mp4");
    if (isMp4!) {
      video = widget.trending[widget.index].catVideo!;
    } else {
      controller = YoutubePlayerController(
        initialVideoId: YoutubePlayerController.convertUrlToId(
            widget.trending[widget.index].catVideo!)!,
        params: const YoutubePlayerParams(
          showControls: true,
          autoPlay: true,
          showFullscreenButton: true,
        ),
      );
      controller.load(YoutubePlayerController.convertUrlToId(
          widget.trending[widget.index].catVideo!)!);
      // controller = YoutubePlayerController(
      //     initialVideoId: YoutubePlayerController.convertUrlToId(
      //         widget.trending[widget.index].catVideo!)!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar
          ? WidgetAppBar(
              title: widget.trending[currentIndex].contentCatTitle!,
            )
          : null,
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: isMp4!
                ? BetterPlayer.network(
                    video!,
                    betterPlayerConfiguration: const BetterPlayerConfiguration(
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                    ),
                  )
                : YoutubeAppDemo(
                    videoUrl: widget.trending[widget.index].catVideo!,
                    controller: controller,
                  ),
          ),
          Container(
            margin: EdgeInsets.zero,
            color: Colors.grey[50],
            height: 80,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(widget.trending[currentIndex].contentTitle!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            overflow: TextOverflow.ellipsis)),
                    SizedBox(height: 5),
                    Text(widget.trending[currentIndex].contentCatTitle!),
                  ],
                ),
                const Spacer(),
                ...[
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Image(image: ImageResolver.liveMufti, height: 75)),
                  SizedBox(width: 16.0),
                ],
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            flex: 2,
            child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const WidgetDivider(thickness: 2),
                itemBuilder: (context, index) => GestureDetector(
                      onTap: isMp4!
                          ? () {
                              setState(() {
                                currentIndex = index;
                                video = widget.trending[index].catVideo!;
                              });
                            }
                          : () {
                              setState(() {
                                currentIndex = index;
                                controller.load(
                                    YoutubePlayerController.convertUrlToId(
                                        widget.trending[index].catVideo!)!);
                              });
                            },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: VideoListTileTwo(
                          //todo page number and update like
                          highlight: currentIndex == index,
                          contentSubTitle:
                              widget.trending[index].contentCatTitle!,
                          contentTitle: widget.trending[index].contentTitle!,
                          likes: widget.trending[index].like ?? '',
                          shares: widget.trending[index].share ?? '',
                          imgUrl: widget.trending[index].catImage!,
                          cateId: widget.trending[index].contentCatId!,
                          contId: widget.trending[index].contentId!,
                          page: '',
                          isLikedByUser: (int val) {},
                          isLiked: widget.trending[index].isLike ?? '',
                        ),
                      ),
                    ),
                itemCount: widget.trending.length),
          )
        ]),
      ),
    );
  }
}
