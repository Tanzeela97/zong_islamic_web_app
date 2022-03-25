import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:zong_islamic_web_app/src/cubit/quran_cubit/quran_cubit.dart';
import 'package:zong_islamic_web_app/src/resource/repository/quran_repository.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/widget/error_text.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';
import 'dart:math' as math;

import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';

class QuranPlannerSecond extends StatefulWidget {
  const QuranPlannerSecond({Key? key}) : super(key: key);

  @override
  State<QuranPlannerSecond> createState() => _QuranPlannerSecondState();
}

class _QuranPlannerSecondState extends State<QuranPlannerSecond> {
  static const _radius = 8.0;
  final Color _lightGreen = Colors.lightGreen[100]!;
  late final TextEditingController editingController;
  final InsertQuranPlannerCubit plannerCubit =
      InsertQuranPlannerCubit(QuranPlannerRepository.getInstance()!);
  final InsertQuranPlannerCubit plannerCubitCalculate =
      InsertQuranPlannerCubit(QuranPlannerRepository.getInstance()!);

  @override
  void initState() {
    editingController = TextEditingController();

    plannerCubit.getQuranPlanner(number: '923350314495');

    super.initState();
  }

  @override
  void dispose() {
    plannerCubit.close();
    plannerCubit.close();
    super.dispose();
  }

  Widget buildPlan({required String namazName, required String value}) {
    return Container(
      height: 70,
      width: 65,
      decoration: BoxDecoration(
          color: _lightGreen,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(_radius),
              bottomRight: Radius.circular(_radius))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              alignment: Alignment.center,
              height: 18,
              child: Text(namazName,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppColor.whiteTextColor,
                      fontWeight: FontWeight.w300)),
              color: AppColor.darkPink),
          Container(height: 10, color: Colors.white),
          const Spacer(),
          Text(value,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 22.0, fontWeight: FontWeight.w300)),
          const Spacer(),
        ],
      ),
    );
  }

  Widget ProgressText({required String string, required String value}) {
    return RichText(
        text: TextSpan(
            text: string,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: AppColor.whiteTextColor, height: 1.5),
            children: [
          TextSpan(
              text: value,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppColor.whiteTextColor, fontWeight: FontWeight.w300)),
        ]));
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: WidgetAppBar(title: AppString.quranPlannerProgress),
      body: BlocBuilder(
          bloc: plannerCubit,
          builder: (_, state) {
            if (state is QuranPlannerInitialState) return SizedBox.shrink();
            if (state is QuranPlannerErrorState) return ErrorText();
            if (state is QuranPlannerLoadingState) return WidgetLoading();
            if (state is QuranPlannerSuccessStatePlanner) {
              final planner = state.quranPlanner;
              return Column(
                children: [
                  ///radial Circular
                  AspectRatio(
                    aspectRatio: 2 / 1,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 80),
                                  Text(AppString.yourProgressSoFar,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              color: AppColor.whiteTextColor,
                                              fontSize: 18)),
                                  ProgressText(
                                      string: 'Total Pages: ', value: '604'),
                                  ProgressText(
                                      string: 'Time',
                                      value: ' 0 hours(s) and 0 minute(s)'),
                                  ProgressText(string: 'Day:', value: ' 0/29'),
                                  ProgressText(
                                      string: 'Daily Pages:', value: ' 0'),
                                  WidgetDivider(thickness: 1),
                                ]),
                          )),
                          TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 1500),
                            tween: Tween<double>(begin: 0.0, end: .75),
                            curve: Curves.decelerate,
                            builder: (context, value, child) {
                              return Expanded(
                                  child: Center(
                                child: CustomPaint(
                                  painter:
                                      ProgressRingIndicator(progress: value),
                                  child: Center(
                                    child: Text(
                                        '${(value * 100).toStringAsFixed(0)}%',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                                color: AppColor.pinkTextColor)),
                                  ),
                                ),
                              ));
                            },
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0xff1f172e),
                              Color(0xff382f4c),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.5, 1]),
                        // image: DecorationImage(
                        //     image: ImageResolver.quranBackground, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  SizedBox(height: 35.0),

                  ///planned
                  Text(AppString.planed.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: AppColor.blackTextColor)),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildPlan(namazName: AppString.fajar, value: '0'),
                      buildPlan(namazName: AppString.zohar, value: '0'),
                      buildPlan(namazName: AppString.asr, value: '0'),
                      buildPlan(namazName: AppString.magrib, value: '0'),
                      buildPlan(namazName: AppString.isha, value: '0'),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Divider(
                    thickness: 1.5,
                    endIndent: 40,
                    indent: 40,
                  ),
                  SizedBox(height: 15.0),

                  ///Actual
                  Text(AppString.actual.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: AppColor.blackTextColor)),
                  const SizedBox(height: 15.0),
                  Text(
                    AppString.howManyPagesHaveYouReadSoFar,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 22.0),
                  ),
                  const SizedBox(height: 15.0),
                  Text(
                    AppString.notePagesCannotBeGreaterThan604,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: AppColor.red.shade300),
                  ),
                  const SizedBox(height: 15.0),

                  ///textField
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(AppString.pages,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 18.0)),
                      SizedBox(
                        width: 120,
                        height: 30,
                        child: TextField(
                          cursorColor: AppColor.darkPink,
                          keyboardType: TextInputType.number,
                          controller: editingController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.darkPink)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.darkPink)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 18.0)),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {

                            plannerCubitCalculate.updateQuranPlanner(
                                pageRead: '3',
                                number: '923350314495');
                          },
                          style: ElevatedButton.styleFrom(
                              primary: AppColor.darkPink),
                          child: Text(
                            AppString.calculate.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: AppColor.whiteTextColor),
                          ))
                    ],
                  ),
                  Divider(height: 25, thickness: 1.5),

                  ///next Plan
                  SizedBox(height: 35.0),
                  Text(AppString.nextPlan.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: AppColor.blackTextColor)),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildPlan(namazName: AppString.fajar, value: '0'),
                      buildPlan(namazName: AppString.zohar, value: '0'),
                      buildPlan(namazName: AppString.asr, value: '0'),
                      buildPlan(namazName: AppString.magrib, value: '0'),
                      buildPlan(namazName: AppString.isha, value: '0'),
                    ],
                  ),
                  //Text(),
                ],
              );
            }
            return ErrorText();
          }),
    );
  }
}

class ProgressRingIndicator extends CustomPainter {
  final double progress;

  const ProgressRingIndicator({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    print(progress);
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..color = AppColor.lightGrey;
    final height = size.height;
    final width = size.width;
    Paint paintTwo = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round
      ..color = AppColor.pinkTextColor;

    canvas.drawCircle(Offset(height / 2, width / 2), 90, paint);
    canvas.drawArc(
        Rect.fromCircle(center: Offset(height / 2, width / 2), radius: 90),
        math.pi * 2 * 0.75,
        math.pi * 2 * progress,
        false,
        paintTwo);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
