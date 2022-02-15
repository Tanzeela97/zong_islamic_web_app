import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/page/profile_page/profile_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/signin_page.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';

class DrawerItem extends StatelessWidget {
  final String text;
  final EnumAboutUs? enumAboutUs;

  const DrawerItem({required this.text, this.enumAboutUs});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      onTap: () {
        switch (enumAboutUs) {
          case EnumAboutUs.about:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AboutUs(
                          enumAboutUs: enumAboutUs,
                        )));
            break;
          case EnumAboutUs.term:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AboutUs(
                          enumAboutUs: enumAboutUs,
                        )));
            break;
          case EnumAboutUs.policy:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AboutUs(enumAboutUs: enumAboutUs)));
            break;
          case EnumAboutUs.categories:
            break;
          case EnumAboutUs.MyProfile:
            MaterialPageRoute(
                builder: (context) =>
                Provider
                    .of<StoredAuthStatus>(context)
                    .authStatus
                    ? ProfilePage()
                    : SignInPage());
            break;
        }
      },
    );
  }
}

class AboutUs extends StatelessWidget {
  final EnumAboutUs? enumAboutUs;

  const AboutUs({Key? key, this.enumAboutUs}) : super(key: key);
  static const titleList = ['About Us', 'Terms & Condition', 'Privacy Policy'];
  static const _textStyle = TextStyle();

  Widget policy() =>
      Text(
        'Disclaimer: ZONG will not be responsible for misinformation communicated via the offered services which include SMS Alerts, Pull, IVR and Video Streaming. 19.5% FED on usage and other taxes at recharge or bill applies. In Islamabad, AJK, Baluchistan, Gilgit/Baltistan and FATA an additional 0.84 % will be charged on all services and packages. Your SIM is your identity, only use SIM issues through Biometric Verification Terms and Conditions Apply',
        style: _textStyle,
        textAlign: TextAlign.justify,
      );

  Widget about() =>
      Column(
        children: [
          Text('Zong Islamic Version 1.0.0-beta',
              textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
          SizedBox(
            height: 50,
          ),
          Text(
              'Uplift the User’s spiritual zone with the ZONG Islamic App. The core objective of this application is to spread the Islamic knowledge and also provide user with amazing content that will inspire the faith. ZONG Islamic App connects through ZONG\'s 3G/4G network on the User’s wireless internet connection or via wifi. Application availability is on both platforms that are Android and IOS platform.',
              style: _textStyle,
              textAlign: TextAlign.justify),
        ],
      );

  Widget term() =>
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Terms and Conditions',
            style: _textStyle.copyWith(color: Colors.black)),
        subtitle: Text(
            'These Terms & Conditions are current as of October 2020\nWith the usage of this application, the User are indicating the User agreement to be bound by theTerms & Conditions mentioned below. The App is a utility and information application related to the Islam (religion).\nWaivern\nZong Islamic is not affiliated with and do not support any particular political organization, sect, ideology or denomination'),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        title: titleList.elementAt(enumAboutUs!.index),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 22.0),
        child: [about(), term(), policy()].elementAt(enumAboutUs!.index),
      ),
    );
  }
}

enum EnumAboutUs { about, term, policy, categories, MyProfile }
