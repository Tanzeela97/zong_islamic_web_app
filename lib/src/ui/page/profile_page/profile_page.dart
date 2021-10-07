import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:zong_islamic_web_app/src/cubit/profile_cubit/profile_cubit.dart';
import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
import 'package:zong_islamic_web_app/src/model/news.dart';
import 'package:zong_islamic_web_app/src/model/profile.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/widget/video_review_container.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_category_avatar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInitial) {
          return const SizedBox.shrink();
        } else if (state is ProfileLoadingState) {
          return const Center(child: Text('loading'));
        } else if (state is ProfileSuccessState) {
          return _ProfilePage(profile: state.profle!);
        } else if (state is ProfileErrorState) {
          return const Center(child: Text('something Went Wrong'));
        } else {
          return const Center(child: Text('something Went Wrong'));
        }
      },
    );
  }
}

class _ProfilePage extends StatelessWidget {
  final Profile profile;
  final SizedBox _sizedBox = const SizedBox(height: 10);

  const _ProfilePage({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          _DeactivateButton(
            callback: () {
              context.read<StoredAuthStatus>().saveAuthStatus(false);
            },
          ),
          _sizedBox,
          const Icon(
            Icons.person,
            color: AppColor.pinkTextColor,
            size: 150,
          ),
          _sizedBox,
          const _LineText('021090078601',
              size: 18, fontWeight: FontWeight.w300),
          _sizedBox,
          _RecentlyViewed(news: profile.recenltySearch!),
          _sizedBox,
          _SuggestionCategories(category: profile.suggestedCategory!),
          _sizedBox,
          _SuggestedVideos(videos: profile.suggestedVideo!),
        ],
      ),
    );
  }
}

class _DeactivateButton extends StatelessWidget {
  final VoidCallback? callback;

  const _DeactivateButton({Key? key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: AppColor.pinkTextColor),
          onPressed: callback,
          child: const Text(AppString.deactivate),
        ),
      ],
    );
  }
}

class _RecentlyViewed extends StatelessWidget {
  final List<News> news;

  const _RecentlyViewed({Key? key, required this.news}) : super(key: key);
  final SizedBox _sizedBox = const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const _LineText(AppString.recentlyViewed),
      _sizedBox,
      Column(
        children: news
            .map((newsItem) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Image.network(
                      newsItem.catImage!,
                      height: 240,
                      width: 80,
                      fit: BoxFit.fill,
                    ),
                    title: Text(
                      newsItem.contentCatTitle!,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.black, overflow: TextOverflow.ellipsis),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(newsItem.contentDescEn!),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ))
            .toList(),
      )
    ]);
  }
}

class _SuggestionCategories extends StatelessWidget {
  final SizedBox _sizedBox = const SizedBox(height: 10);
  final List<MainMenuCategory> category;

  const _SuggestionCategories({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _LineText(AppString.suggestedCategories),
        _sizedBox,
        SizedBox(
          height: 150,
          width: double.infinity,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: category.length,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CategoryAvatar(
                      value: category[index].title,
                      imageNetworkPath: category[index].image,
                    ),
                  )),
        ),
      ],
    );
  }
}

class _SuggestedVideos extends StatelessWidget {
  final List<News> videos;

  const _SuggestedVideos({Key? key, required this.videos}) : super(key: key);
  final SizedBox _sizedBox = const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _LineText(AppString.suggestedVideos),
        _sizedBox,
        SizedBox(
          height: 140,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: videos.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: VideoPreview(
                  text: videos[index].contentCatTitle!,
                  imgSrc: videos[index].catImage!),
            ),
          ),
        ),
      ],
    );
  }
}

class _LineText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;

  const _LineText(this.text,
      {Key? key, this.size = 32, this.fontWeight = FontWeight.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
          fontWeight: fontWeight, fontSize: size, color: Colors.black),
    );
  }
}
