import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';

class CurrentDetailSection extends StatelessWidget {
  final String backGroundImage;
  final Color colorText = Colors.white;
  const CurrentDetailSection({Key? key, required this.backGroundImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          image: DecorationImage(
              image: Image.network(backGroundImage).image, fit: BoxFit.fill)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(flex: 2),
          Text('20 Safar 1443 AH, Sep 29 2021',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 18,color: colorText)),
          Text('Dhuhr: 12:22',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 28, color: colorText)),
          const WidgetDivider(thickness: 3, endIndent: 100),
          const _Row(
            string: 'Sehar',
            value: '05:07 [H] 05:16 [J]',
          ),
          const _Row(
            string: 'Aftar',
            value: '05:07 [H] 05:16 [J]',
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String string;
  final String value;
  final Color colorText = Colors.white;
  const _Row({Key? key, required this.string, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: Row(
        children: [
          Expanded(
              child: Text(string,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 18,color: colorText))),
          Expanded(flex: 2, child: Text(value,style: Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(fontSize: 12,color: colorText))),
        ],
      ),
    );
  }
}
