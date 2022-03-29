import 'package:better_player/better_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:zong_islamic_web_app/src/model/news.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/youtube_app_demo.dart';

class LiveMuftiStreaming extends StatefulWidget {
  final String url;

  const LiveMuftiStreaming({Key? key, required this.url}) : super(key: key);

  @override
  State<LiveMuftiStreaming> createState() => _LiveMuftiStreaming();
}

class _LiveMuftiStreaming extends State<LiveMuftiStreaming> {
  late final YoutubePlayerController controller;
  late int currentIndex;
  bool? isMp4 = false;
  String? video;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayerController.convertUrlToId(widget.url)!,
      params: const YoutubePlayerParams(
        showControls: true,
        autoPlay: true,
        showFullscreenButton: true,
      ),
    );
    controller.load(YoutubePlayerController.convertUrlToId(widget.url)!);
    // currentIndex = widget.index;
    // isMp4 = widget.trending[widget.index].catVideo!.endsWith(".mp4");
    // if (isMp4!) {
    //   video = widget.trending[widget.index].catVideo!;
    // } else {
    //   controller = YoutubePlayerController(
    //     initialVideoId: YoutubePlayerController.convertUrlToId(widget.url)!,
    //     params: const YoutubePlayerParams(
    //       showControls: true,
    //       autoPlay: true,
    //       showFullscreenButton: true,
    //     ),
    //   );
    //   controller.load(YoutubePlayerController.convertUrlToId(widget.url)!);
    //       // controller = YoutubePlayerController(
    //       //     initialVideoId: YoutubePlayerController.convertUrlToId(
    //       //         widget.trending[widget.index].catVideo!)!);
    //   }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        title: "Mufti Live",
      ),
      body: SafeArea(
        child: Column(children: [
          isMp4!
              ? BetterPlayer.network(
                  video!,
                  betterPlayerConfiguration: const BetterPlayerConfiguration(
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                  ),
                )
              : YoutubeAppDemo(
                  videoUrl: widget.url,
                  controller: controller,
                ),
          Container(
            margin: EdgeInsets.zero,
            color: Colors.grey[400],
            height: 80,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('blah blah blah!',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis)),
                SizedBox(height: 5),
                Text('blah blah blah!'),
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    Text('YouTube Credits: ITGN',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
