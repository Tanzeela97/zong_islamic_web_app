import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';

class TrendingText extends StatelessWidget {
  const TrendingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text('TRENDING',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(letterSpacing: 1, color: AppColor.black, fontSize: 20)),
    );
  }
}
