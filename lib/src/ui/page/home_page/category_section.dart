import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
import 'package:zong_islamic_web_app/src/ui/widget/expanded_container.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_category_avatar.dart';

class CategorySection extends StatelessWidget {
  final List<MainMenuCategory> category;

  const CategorySection({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionCard(
        color: Colors.black,
        title: Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
            runSpacing: 15,
            spacing: 30,
            children: category
                .take(8)
                .map((e) => CategoryAvatar(
                    imageNetworkPath: e.image, value: e.title))
                .toList()),
        children: Wrap(
            alignment: WrapAlignment.center,
            direction: Axis.horizontal,
            runSpacing: 15,
            spacing: 30,
            children: category.reversed
                .take(4)
                .map((e) =>
                CategoryAvatar(imageNetworkPath: e.image, value: e.title))
                .toList()));
  }
}
