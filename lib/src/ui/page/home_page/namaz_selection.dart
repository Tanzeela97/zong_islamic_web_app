import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';

class NamazRow extends StatefulWidget {
  String namaz;

  NamazRow({Key? key, required this.namaz}) : super(key: key);

  @override
  State<NamazRow> createState() => _NamazRowState();
}

class _NamazRowState extends State<NamazRow> {
  int _radioValue = 0;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value!;
      switch (_radioValue) {
        case 0:
          print(_radioValue);
          break;
        case 1:
          print(_radioValue);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        width: 110,
        height: 60,
        color: AppColor.darkPink,
        child: Align(
            alignment: Alignment.center,
            child: Text(
              widget.namaz,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            )),
      ),
      Container(
        height: 60,
        width: 500,
        margin: const EdgeInsets.only(left: 95),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.red,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Offered',
                  style: TextStyle(fontSize: 17.0),
                ),
                Expanded(
                  child: Radio(
                    value: 0,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 80),
            Column(
              children: [
                const Text(
                  'Not Offered',
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
                Expanded(
                  child: Radio(
                    value: 1,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    ]);
  }
}
