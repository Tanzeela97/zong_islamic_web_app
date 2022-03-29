import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/list_category/list_category_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/page/mufti_view/four_content_detail_page.dart';
import 'package:zong_islamic_web_app/src/ui/widget/error_text.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';

class FourContentPage extends StatefulWidget {
  const FourContentPage({Key? key}) : super(key: key);

  @override
  State<FourContentPage> createState() => _State();
}

class _State extends State<FourContentPage> {
  @override
  void initState() {
    BlocProvider.of<ListCategoryCubit>(context)
        .fetchFourContentCategoryStatus(context.read<StoredAuthStatus>().authNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: ClampingScrollPhysics(),
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          BlocBuilder<ListCategoryCubit, ListCategoryState>(
            builder: (context, state) {
              if (state is FourCategoryLoadingState) {
                return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 100),
                    child: WidgetLoading());
              } else if (state is FourCategorySuccessState) {
                return FourContentDetailPage(
                    trending: state.cateInfo!, index: 0);
              } else if (state is FourCategoryErrorState) {
                return const ErrorText();
              } else {
                return const ErrorText();
              }
            },
          ),
        ])),
      ],
    );
  }
}
