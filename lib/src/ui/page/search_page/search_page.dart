import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:zong_islamic_web_app/src/cubit/search_cubit/search_cubit.dart';
import 'package:zong_islamic_web_app/src/model/news.dart';
import 'package:zong_islamic_web_app/src/model/profile.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/widget/error_text.dart';
import 'package:zong_islamic_web_app/src/ui/widget/video_detail_page.dart';
import 'package:zong_islamic_web_app/src/ui/widget/video_review_container.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_empty_box.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    print('SearchPage initialize');
    // if (Provider.of<StoredAuthStatus>(context).authStatus) {
    //   BlocProvider.of<SearchCubit>(context).getSearchData(context.read<StoredAuthStatus>().authNumber);
    // }
    super.initState();
  }

  @override
  void dispose() {
    print('SearchPage dispose');
    super.dispose();
  }

  @override
  void didChangeDependencies() {
      if (Provider.of<StoredAuthStatus>(context).authStatus) {
      BlocProvider.of<SearchCubit>(context).getSearchData(context.read<StoredAuthStatus>().authNumber);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
      if (state is SearchInitial) {
        return const EmptySizedBox();
      } else if (state is SearchLoadingState) {
        return const WidgetLoading();
      } else if (state is SearchSuccessState) {
        return _SearchPage(state.profle!);
      } else if (state is SearchErrorState) {
        return const ErrorText();
      } else {
        return const ErrorText();
      }
    });
  }
}

class _SearchPage extends StatelessWidget {
  final Profile profile;
  final SizedBox _sizedBox = const SizedBox(height: 10);

  const _SearchPage(this.profile, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12.0),
      child: Column(
        children: [
          const _SearchBar(),
          _sizedBox,
          profile.recenltySearch!.first.status=='failed'?SizedBox.shrink():_RecentlyViewed(news: profile.recenltySearch!),
          _sizedBox,
          profile.suggestedVideo!.first.status=='failed'?SizedBox.shrink():_SuggestedVideos(videos: profile.suggestedVideo!),
          _sizedBox,
          profile.trendingVideo!.first.status=='failed'?SizedBox.shrink():_TrendingVideos(videos: profile.trendingVideo!),
        ],
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _editingController;

  @override
  void initState() {
    _editingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _editingController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onFieldSubmitted: (value) {
          if (_formKey.currentState!.validate()) {
            BlocProvider.of<SearchCubit>(context).getSearchData(
                context.read<StoredAuthStatus>().authNumber, value);
          }
        },
        decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<SearchCubit>(context).getSearchData(
                      context.read<StoredAuthStatus>().authNumber,
                      _editingController.text);
                }
              },
              icon: Icon(Icons.search),
              color: AppColor.darkGreyTextColor,
            ),
            hintText: AppString.search,
            //border: InputBorder.none,
            fillColor: AppColor.lightGrey,
            filled: true,
            border: InputBorder.none
            //enabledBorder: OutlineInputBorder(),
            // border: OutlineInputBorder(),
            ),
      ),
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
      const _LineText(AppString.recentlySearched),
      _sizedBox,
      SizedBox(
        width: double.infinity,
        height: 400,
        child: ListView.builder(
            itemCount: news.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoDetailPage(
                                  index: index,
                                  trending: news,
                                )));
                  },
                  leading: Image.network(
                    news[index].catImage!,
                    height: 240,
                    width: 80,
                    fit: BoxFit.fill,
                  ),
                  title: Text(
                    news[index].contentCatTitle!,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.black, overflow: TextOverflow.ellipsis),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(news[index].contentDescEn!),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              );
            }),
      ),
    ]);
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
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoDetailPage(
                                index: index,
                                trending: videos,
                              )));
                },
                child: VideoPreview(
                    text: videos[index].contentCatTitle!,
                    imgSrc: videos[index].catImage!),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TrendingVideos extends StatelessWidget {
  final List<News> videos;

  const _TrendingVideos({Key? key, required this.videos}) : super(key: key);
  final SizedBox _sizedBox = const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _LineText(AppString.trending),
        _sizedBox,
        SizedBox(
          height: 140,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: videos.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoDetailPage(
                                index: index,
                                trending: videos,
                              )));
                },
                child: VideoPreview(
                    text: videos[index].contentCatTitle!,
                    imgSrc: videos[index].catImage!),
              ),
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
      {Key? key, this.size = 27, this.fontWeight = FontWeight.w400})
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
