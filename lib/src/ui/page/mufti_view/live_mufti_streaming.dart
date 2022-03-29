import 'package:better_player/better_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:zong_islamic_web_app/route_generator.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/list_category/list_category_cubit.dart';
import 'package:zong_islamic_web_app/src/model/news.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/page/mufti_view/four_content_detail_page.dart';
import 'package:zong_islamic_web_app/src/ui/widget/error_text.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_video_tile.dart';
import 'package:zong_islamic_web_app/src/ui/widget/youtube_app_demo.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
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
    BlocProvider.of<ListCategoryCubit>(context).fetchFourContentCategoryStatus(
        context.read<StoredAuthStatus>().authNumber);

    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayerController.convertUrlToId(widget.url)!,
      params: const YoutubePlayerParams(
        showControls: true,
        autoPlay: true,
        showFullscreenButton: true,
      ),
    );
    controller.load(YoutubePlayerController.convertUrlToId(widget.url)!);

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
            color: Colors.grey[100],
            height: 80,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mufti Live',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            overflow: TextOverflow.ellipsis)),
                    SizedBox(height: 5),
                    Text('lorem Ipsum'),
                  ],
                ),
                const Spacer(),
                ...[
                  GestureDetector(
                      onTap: () {
                        UrlLauncher.launch("tel://786");
                      },
                      child: Image(
                          image: ImageResolver.QuestionMufti, height: 75)),
                  SizedBox(width: 50),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteString.mufti);
                      },
                      child:
                          Image(image: ImageResolver.Talktomufti, height: 75)),
                  SizedBox(width: 16.0),
                ],
              ],
            ),
          ),
          BlocBuilder<ListCategoryCubit, ListCategoryState>(
            builder: (context, state) {
              if (state is FourCategoryLoadingState) {
                return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 100),
                    child: WidgetLoading());
              } else if (state is FourCategorySuccessState) {
                return Expanded(
                  flex: 2,
                  child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const WidgetDivider(thickness: 2),
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FourContentDetailPage(
                                              trending: state.cateInfo!,
                                              index: index)));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: VideoListTileTwo(
                                //todo page number and update like
                                contentSubTitle:
                                    state.cateInfo![index].contentCatTitle!,
                                contentTitle:
                                    state.cateInfo![index].contentTitle!,
                                likes: state.cateInfo![index].like ?? '',
                                shares: state.cateInfo![index].share ?? '',
                                imgUrl: state.cateInfo![index].catImage!,
                                cateId: state.cateInfo![index].contentCatId!,
                                contId: state.cateInfo![index].contentId!,
                                page: '',
                                isLikedByUser: (int val) {},
                                isLiked: state.cateInfo![index].isLike ?? '',
                              ),
                            ),
                          ),
                      itemCount: state.cateInfo!.length),
                );
              } else if (state is FourCategoryErrorState) {
                return const ErrorText();
              } else {
                return const ErrorText();
              }
            },
          )
        ]),
      ),
    );
  }
}
