import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';

class WidgetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? action;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const WidgetAppBar(
      {Key? key,
      required this.title,
      this.leading,
      this.action,
      required this.scaffoldKey})
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
      leading: IconButton(
          icon: title == AppString.MAIN_PAGE
              ? const Icon(
                  Icons.dehaze,
                  color: Colors.white,
                )
              : const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            scaffoldKey!.currentState!.openDrawer();
            if (title != AppString.MAIN_PAGE) {
              Navigator.pop(context);
            }
          }),
      actions: const [],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
