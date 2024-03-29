
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zong_islamic_web_app/route_generator.dart';
import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/resource/utility/screen_arguments.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/widget/expanded_container.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_category_avatar.dart';

class CategorySection extends StatefulWidget {
  final List<MainMenuCategory> category;

  const CategorySection({Key? key, required this.category}) : super(key: key);

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  late final PageController controller;

  @override
  void initState() {
    controller = PageController(viewportFraction: 0.2, initialPage: 0);
    controller.addListener(listenToChanges);
    super.initState();
  }

  ValueNotifier<int> highlight = ValueNotifier(2);

  void listenToChanges() {}

  @override
  void dispose() {
    controller.dispose();
    highlight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text(AppString.categories.toUpperCase(),
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColor.black)),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                if (Provider.of<StoredAuthStatus>(context, listen: false)
                    .authStatus) {
                  Navigator.pushNamed(context, RouteString.mufti);
                  // String url = await ZongIslamicRemoteDataSourceImpl()
                  //     .checkMuftiLive(
                  //         context.read<StoredAuthStatus>().authNumber);
                  // url = "https://www.youtube.com/watch?v=UkuFP2wMI_o";
                  //
                  // url = "";
                  // if (url.isEmpty) {
                  //   Navigator.pushNamed(context, RouteString.mufti);
                  // } else {
                  //   Navigator.pushNamed(context, RouteString.liveStreaming,
                  //       arguments: ScreenArguments(message: url));
                  // }
                } else {
                  Navigator.pushNamed(context, RouteString.signIn,
                      arguments: ScreenArguments(
                        flag: false,
                        data: '28',
                        secondData: context.read<StoredAuthStatus>().authNumber,
                      ));
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 10.0),
                child: Image(image: ImageResolver.QuestionMufti, height: 70),
              ),
            )
          ],
        ),
        SizedBox(height: 15),
        SizedBox(
          height: 140,
          child: PageView.builder(
              pageSnapping: false,
              // physics: CustomScrollPhysics(),
              onPageChanged: (val) {
                print(val);
                highlight.value = val + 2;
              },
              padEnds: false,
              itemCount: widget.category.length,
              scrollDirection: Axis.horizontal,
              controller: controller,
              itemBuilder: (_, index) {
                final e = widget.category[index];
                return GestureDetector(
                  onTap: () {
                    Provider.of<StoredAuthStatus>(context, listen: false)
                            .authStatus
                        ? Navigator.pushNamed(
                            context, RouteString.categoryDetail,
                            arguments: ScreenArguments(
                                buildContext: context,
                                data: e.catId,
                                secondData: context
                                    .read<StoredAuthStatus>()
                                    .authNumber))
                        : Navigator.pushNamed(context, RouteString.signIn,
                            arguments: ScreenArguments(
                              flag: false,
                              data: '28',
                              secondData:
                                  context.read<StoredAuthStatus>().authNumber,
                            ));
                  },
                  child: ValueListenableBuilder<int>(
                    valueListenable: highlight,
                    builder: (_, value, child) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: value == index ? 0 : 12.0),
                        child: CategoryAvatar(
                            imageNetworkPath: e.image,
                            radius: value == index ? 40 : 30,
                            value: e.title,
                            fontWeight: value == index ? FontWeight.bold : null,
                            color: value == index
                                ? AppColor.pinkTextColor
                                : AppColor.black,
                            isFromHompage: true),
                      );
                    },
                  ),
                );
              }),
        ),
      ],
    );
    return PhysicalModel(
      color: AppColor.black,
      elevation: 8.0,
      child: ExpansionCard(
          title: Wrap(
              alignment: WrapAlignment.center,
              direction: Axis.horizontal,
              runSpacing: 15,
              spacing: 40,
              children: widget.category
                  .take(8)
                  .map((e) => GestureDetector(
                        onTap: () {
                          Provider.of<StoredAuthStatus>(context, listen: false)
                                  .authStatus
                              ? Navigator.pushNamed(
                                  context, RouteString.categoryDetail,
                                  arguments: ScreenArguments(
                                      buildContext: context,
                                      data: e.catId,
                                      secondData: context
                                          .read<StoredAuthStatus>()
                                          .authNumber))
                              : Navigator.pushNamed(context, RouteString.signIn,
                                  arguments: ScreenArguments(
                                    flag: false,
                                    data: '28',
                                    secondData: context
                                        .read<StoredAuthStatus>()
                                        .authNumber,
                                  ));
                        },
                        child: CategoryAvatar(
                            imageNetworkPath: e.image,
                            value: e.title,
                            isFromHompage: true),
                      ))
                  .toList()),
          children: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Wrap(
                alignment: WrapAlignment.center,
                direction: Axis.horizontal,
                spacing: 40,
                children: widget.category.reversed
                    .take(4)
                    .map((e) => GestureDetector(
                          onTap: () {
                            Provider.of<StoredAuthStatus>(context,
                                        listen: false)
                                    .authStatus
                                ? Navigator.pushNamed(
                                    context, RouteString.categoryDetail,
                                    arguments: ScreenArguments(
                                        buildContext: context,
                                        data: e.catId,
                                        secondData: context
                                            .read<StoredAuthStatus>()
                                            .authNumber))
                                : Navigator.pushNamed(
                                    context, RouteString.signIn,
                                    arguments: ScreenArguments(
                                      flag: false,
                                      data: '28',
                                      secondData: context
                                          .read<StoredAuthStatus>()
                                          .authNumber,
                                    ));
                          },
                          child: CategoryAvatar(
                              imageNetworkPath: e.image,
                              value: e.title,
                              isFromHompage: true),
                        ))
                    .toList()),
          )),
    );
  }
}
