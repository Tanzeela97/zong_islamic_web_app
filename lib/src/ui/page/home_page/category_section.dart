import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/model/main_menu_category.dart';
class CategorySection extends StatelessWidget {
  final List<MainMenuCategory> category;
  const CategorySection({Key? key,required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      color: Colors.pink,
    );
  }
}
