import 'package:flutter/material.dart';

class WidgetHeadingText extends StatelessWidget {
  String text;

  WidgetHeadingText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
    );
  }
}
