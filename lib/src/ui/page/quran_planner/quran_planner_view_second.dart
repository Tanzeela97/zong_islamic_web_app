import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/cubit/quran_cubit/quran_cubit.dart';
import 'package:zong_islamic_web_app/src/resource/repository/quran_planner_repository.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/page/quran_planner/quran_planner_view.dart';
import 'package:zong_islamic_web_app/src/ui/widget/error_text.dart';
import 'package:zong_islamic_web_app/src/ui/widget/k_decoratedScaffold.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_divider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';

class QuranPlannerProgress extends StatefulWidget {
  const QuranPlannerProgress({Key? key}) : super(key: key);

  @override
  State<QuranPlannerProgress> createState() => _QuranPlannerProgressState();
}

class _QuranPlannerProgressState extends State<QuranPlannerProgress> {
  static const _radius = 8.0;
  final Color _lightGreen = AppColor.lightGreen!;
  late final TextEditingController editingController;
  final InsertQuranPlannerCubit plannerCubit =
      InsertQuranPlannerCubit(QuranPlannerRepository.getInstance()!);
  final InsertQuranPlannerCubit plannerCubitCalculate =
      InsertQuranPlannerCubit(QuranPlannerRepository.getInstance()!);

  @override
  void initState() {
    editingController = TextEditingController();

    plannerCubit.getQuranPlanner(
        number: context.read<StoredAuthStatus>().authNumber);

    super.initState();
  }

  @override
  void dispose() {
    plannerCubit.close();
    plannerCubitCalculate.close();
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
                      color: AppColor.white,
                      fontWeight: FontWeight.w300)),
              color: AppColor.darkPink),
          Container(height: 10, color: AppColor.white),
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
                .copyWith(color: AppColor.white, height: 1.5),
            children: [
          TextSpan(
              text: value,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppColor.white, fontWeight: FontWeight.w300)),
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
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.darkPink,
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Container(
                        height: 150,
                        width: 300,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              " Once you reset there is no going back",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: AppColor.black),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("No",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: AppColor.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                        textAlign: TextAlign.left)),
                                SizedBox(
                                    height: 20,
                                    width: 60,
                                    child: VerticalDivider(
                                        thickness: 0.5,
                                        color: AppColor.black)),
                                TextButton(
                                    onPressed: () {
                                      context
                                          .read<StoredAuthStatus>()
                                          .saveQuranPlannerStatus(false);
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const QuranPlanner()));
                                    },
                                    child: Text(
                                      "Yes",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              color: AppColor.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.left,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ));
          },
          child: Icon(Icons.restart_alt, color: AppColor.white)),
      // floatingActionButton: FloatingActionButton(onPressed: (){
      //   context.read<StoredAuthStatus>().saveQuranPlannerStatus(false);
      // },),
      // resizeToAvoidBottomInset: false,
      appBar: WidgetAppBar(title: AppString.quranPlannerProgress),
      body: BlocConsumer(
          bloc: plannerCubit,
          listener: (_, state) {
            if (state is QuranPlannerSuccessStatePlanner) {
              var percentage = (state.quranPlanner.totalReadPage! /
                      state.quranPlanner.quranPages!) *
                  100;
              if (percentage > 100.0) {
                context.read<StoredAuthStatus>().saveQuranPlannerStatus(false);
              }
            }
          },
          builder: (_, state) {
            if (state is QuranPlannerInitialState) return SizedBox.shrink();
            if (state is QuranPlannerErrorState) return ErrorText();
            if (state is QuranPlannerLoadingState) return WidgetLoading();
            if (state is QuranPlannerSuccessStatePlanner) {
              final planner = state.quranPlanner;
              var percentage =
                  (planner.totalReadPage! / planner.quranPages!) * 100;
              return SingleChildScrollView(
                child: Column(
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
                                                color: AppColor.white,
                                                fontSize: 18)),
                                    ProgressText(
                                        string: 'Total Pages: ',
                                        value: planner.quranPages.toString()),
                                    ProgressText(
                                        string: 'Day: ',
                                        value: planner.days.toString()),
                                    ProgressText(
                                        string: 'Pages Read Till Now: ',
                                        value:
                                            planner.totalReadPage.toString()),
                                    WidgetDivider(thickness: 1),
                                  ]),
                            )),
                            TweenAnimationBuilder<double>(
                              duration: const Duration(milliseconds: 1500),
                              tween: Tween<double>(
                                  begin: 0.0, end: percentage / 100),
                              curve: Curves.decelerate,
                              builder: (context, value, child) {
                                return Expanded(
                                    child: Center(
                                  child: CustomPaint(
                                    painter:
                                        ProgressRingIndicator(progress: value),
                                    child: Center(
                                      child: Text('${percentage.round()} %',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(
                                                  color:
                                                      AppColor.pinkTextColor)),
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
                            .copyWith(color: AppColor.black)),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildPlan(
                            namazName: AppString.fajar,
                            value: planner.fajarPlan.toString()),
                        buildPlan(
                            namazName: AppString.zohar,
                            value: planner.zohrPlan.toString()),
                        buildPlan(
                            namazName: AppString.asr,
                            value: planner.asarPlan.toString()),
                        buildPlan(
                            namazName: AppString.magrib,
                            value: planner.magribPlan.toString()),
                        buildPlan(
                            namazName: AppString.isha,
                            value: planner.ishaaPlan.toString()),
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
                            .copyWith(color: AppColor.black)),
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
                      "${AppString.notePagesCannotBeGreaterThan604}${planner.quranPages.toString()}",
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
                              ///hide keyboard
                              FocusScope.of(context).unfocus();

                              ///call api
                              plannerCubitCalculate.updateQuranPlanner(
                                  pageRead: editingController.text,
                                  number: context
                                      .read<StoredAuthStatus>()
                                      .authNumber);

                              ///clear keyboard
                              editingController.clear();

                              ///saving Status
                            },
                            style: ElevatedButton.styleFrom(
                                primary: AppColor.darkPink),
                            child: Text(
                              AppString.calculate.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: AppColor.white),
                            ))
                      ],
                    ),
                    Divider(height: 25, thickness: 1.5),

                    ///next Plan
                    SizedBox(height: 15.0),
                    Text(AppString.nextPlan.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: AppColor.black)),
                    const SizedBox(height: 15.0),
                    BlocBuilder(
                      bloc: plannerCubitCalculate,
                      builder: (_, state) {
                        if (state is QuranPlannerInitialState)
                          return SizedBox.shrink();
                        if (state is QuranPlannerErrorState) return ErrorText();
                        if (state is QuranPlannerLoadingState)
                          return WidgetLoading();
                        if (state is QuranPlannerSuccessStatePlanner) {
                          final planner = state.quranPlanner;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildPlan(
                                  namazName: AppString.fajar,
                                  value: planner.fajarPlan.toString()),
                              buildPlan(
                                  namazName: AppString.zohar,
                                  value: planner.zohrPlan.toString()),
                              buildPlan(
                                  namazName: AppString.asr,
                                  value: planner.asarPlan.toString()),
                              buildPlan(
                                  namazName: AppString.magrib,
                                  value: planner.magribPlan.toString()),
                              buildPlan(
                                  namazName: AppString.isha,
                                  value: planner.ishaaPlan.toString()),
                            ],
                          );
                        }
                        return ErrorText();
                      },
                    ),
                    const SizedBox(height: 25.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: AppColor.darkPink),
                        onPressed: () {
                          ///calling getQuranPlanner as it is called in initState
                          plannerCubit.getQuranPlanner(
                              number:
                                  context.read<StoredAuthStatus>().authNumber);

                          ///reset State of nextPlan
                          plannerCubitCalculate
                              .emit(const QuranPlannerInitialState());
                        },
                        child: Text(
                          AppString.upDatePlan.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: AppColor.white),
                        )),
                    //Text(),
                  ],
                ),
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
