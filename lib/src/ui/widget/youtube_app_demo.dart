import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
class YoutubeAppDemo extends StatefulWidget {
  final String videoUrl;
  final YoutubePlayerController controller;

  const YoutubeAppDemo(
      {Key? key, required this.videoUrl, required this.controller})
      : super(key: key);

  @override
  _YoutubeAppDemoState createState() => _YoutubeAppDemoState();
}

class _YoutubeAppDemoState extends State<YoutubeAppDemo> {
  String? video;

  @override
  void initState() {
    super.initState();
    video = YoutubePlayerController.convertUrlToId(widget.videoUrl)!;
    widget.controller.play();
    widget.controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      print('Entered Fullscreen');
    };
    widget.controller.onExitFullscreen = () {
      print('Exited Fullscreen');
    };
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerControllerProvider(
      controller: widget.controller,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              SizedBox.expand(
                child: YoutubePlayerIFrame(
                    controller: widget.controller, aspectRatio: 16 / 9),
              ),
              Positioned.fill(
                child: YoutubeValueBuilder(
                  controller: widget.controller,
                  builder: (context, value) {
                    return AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: Material(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                YoutubePlayerController.getThumbnail(
                                  videoId: video!,
                                  quality: ThumbnailQuality.medium,
                                ),
                              ),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      crossFadeState: value.isReady
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                ),
              ),
            ],
          );
          // return ListView(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   children: [
          //     Stack(
          //       children: [
          //         YoutubePlayerIFrame(controller: controller, aspectRatio: 16 / 9),
          //         Positioned.fill(
          //           child: YoutubeValueBuilder(
          //             controller: controller,
          //             builder: (context, value) {
          //               return AnimatedCrossFade(
          //                 firstChild: const SizedBox.shrink(),
          //                 secondChild: Material(
          //                   child: DecoratedBox(
          //                     decoration: BoxDecoration(
          //                       image: DecorationImage(
          //                         image: NetworkImage(
          //                           YoutubePlayerController.getThumbnail(
          //                             videoId: YoutubePlayerController.convertUrlToId(widget.url)!,
          //                             quality: ThumbnailQuality.medium,
          //                           ),
          //                         ),
          //                         fit: BoxFit.fitWidth,
          //                       ),
          //                     ),
          //                     child: const Center(
          //                       child: CircularProgressIndicator(),
          //                     ),
          //                   ),
          //                 ),
          //                 crossFadeState: value.isReady
          //                     ? CrossFadeState.showFirst
          //                     : CrossFadeState.showSecond,
          //                 duration: const Duration(milliseconds: 300),
          //               );
          //             },
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // );
        },
      ),
    );
    // const player = YoutubePlayerIFrame();
    // return YoutubePlayerControllerProvider(
    //   // Passing controller to widgets below.
    //   controller: widget.controller,
    //   child: Scaffold(
    //     body: LayoutBuilder(
    //       builder: (context, constraints) {
    //         if (kIsWeb && constraints.maxWidth > 800) {
    //           return Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: const [
    //               Expanded(child: player),
    //             ],
    //           );
    //         }
    //         return ListView(
    //           physics: const NeverScrollableScrollPhysics(),
    //           children: [
    //             Stack(
    //               children: [
    //                 player,
    //                 Positioned.fill(
    //                   child: YoutubeValueBuilder(
    //                     controller: widget.controller,
    //                     builder: (context, value) {
    //                       return AnimatedCrossFade(
    //                         firstChild: const SizedBox.shrink(),
    //                         secondChild: Material(
    //                           child: DecoratedBox(
    //                             decoration: BoxDecoration(
    //                               image: DecorationImage(
    //                                 image: NetworkImage(
    //                                   YoutubePlayerController.getThumbnail(
    //                                     videoId: video!,
    //                                     quality: ThumbnailQuality.medium,
    //                                   ),
    //                                 ),
    //                                 fit: BoxFit.fitWidth,
    //                               ),
    //                             ),
    //                             child: const Center(
    //                               child: CircularProgressIndicator(),
    //                             ),
    //                           ),
    //                         ),
    //                         crossFadeState: value.isReady
    //                             ? CrossFadeState.showFirst
    //                             : CrossFadeState.showSecond,
    //                         duration: const Duration(milliseconds: 300),
    //                       );
    //                     },
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         );
    //       },
    //     ),
    //   ),
    // );
  }

  @override
  void dispose() {
    widget.controller.close();
    super.dispose();
  }
}