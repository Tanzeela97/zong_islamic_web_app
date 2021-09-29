import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';

class CurrentDetailSection extends StatelessWidget {
  const CurrentDetailSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      width: double.infinity,
      height: 300,
      decoration:  BoxDecoration(
        color: Colors.grey[200]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          const Text('20 Safar 1443 AH, Sep 29 2021'),
          const Text('Dhuhr: 12:22'),
          const WidgetDivider(thickness: 5,endIndent: 120),
          const Text('05:07 [H] 05:16 [J]'),
          Row(
            children: [
              
            ],
          ),
        ],
      ),
    );
  }
}
