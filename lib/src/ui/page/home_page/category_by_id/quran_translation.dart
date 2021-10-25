import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/cubit/cate_cubit/category_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/cate_cubit/sub_category/quran_translation_cubit/quran_cubit.dart';
import 'package:zong_islamic_web_app/src/model/content_by_category_id.dart';
import 'package:zong_islamic_web_app/src/model/news.dart';
import 'package:zong_islamic_web_app/src/model/trending.dart';
import 'package:zong_islamic_web_app/src/resource/repository/cate_repository.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/ui/widget/error_text.dart';
import 'package:zong_islamic_web_app/src/ui/widget/video_detail_page.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_empty_box.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_video_tile.dart';

enum TapOption { paraWise, SurahWise }

class QuranAndTranslation extends StatefulWidget {
  final String contendId;

  const QuranAndTranslation(this.contendId, {Key? key}) : super(key: key);

  @override
  State<QuranAndTranslation> createState() => _QuranAndTranslationState();
}

class _QuranAndTranslationState extends State<QuranAndTranslation> {
  @override
  void initState() {
    BlocProvider.of<CategoryCubit>(context).getCategoryById(widget.contendId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
              if (state is QuranInitial) {
                return const EmptySizedBox();
              } else if (state is CategoryLoadingState) {
                return const WidgetLoading();
              } else if (state is CategorySuccessState) {
                return _QuranTranslationByCategory(state.category!);
              } else if (state is CategoryErrorState) {
                return const ErrorText();
              } else {
                return const ErrorText();
              }
            }),
          ),
        ],
      ),
    );
  }
}

class _QuranTranslationByCategory extends StatefulWidget {
  final ContentByCateId cateId;

  const _QuranTranslationByCategory(this.cateId, {Key? key}) : super(key: key);

  @override
  State<_QuranTranslationByCategory> createState() =>
      _QuranTranslationByCategoryState();
}

class _QuranTranslationByCategoryState
    extends State<_QuranTranslationByCategory>
    with SingleTickerProviderStateMixin {

  final _sizedBox = const SizedBox(height: 10);
  final quranCubit = QuranCubit(CategoryRepository.getInstance()!);
  late TabController tabController;
  bool absorb = false;
  @override
  void initState() {
    quranCubit.getQuranTranslationById(widget.cateId.subMenu![0].catId!);
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    quranCubit.close();
    super.dispose();
  }

  void setAbsorb(bool value){
    setState(() {
      absorb = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.cateId.subMenu!.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: const WidgetAppBar(title: AppString.quranAndTranslation),
        body: BlocProvider.value(
          value: quranCubit,
          child: Column(
            children: [
              AbsorbPointer(
                absorbing: absorb,
                child: SizedBox(
                  height: 70,
                  child: TabBar(
                    controller: tabController,
                    tabs: [
                      Tab(
                        child: Text(widget.cateId.subMenu![0].title!,
                            style: TextStyle(
                                fontWeight: tabController.index == 0
                                    ? FontWeight.w800
                                    : FontWeight.w300)),
                      ),
                      Tab(
                          child: Text(widget.cateId.subMenu![1].title!,
                              style: TextStyle(
                                  fontWeight: tabController.index == 1
                                      ? FontWeight.w800
                                      : FontWeight.w300))),
                    ],
                    indicator: const BoxDecoration(
                      gradient: RadialGradient(radius: 2.5, colors: [
                        AppColor.pinkTextColor,
                        AppColor.whiteTextColor
                      ]),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),

                      // Creates border
                    ),
                    labelColor: Colors.black,
                    onTap: (index) {
                      quranCubit.getQuranTranslationById(
                          widget.cateId.subMenu![index].catId!);
                    },
                  ),
                ),
              ),
              _sizedBox,
              Expanded(
                child: BlocBuilder<QuranCubit, QuranState>(
                    builder: (context, state) {
                  if (state is QuranInitial) {
                    return const EmptySizedBox();
                  } else if (state is QuranLoadingState) {
                    WidgetsBinding.instance!.addPostFrameCallback((_){

                      setAbsorb(true);
                    });
                    return const WidgetLoading();
                  } else if (state is QuranSuccessState) {
                    WidgetsBinding.instance!.addPostFrameCallback((_){

                      setAbsorb(false);
                    });
                    if (state.category!.vod! is List) {
                      return _SurahWise(state.category!.vod!);
                    }
                    return _ParaWise(state.category!.vod!.data);
                  } else if (state is QuranErrorState) {
                    return const ErrorText();
                  } else {
                    return const ErrorText();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ParaWise extends StatelessWidget {
  final List<News> news;

  const _ParaWise(this.news, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoDetailPage(
                            appBar: true, trending: news, index: index)));
              },
              child: VideoListTile(
                shares: '0',
                likes: '0',
                contentTitle: news[index].contentTitle!,
                contentSubTitle: news[index].contentCatTitle!,
                imgUrl: news[index].catImage!,
                highlight: false,
              ),
            ),
        separatorBuilder: (context, index) => const WidgetDivider(thickness: 2),
        itemCount: news.length);
  }
}

class _SurahWise extends StatefulWidget {
  final List<Trending> surah;

  const _SurahWise(this.surah, {Key? key}) : super(key: key);

  @override
  State<_SurahWise> createState() => _SurahWiseState();
}

class _SurahWiseState extends State<_SurahWise> {
  String? dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.surah[0].itemName!;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: double.infinity,
          child: Row(
            children: [
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: widget.surah
                    .map<DropdownMenuItem<String>>((Trending value) {
                  return DropdownMenuItem<String>(
                    value: value.itemName,
                    child: Text(value.itemName!),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
