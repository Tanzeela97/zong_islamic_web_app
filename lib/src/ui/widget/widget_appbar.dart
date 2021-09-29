import 'package:flutter/material.dart';

class WidgetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? action;

  const WidgetAppBar({Key? key, required this.title, this.leading, this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.white, fontSize: 18),
      ),
      centerTitle: true,
      elevation: 0.0,
      leading: null,
      actions: const [],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
