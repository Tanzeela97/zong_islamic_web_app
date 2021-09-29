import 'package:flutter/material.dart';

class WidgetIconImage extends StatelessWidget {
  String text;
  IconData icon;

  WidgetIconImage({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,size: 30,),
        Text(text, style: TextStyle(fontSize: 15)),
      ],
    );
  }
}
