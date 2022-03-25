import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';

class MuftiView extends StatefulWidget {
  const MuftiView({Key? key}) : super(key: key);
  static const _height = 200.0;
  static const _width = 200.0;

  @override
  State<MuftiView> createState() => _MuftiViewState();
}

class _MuftiViewState extends State<MuftiView> {
  Widget _listTile()=>ListTile(
    tileColor: AppColor.lightGrey,
    title: Text('Ramazan k mahine ki fazilat'),
    trailing: Wrap(
      children: [
        Image(image: ImageResolver.muftiGrey,height: 35),
        SizedBox(width: 90),
      Image(image: ImageResolver.muftiPink,height: 35),
        SizedBox(width: 10),
      ],
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(title: AppString.muftiSeSawalat),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 35),
          Text(AppString.tapHereToRecord.toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: AppColor.blackTextColor, fontSize: 26)),
          const SizedBox(height: 25),
          Image(image: ImageResolver.playRecording, height: MuftiView._height),
          const SizedBox(height: 25),
          Text('00:00',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 34, fontWeight: FontWeight.w400)),
          const SizedBox(height: 25),
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColor.darkPink, width: 2),
                bottom: BorderSide(color: AppColor.darkPink, width: 2),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 60,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Text(
                      AppString.title,
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 24),
                    ),
                    decoration: BoxDecoration(
                        color: AppColor.darkPink,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0))),
                  ),
                ),
                Expanded(
                    child: Text(
                  AppString.sawalat,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: AppColor.pinkTextColor,fontSize: 18.0),
                )),
                VerticalDivider(),
                Expanded(
                    child: Text(
                  AppString.jawabat,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: AppColor.pinkTextColor,fontSize: 18.0),
                )),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          _listTile(),
        ],
      ),
    );
  }
}


