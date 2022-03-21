import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';

class QuranPlanner extends StatefulWidget {
  const QuranPlanner({Key? key}) : super(key: key);

  @override
  State<QuranPlanner> createState() => _QuranPlannerState();
}

class _QuranPlannerState extends State<QuranPlanner> {
  late ValueNotifier<int> quranCountNotifier;
  late ValueNotifier<int> quranDaysNotifier;
  late ValueNotifier<int> quranPageNotifier;
  late ValueNotifier<int> quranReadNotifier;
  late ValueNotifier textFieldOne;

  @override
  void initState() {
    quranCountNotifier = ValueNotifier(1);
    quranDaysNotifier = ValueNotifier(0);
    quranPageNotifier = ValueNotifier(0);
    quranReadNotifier = ValueNotifier(0);
    super.initState();
  }

  @override
  void dispose() {
    quranCountNotifier.dispose();
    super.dispose();
  }

  increment() {
    quranCountNotifier.value++;
  }

  decrement() {
    quranCountNotifier.value--;
  }
  void onchange({required String value,required ValueNotifier<int> valueNotifier, bool? lol}){
    if(value.isEmpty){
      print('isEmpty');
      return;
    }else{
      if(int.parse(value)>0){
        print(int.parse(value));
        valueNotifier.value=int.parse(value);
      }
    }
  }
  final   lightGreen = Colors.lightGreen[100];
  Widget get divider=>const Divider(thickness: 1.5,endIndent: 25.0,indent: 25.0,);
  @override
  Widget build(BuildContext context) {
    final _style = Theme.of(context).textTheme.bodyText2;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: WidgetAppBar(title: AppString.quranPlanner),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 2 / 1,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'Create your to\n',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.normal),
                          children: [
                            TextSpan(
                                text: 'complete the Quran',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(fontWeight: FontWeight.bold)),
                          ])),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _AddOrSubtract(iconData: Icons.remove, onTap: decrement),
                      ValueListenableBuilder<int>(
                          valueListenable: quranCountNotifier,
                          builder: (context, value, child) {
                            return SizedBox(
                              width: 50,
                              child: Text(value.toString(),
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.headline5!),
                            );
                          }),
                      _AddOrSubtract(iconData: Icons.add, onTap: increment),
                    ],
                  ),
                  Text(
                    'this Ramadan',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: ImageResolver.quranBackground, fit: BoxFit.cover),
              ),
            ),
          ),
          Container(
            height: 65,
            decoration: BoxDecoration(color: AppColor.darkPink),
          ),

          ///first option
          _PlannerLayoutFrom(
              string: AppString.firstOption,
              secondChild: Container(
                height: 45.0,
                width: 120,
                decoration: BoxDecoration(
                  color: lightGreen,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Row(children: [
                  Expanded(
                    flex: 2,
                    child: AnimatedContainer(
                      height: double.infinity,
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        color: AppColor.darkPink,
                        // color: isTextEditingControllerOne()?AppColor.darkPink:Colors.orange,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text('29',
                          style: _style!.copyWith(
                              color: AppColor.whiteTextColor, fontSize: 18.0)),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          //onchange(value, quranDaysNotifier);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Others',
                        ),
                      )),
                ]),
              )),
          divider,
          ///second Option
          _PlannerLayoutFrom(
              string: AppString.secondOption,
              secondChild: Container(
                height: 45.0,
                width: 150,
                decoration: BoxDecoration(
                  color: lightGreen,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Row(children: [
                  Expanded(
                    flex: 2,
                    child: AnimatedContainer(
                      height: double.infinity,
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        //color: AppColor.darkPink,
                        color: false ? AppColor.darkPink : lightGreen,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text('604',
                          style: _style.copyWith(
                              color: AppColor.whiteTextColor, fontSize: 18.0)),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: AnimatedContainer(
                      height: double.infinity,
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        color: AppColor.darkPink,
                        // color: isTextEditingControllerOne()?AppColor.darkPink:Colors.orange,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text('850',
                          style: _style.copyWith(
                              color: AppColor.whiteTextColor, fontSize: 18.0)),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        //controller: textEditingControllerTwo,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Others',
                        ),
                      )),
                ]),
              )),
          divider,
          ///third Option
          _PlannerLayoutFrom(
              string: AppString.thirdOption,
              secondChild: Container(
                height: 45.0,
                width: 120,
                decoration: BoxDecoration(
                  color: lightGreen,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Row(children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      //controller: textEditingControllerTwo,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '#',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: AnimatedContainer(
                      height: double.infinity,
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        color: AppColor.darkPink,
                        // color: isTextEditingControllerOne()?AppColor.darkPink:Colors.orange,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text('Minutes',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                ]),
              )),
          divider,
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: AppColor.darkPink, minimumSize: Size(120, 35)),
              onPressed: () {},
              child: Text(
                'Continue',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white),
              )),
        ],
      ),
    );
  }
}

class _AddOrSubtract extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData iconData;

  const _AddOrSubtract({Key? key, this.onTap, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 40,
        width: 40,
        child: Card(
          color: AppColor.darkPink,
          child: Icon(iconData, color: AppColor.whiteTextColor),
        ),
      ),
    );
  }
}

class _PlannerLayoutFrom extends StatelessWidget {
  final String string;
  final Widget secondChild;

  const _PlannerLayoutFrom(
      {Key? key, required this.string, required this.secondChild})
      : super(key: key);
  static const _fontSize = 18.0;

  @override
  Widget build(BuildContext context) {
    final _style = Theme.of(context).textTheme.bodyText2;
    return Column(
      children: [
        Text(string, style: _style!.copyWith(fontSize: _fontSize)),
        SizedBox(height: 25.0),
        secondChild,
        SizedBox(height: 25.0),
      ],
    );
  }
}
