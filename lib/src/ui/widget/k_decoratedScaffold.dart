import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';

class KDecoratedBackground extends StatelessWidget {
  final Widget child;
  const KDecoratedBackground({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(image: ImageResolver.scaffoldBackGround,fit: BoxFit.cover),
      ),
      child: child
    );
  }
}
