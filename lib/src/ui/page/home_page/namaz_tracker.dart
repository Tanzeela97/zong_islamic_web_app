import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:zong_islamic_web_app/src/cubit/salah_tracker_cubit/salah_tracker_cubit.dart';
import 'package:zong_islamic_web_app/src/resource/repository/salah_tracker_repository.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/namaz_provider/namaz_provider.dart';
import 'package:zong_islamic_web_app/src/ui/widget/error_text.dart';
import 'package:zong_islamic_web_app/src/ui/widget/namaz_missed_row.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';

import 'Calender/calendar_carousel.dart';
import 'namaz_selection.dart';

class NamazTracker extends StatefulWidget {
  const NamazTracker({Key? key}) : super(key: key);

  @override
  _NamazTrackerState createState() => _NamazTrackerState();
}

class _NamazTrackerState extends State<NamazTracker> {
  final SalahTrackerCubit trackerCubit = SalahTrackerCubit(
      salahTrackerRepository: SalahTrackerRepository.getInstance()!);
  final SalahTrackerCubit trackerCubitUpDate = SalahTrackerCubit(
      salahTrackerRepository: SalahTrackerRepository.getInstance()!);

  @override
  void initState() {
    trackerCubit.getSalahTracker(number: '923128863374');
    super.initState();
  }

  int trackIndex = 0;

  static setEnumFavourite(WhyFarther enumFavourite) =>
      enumFavourite == WhyFarther.notOffered;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WidgetAppBar(title: 'Namaz Tracker'),
      body: SafeArea(
        child: BlocBuilder<SalahTrackerCubit, SalahTrackerState>(
          bloc: trackerCubit,
          builder: (_, state) {
            if (state is SalahTrackerLoading) {
              return Center(child: Text('Loading'));
            }
            if (state is SalahTrackerError) {
              return const ErrorText();
            }
            if (state is SalahTrackerSuccessGet) {
              final SplitDate = state.salahTracker[trackIndex].date!.split('-');
              final salah = state.salahTracker[trackIndex];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 8.0),
                    child: Row(
                      children: [
                        Text(
                          'Set Namaz',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                              color: AppColor.blackTextColor,
                              fontStyle: FontStyle.italic),
                        ),
                        const Spacer(),
                        Text(
                          '${SplitDate[0]}-${Month.values
                              .elementAt(int.parse(SplitDate[1]) - 1)
                              .name}-${SplitDate[2]}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                              color: AppColor.blackTextColor,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),

                  ///listTile
                  ///fajar
                  ListTile(
                      title: Text(AppString.fajar.toUpperCase(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                              color:
                              setEnumFavourite(WhyFarther.values[salah.fujr!])
                                  ? AppColor.blackTextColor
                                  : AppColor.whiteTextColor)),
                      tileColor:
                      WhyFarther.values[salah.fujr!] == WhyFarther.offered
                          ? Colors.pink[300]
                          : AppColor.lightGrey,
                      onTap: () {
                        setState(() {
                          if (setEnumFavourite(
                              WhyFarther.values[salah.fujr!])) {
                            salah.fujr = 1;
                          } else {
                            salah.fujr = 0;
                          }
                        });
                      },
                      trailing: Text(
                          WhyFarther.values[salah.fujr!] == WhyFarther.offered
                              ? WhyFarther.offered.name
                              : WhyFarther.notOffered.name,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                              color:
                              setEnumFavourite(WhyFarther.values[salah.fujr!])
                                  ? AppColor.blackTextColor
                                  : AppColor.whiteTextColor))),
                  const SizedBox(height: 2),

                  ///zohr
                  ListTile(
                      title: Text(AppString.zohar.toUpperCase(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                              color:
                              setEnumFavourite(WhyFarther.values[salah.zuhr!])
                                  ? AppColor.blackTextColor
                                  : AppColor.whiteTextColor)),
                      tileColor:
                      WhyFarther.values[salah.zuhr!] == WhyFarther.offered
                          ? Colors.pink[300]
                          : AppColor.lightGrey,
                      onTap: () {
                        setState(() {
                          if (setEnumFavourite(
                              WhyFarther.values[salah.zuhr!])) {
                            salah.zuhr = 1;
                          } else {
                            salah.zuhr = 0;
                          }
                        });
                      },
                      trailing: Text(
                          WhyFarther.values[salah.zuhr!] == WhyFarther.offered
                              ? WhyFarther.offered.name
                              : WhyFarther.notOffered.name,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                              color:
                              setEnumFavourite(WhyFarther.values[salah.zuhr!])
                                  ? AppColor.blackTextColor
                                  : AppColor.whiteTextColor))),
                  const SizedBox(height: 2),

                  ///asar
                  ListTile(
                      title: Text(AppString.asr.toUpperCase(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                              color:
                              setEnumFavourite(WhyFarther.values[salah.asr!])
                                  ? AppColor.blackTextColor
                                  : AppColor.whiteTextColor)),
                      tileColor:
                      WhyFarther.values[salah.asr!] == WhyFarther.offered
                          ? Colors.pink[300]
                          : AppColor.lightGrey,
                      onTap: () {
                        setState(() {
                          if (setEnumFavourite(
                              WhyFarther.values[salah.asr!])) {
                            salah.asr = 1;
                          } else {
                            salah.asr = 0;
                          }
                        });
                      },
                      trailing: Text(
                          WhyFarther.values[salah.asr!] == WhyFarther.offered
                              ? WhyFarther.offered.name
                              : WhyFarther.notOffered.name,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                              color:
                              setEnumFavourite(WhyFarther.values[salah.asr!])
                                  ? AppColor.blackTextColor
                                  : AppColor.whiteTextColor))),
                  const SizedBox(height: 2),

                  ///mabrib
                  ListTile(
                      title: Text(AppString.magrib.toUpperCase(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                              color:
                              setEnumFavourite(WhyFarther.values[salah
                                  .maghrib!])
                                  ? AppColor.blackTextColor
                                  : AppColor.whiteTextColor)),
                      tileColor:
                      WhyFarther.values[salah.maghrib!] == WhyFarther.offered
                          ? Colors.pink[300]
                          : AppColor.lightGrey,
                      onTap: () {
                        setState(() {
                          if (setEnumFavourite(
                              WhyFarther.values[salah.maghrib!])) {
                            salah.maghrib = 1;
                          } else {
                            salah.maghrib = 0;
                          }
                        });
                      },
                      trailing: Text(
                          WhyFarther.values[salah.maghrib!] ==
                              WhyFarther.offered
                              ? WhyFarther.offered.name
                              : WhyFarther.notOffered.name,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                              color:
                              setEnumFavourite(WhyFarther.values[salah
                                  .maghrib!])
                                  ? AppColor.blackTextColor
                                  : AppColor.whiteTextColor))),
                  const SizedBox(height: 2),

                  ///isha
                  ListTile(
                      title: Text(AppString.isha.toUpperCase(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                              color:
                              setEnumFavourite(WhyFarther.values[salah.isha!])
                                  ? AppColor.blackTextColor
                                  : AppColor.whiteTextColor)),
                      tileColor:
                      WhyFarther.values[salah.isha!] == WhyFarther.offered
                          ? Colors.pink[300]
                          : AppColor.lightGrey,
                      onTap: () {
                        setState(() {
                          if (setEnumFavourite(
                              WhyFarther.values[salah.isha!])) {
                            salah.isha = 1;
                          } else {
                            salah.isha = 0;
                          }
                        });
                      },
                      trailing: Text(
                          WhyFarther.values[salah.isha!] == WhyFarther.offered
                              ? WhyFarther.offered.name
                              : WhyFarther.notOffered.name,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                              color:
                              setEnumFavourite(WhyFarther.values[salah.isha!])
                                  ? AppColor.blackTextColor
                                  : AppColor.whiteTextColor))),

                  BlocListener<SalahTrackerCubit, SalahTrackerState>(
                    bloc: trackerCubitUpDate,
                    listener: (_, state) {
                      if (state is SalahTrackerSuccess) {
                        trackerCubit.getSalahTracker(number: context.read<StoredAuthStatus>().authNumber);
                      }
                      if (state is SalahTrackerError) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Error')));
                      }
                      if (state is SalahTrackerLoading) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('upDating Namaz')));
                      }
                    },
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: AppColor.darkPink),
                        onPressed: () {
                          trackerCubitUpDate.postSalahTracker(
                              number: context.read<StoredAuthStatus>().authNumber,
                              asr: salah.asr!,
                              fajar: salah.fujr!,
                              isha: salah.isha!,
                              magrib: salah.maghrib!,
                              zohr: salah.zuhr!,
                              date: salah.date!);
                        },
                        child: Text('Update',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: AppColor.whiteTextColor))),
                  ),
                  Text(
                    'Namaz History',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline3,
                  ),
                  Divider(
                      indent: 32,
                      endIndent: 32,
                      thickness: 1,
                      color: AppColor.darkPink),
                  Expanded(
                    child: ListView.builder(
                        itemCount: state.salahTracker.length,
                        itemBuilder: (_, index) {
                          final SplitDate =
                          state.salahTracker[index].date!.split('-');
                          return Card(
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    trackIndex = index;
                                  });
                                },
                                title: Wrap(
                                  children: [
                                    Text(
                                        '${SplitDate[0]}-${Month.values
                                            .elementAt(int.parse(SplitDate[1]) - 1)
                                            .name}-${SplitDate[2]}'),
                                    Text('   (${state.salahTracker[index]
                                        .islamicDate!})',style: Theme.of(context).textTheme.bodyText1,),
                                  ],
                                ),
                              ));

                        }),
                  ),
                ],
              );
            }

            return const ErrorText();
          },
        ),
      ),
    );
  }
}

enum WhyFarther { notOffered, offered }

enum Month {
  January,
  February,
  March,
  April,
  May,
  June,
  July,
  August,
  September,
  October,
  November,
  December
}
