import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/route_generator.dart';
import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
import 'package:zong_islamic_web_app/src/resource/utility/screen_arguments.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/category_by_id/category_detail_page.dart';
import 'package:zong_islamic_web_app/src/ui/widget/expanded_container.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_category_avatar.dart';

class CategorySection extends StatelessWidget {
  final List<MainMenuCategory> category;

  const CategorySection({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.black,
      elevation: 8.0,
      child: ExpansionCard(
          title: Wrap(
              alignment: WrapAlignment.center,
              direction: Axis.horizontal,
              runSpacing: 15,
              spacing: 40,
              children: category
                  .take(8)
                  .map((e) => GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RouteString.categoryDetail,
                              arguments: ScreenArguments(
                                buildContext: context,
                                data: e.catId
                              ));
                        },
                        child: CategoryAvatar(
                            imageNetworkPath: e.image, value: e.title),
                      ))
                  .toList()),
          children: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Wrap(
                alignment: WrapAlignment.center,
                direction: Axis.horizontal,
                spacing: 40,
                children: category.reversed
                    .take(4)
                    .map((e) => CategoryAvatar(
                        imageNetworkPath: e.image, value: e.title))
                    .toList()),
          )),
    );
  }
}
