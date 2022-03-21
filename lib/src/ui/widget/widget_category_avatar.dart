import 'package:flutter/material.dart';

class CategoryAvatar extends StatelessWidget {
  final String imageNetworkPath;
  final String value;
  final bool isFromHompage;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? radius;
  const CategoryAvatar(
      {Key? key,
        this.color,
        this.radius=30,
        this.fontSize=13,
        this.fontWeight,
      required this.value,
      required this.imageNetworkPath,
      required this.isFromHompage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(child: Image.network(imageNetworkPath), maxRadius: radius),
        const SizedBox(height: 5),
        SizedBox(
          width: isFromHompage ? 70 : 100,
          child: Text(
            value,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: color,fontSize: fontSize,fontWeight: fontWeight),
          ),
        ),
       // const SizedBox(height: 10),
      ],
    );
  }
}
