import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/cubit/cate_cubit/category_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/cate_cubit/sub_category/pillar_of_islam_cubit/pillar_cubit.dart';
import 'package:zong_islamic_web_app/src/model/content_by_category_id.dart';
import 'package:zong_islamic_web_app/src/resource/repository/cate_repository.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/ui/widget/error_text.dart';
import 'package:zong_islamic_web_app/src/ui/widget/video_detail_page.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_category_avatar.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_empty_box.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';

class PillarOfIslam extends StatefulWidget {
  final String contendId;

  const PillarOfIslam(this.contendId, {Key? key}) : super(key: key);

  @override
  State<PillarOfIslam> createState() => _PillarOfIslamState();
}

class _PillarOfIslamState extends State<PillarOfIslam> {
  @override
  void initState() {
    BlocProvider.of<CategoryCubit>(context).getCategoryById(widget.contendId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WidgetAppBar(title: AppString.pillarOfIslam),
      body: SafeArea(
        child: BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
          if (state is CategoryInitial) {
            return const EmptySizedBox();
          } else if (state is CategoryLoadingState) {
            return const WidgetLoading();
          } else if (state is CategorySuccessState) {
            return _PillarOfIslamByCategory(state.category!);
          } else if (state is CategoryErrorState) {
            return const ErrorText();
          } else {
            return const ErrorText();
          }
        }),
      ),
    );
  }
}

class _PillarOfIslamByCategory extends StatefulWidget {
  final ContentByCateId cateId;
  const _PillarOfIslamByCategory(this.cateId, {Key? key}) : super(key: key);

  @override
  State<_PillarOfIslamByCategory> createState() => _PillarOfIslamByCategoryState();
}

class _PillarOfIslamByCategoryState extends State<_PillarOfIslamByCategory> {
  final _sizedBox = const SizedBox(height: 10);
  final pillarCubit = PillarCubit(CategoryRepository.getInstance()!);

  @override
  void initState() {
    pillarCubit.getPillarById(widget.cateId.subMenu![0].catId!);
    super.initState();
  }

  @override
  void dispose() {
    pillarCubit.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: pillarCubit,
      child: Column(
        children: [
          _sizedBox,
          PhysicalModel(
            color: Colors.black,
            elevation: 5.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              width: double.infinity,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.cateId.subMenu!
                    .asMap()
                    .map((i, element) => MapEntry(i, GestureDetector(
                  onTap: (){

                    pillarCubit.getPillarById(element.catId!);
                  },
                  child: CategoryAvatar(imageNetworkPath: element.image!,value: element.title!),
                )))
                    .values
                    .toList(),
              ),
            ),
          ),
          _sizedBox,
          Expanded(
            child: BlocBuilder<PillarCubit, PillarState>(builder: (context, state) {
              if (state is PillarInitial) {
                return const EmptySizedBox();
              } else if (state is PillarLoadingState) {
                return const WidgetLoading();
              } else if (state is PillarSuccessState) {
                return VideoDetailPage(trending: state.category!.vod!.data, index: 1,appBar: false);
              } else if (state is PillarErrorState) {
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
