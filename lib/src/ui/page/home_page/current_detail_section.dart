import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';

class CurrentDetailSection extends StatelessWidget {
  const CurrentDetailSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(flex: 2),
          Text('20 Safar 1443 AH, Sep 29 2021',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 18)),
          Text('Dhuhr: 12:22',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 28)),
          const WidgetDivider(thickness: 3, endIndent: 100),
          const _Row(string: 'Sehar',value: '05:07 [H] 05:16 [J]',),
          const _Row(string: 'Aftar',value: '05:07 [H] 05:16 [J]',),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String string;
  final String value;
  const _Row({Key? key,required this.string, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: Row(
        children: [
          Expanded(child: Text(string,style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 18))),
          Expanded(flex: 2,child: Text(value)),
        ],
      ),
    );
  }
}
