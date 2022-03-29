import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/cubit/quran_cubit/quran_cubit.dart';

import 'package:zong_islamic_web_app/src/resource/repository/quran_planner_repository.dart';

import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/page/quran_planner/quran_planner_view_second.dart';
import 'package:zong_islamic_web_app/src/ui/widget/k_decoratedScaffold.dart';
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
  bool quranPageStatus604 = true;
  bool quranPageStatus850 = false;
  final InsertQuranPlannerCubit plannerCubit =
      InsertQuranPlannerCubit(QuranPlannerRepository.getInstance()!);

  @override
  void initState() {
    quranCountNotifier = ValueNotifier(1);
    quranDaysNotifier = ValueNotifier(29);
    quranPageNotifier = ValueNotifier(604);
    quranReadNotifier = ValueNotifier(2);

    super.initState();
  }

  @override
  void dispose() {
    quranCountNotifier.dispose();
    quranDaysNotifier.dispose();
    quranPageNotifier.dispose();
    quranReadNotifier.dispose();
    plannerCubit.close();
    super.dispose();
  }

  void increment() {
    quranCountNotifier.value++;
  }

  void decrement() {
    if (quranCountNotifier.value > 1) {
      quranCountNotifier.value--;
    }
  }

  void onchange({required String value, required ValueNotifier valueNotifier,required int defaultValue}) {
    if (value.isEmpty) {
      valueNotifier.value = defaultValue;
      return;
    } else {
      if (int.parse(value) > 0) {
        print(int.parse(value));
        valueNotifier.value = int.parse(value);
      }
    }
  }

  final lightGreen = Colors.lightGreen[100];

  Widget get divider => const Divider(
        thickness: 1.5,
        endIndent: 25.0,
        indent: 25.0,
      );

  void setQuranPagesStatus604() {
    setState(() {
       quranPageStatus604 = true;
        quranPageStatus850 = false;
        quranPageNotifier.value = 604;
    });
  }
  void setQuranPagesStatus850() {
    setState(() {
       quranPageStatus604 = false;
        quranPageStatus850 = true;
        quranPageNotifier.value = 850;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _style = Theme.of(context).textTheme.bodyText2;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: WidgetAppBar(title: AppString.quranPlanner),
      body: KDecoratedBackground(
        child: Column(
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
                            text: 'Create your plan to\n',
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
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _AddOrSubtract(
                            iconData: Icons.remove, onTap: decrement),
                        ValueListenableBuilder<int>(
                            valueListenable: quranCountNotifier,
                            builder: (context, value, child) {
                              return SizedBox(
                                width: 80,
                                child: Text(value.toString(),
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline5!),
                              );
                            }),
                        _AddOrSubtract(iconData: Icons.add, onTap: increment),
                      ],
                    ),
                    const SizedBox(height: 16.0),
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
              decoration: BoxDecoration(color: AppColor.darkPink)
            ),
            ///first option
            const SizedBox(height: 32.0),
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
                                color: AppColor.whiteTextColor,
                                fontSize: 18.0)),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            onchange(
                                value: value, valueNotifier: quranDaysNotifier,defaultValue: 29);
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
                      child: GestureDetector(
                        onTap: setQuranPagesStatus604,
                        child: AnimatedContainer(
                          height: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          alignment: Alignment.center,
                          duration: const Duration(milliseconds: 500),
                          decoration: BoxDecoration(
                            //color: AppColor.darkPink,
                            color: quranPageStatus604
                                ? AppColor.darkPink
                                : lightGreen,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text('604',
                              style: _style.copyWith(
                                  color: quranPageStatus604?AppColor.whiteTextColor:AppColor.darkGreyTextColor,
                                  fontSize: 18.0)),
                        ),
                        child: Text('604',
                            style: _style.copyWith(
                                color: AppColor.whiteTextColor,
                                fontSize: 18.0)),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: setQuranPagesStatus850,
                        child: AnimatedContainer(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          height: double.infinity,
                          alignment: Alignment.center,
                          duration: const Duration(milliseconds: 500),
                          decoration: BoxDecoration(
                            color: quranPageStatus850
                                ? AppColor.darkPink
                                : lightGreen,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text('850',
                              style: _style.copyWith(
                                  color: quranPageStatus850?AppColor.whiteTextColor:AppColor.darkGreyTextColor,
                                  fontSize: 18.0)),
                        ),
                        child: Text('850',
                            style: _style.copyWith(
                                color: AppColor.whiteTextColor,
                                fontSize: 18.0)),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          //controller: textEditingControllerTwo,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Others',
                          ),
                          onChanged: (value) {
                            onchange(
                                value: value, valueNotifier: quranPageNotifier,defaultValue: 604);
                          },
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
                        onChanged: (value) {
                          onchange(
                              value: value, valueNotifier: quranReadNotifier,defaultValue: 2);
                        },
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
            BlocListener<InsertQuranPlannerCubit, QuranPlannerState>(
              bloc: plannerCubit,
              listener: (_, state) {
                if (state is QuranPlannerSuccessState) {
                  context.read<StoredAuthStatus>().saveQuranPlannerStatus(true);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const QuranPlannerSecond()));

                }
              },
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AppColor.darkPink, minimumSize: Size(120, 35)),
                  onPressed: () {

                    plannerCubit.insertQuranPlaner(
                        number: context.read<StoredAuthStatus>().authNumber,
                        counterQuran: '${quranCountNotifier.value}',
                        daysRead: '${quranDaysNotifier.value}',
                        pageReadMints: '${quranReadNotifier.value}',
                        totalPage: '${quranPageNotifier.value}');
                  },
                  child: Text(
                    'Continue',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.white),
                  )),
            ),
          ],
        ),
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

// class QuranPlan {
//   final String count;
//   final String days;
//   final String pages;
//   final String minute;
//
//   const QuranPlan(
//       {this.count = '1',
//       this.days = '29',
//       this.pages = '604',
//       required this.minute});
//
//   QuranPlan copyWith({
//     String? count,
//     String? days,
//     String? pages,
//     String? minute,
//   }) {
//     return QuranPlan(
//       count: count ?? this.count,
//       days: days ?? this.days,
//       pages: pages ?? this.pages,
//       minute: minute ?? this.minute,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'count': this.count,
//       'days': this.days,
//       'pages': this.pages,
//       'minute': this.minute,
//     };
//   }
//
//   factory QuranPlan.fromMap(Map<String, dynamic> map) {
//     return QuranPlan(
//       count: map['count'] as String,
//       days: map['days'] as String,
//       pages: map['pages'] as String,
//       minute: map['minute'] as String,
//     );
//   }
// }
