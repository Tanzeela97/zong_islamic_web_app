import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:zong_islamic_web_app/src/cubit/zong_app_info_cubit/zong_app_info_cubit.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/page/profile_page/profile_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/signin_page.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';

class DrawerItem extends StatelessWidget {
  final String text;
  final EnumAboutUs? enumOption;

  const DrawerItem({required this.text, this.enumOption});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(text),
          onTap: () {
            switch (enumOption) {
              case EnumAboutUs.about:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AboutUs(
                              enumAboutUs: enumOption,
                            )));
                break;
              case EnumAboutUs.term:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AboutUs(
                              enumAboutUs: enumOption,
                            )));
                break;
              case EnumAboutUs.policy:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AboutUs(enumAboutUs: enumOption)));
                break;
              case EnumAboutUs.categories:
                break;
              case EnumAboutUs.MyProfile:
                if (Provider.of<StoredAuthStatus>(context, listen: false)
                        .navIndex !=
                    1)
                  Provider.of<StoredAuthStatus>(context, listen: false)
                      .setBottomNav(1);
                Navigator.pop(context);
                break;
              default:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Scaffold(
                              appBar: AppBar(
                                title: const Text('Error'),
                              ),
                              body: const Center(
                                child: Text('ERROR'),
                              ),
                            )));
            }
          },
        ),
        Divider(color: Colors.pink, height: 0)
      ],
    );
  }
}

class AboutUs extends StatefulWidget {
  final EnumAboutUs? enumAboutUs;

  const AboutUs({Key? key, this.enumAboutUs}) : super(key: key);
  static const titleList = ['About Us', 'Terms & Condition', 'Privacy Policy'];
  static const _textStyle = TextStyle(fontSize: 20);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  Widget policy(String data) => Text(
        data,
        style: AboutUs._textStyle,
      );

  Widget about({required String version, required String data}) => Column(
        children: [
          Text(version,
              textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
          SizedBox(height: 50),
          Text(data, style: AboutUs._textStyle, textAlign: TextAlign.justify),
        ],
      );

  // Widget term() => ListTile(
  //       contentPadding: EdgeInsets.zero,
  //       title: Text('Terms and Conditions',
  //           style: AboutUs._textStyle.copyWith(color: Colors.black)),
  //       subtitle: Text(
  //           'These Terms & Conditions are current as of October 2020\nWith the usage of this application, the User are indicating the User agreement to be bound by theTerms & Conditions mentioned below. The App is a utility and information application related to the Islam (religion).\nWaivern\nZong Islamic is not affiliated with and do not support any particular political organization, sect, ideology or denomination'),
  //     );
  Widget term(String data) => SingleChildScrollView(
        child: Text(
          data,
          style: AboutUs._textStyle.copyWith(fontSize: 20),
        ),
      );
  final ZongAppInfoCubit zongAppInfoCubit = ZongAppInfoCubit();

  @override
  void dispose() {
    zongAppInfoCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        title: AboutUs.titleList.elementAt(widget.enumAboutUs!.index),
      ),
      body: BlocBuilder<ZongAppInfoCubit, ZongAppInfoState>(
        bloc: zongAppInfoCubit,
        builder: (context, state) {
          if (state is ZongAppInfoInitial) return SizedBox.shrink();
          if (state is ZongAppInfoLoading) return WidgetLoading();
          if (state is ZongAppInfoLoaded)
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 22.0, horizontal: 22.0),
              child: [
                about(
                    version: state.zongAppInformation.appVersion!,
                    data: state.zongAppInformation.about!),
                term(state.zongAppInformation.term!),
                policy(state.zongAppInformation.privacy!)
              ].elementAt(widget.enumAboutUs!.index),
            );
          if (state is ZongAppInfoError)
            return ErrorWidget(AppString.errorMessage);
          return ErrorWidget(AppString.errorMessage);
        },
      ),
    );
  }

  @override
  void initState() {
    zongAppInfoCubit
        .getZongAppInfo(context.read<StoredAuthStatus>().authNumber);
    super.initState();
  }
}

enum EnumAboutUs { about, term, policy, categories, MyProfile }
