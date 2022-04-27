import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';

class WidgetDivider extends StatelessWidget {
  final double? height, thickness, indent, endIndent;

  const WidgetDivider(
      {Key? key, this.height, this.thickness, this.indent, this.endIndent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColor.darkPink,
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
