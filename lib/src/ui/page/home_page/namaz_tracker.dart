import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';

import 'Calender/calendar_carousel.dart';
import 'namaz_selection.dart';

class NamazTracker extends StatefulWidget {
  const NamazTracker({Key? key}) : super(key: key);

  @override
  _NamazTrackerState createState() => _NamazTrackerState();
}

class _NamazTrackerState extends State<NamazTracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WidgetAppBar(title: 'Nazmaz Tracker'),
      body: SafeArea(
        child: Column(children: [
          Container(
            color: AppColor.darkPurple,
            height: 115,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  const Text(
                      'Total '
                      '10',
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(20),
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      alignment: Alignment.topRight,
                      height: 45,
                      color: AppColor.darkPink,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Fajar',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Text(
                              'Zohar',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Text(
                              'Asr',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Text(
                              'Magrib',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Text(
                              'Isha',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ]),
                    ),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Missed',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      '6',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      '3',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      '1',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      '0',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ],
            ),
          ),
          //calender
          const Calender(),
          const SizedBox(height: 10),
          NamazRow(namaz: "Fajar"),
          const SizedBox(height: 10),
          NamazRow(namaz: "Zuhar"),
          const SizedBox(height: 10),
          NamazRow(namaz: "Asr"),
          const SizedBox(height: 10),
          NamazRow(namaz: "Magrib"),
          const SizedBox(height: 10),
          NamazRow(namaz: "Isha"),

//Radio
        ]),
      ),
    );
  }
}
