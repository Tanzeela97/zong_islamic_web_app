import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:zong_islamic_web_app/src/cubit/mufti_cubit/mufti_cubit.dart';
import 'package:zong_islamic_web_app/src/resource/repository/mufti_repositroy.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';

class MuftiView extends StatefulWidget {
  const MuftiView({Key? key}) : super(key: key);
  static const _height = 200.0;
  static const _width = 200.0;

  @override
  State<MuftiView> createState() => _MuftiViewState();
}

class _MuftiViewState extends State<MuftiView> with WidgetsBindingObserver {
  final MuftiCubit muftiCubit = MuftiCubit(MuftiRepository.getInstance()!);
  late AudioPlayer _player;
  late StreamSubscription _streamSubscription;
  StreamSubscription? _recorderSubscription;
  late FlutterSoundRecorder? _myRecorder = FlutterSoundRecorder();
  late String filePath;
  String _recorderTxt = '00:00:00';
  bool isListening = false;
  late final TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    _player = AudioPlayer();

    ///api calling....
    muftiCubit.getAllQirat(number: '3142006707');

    ///streamSubs
    _streamSubscription = _player.sequenceStateStream.listen((event) {
      print('audio event $event');
    });

    startIt();
    muftiCubit.stream.listen((state) {
      if (state is QiratSuccessState) {
        muftiCubit.getAllQirat(
            number: context.read<StoredAuthStatus>().authNumber);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    print('dispose called audio');
    muftiCubit.close();
    _streamSubscription.cancel();
    _recorderSubscription!.cancel();
    _player.stop();
    super.dispose();
  }
  int trackIndex = 0;
  int trackIndexTwo = 0;
  void audioFromUrl(BuildContext context, String url) async {
    await _player.stop();
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(
          'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3')));

    } catch (e) {
      //todo show error toast
      print("Error loading audio source: $e");
    }
    await _player.play();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  Widget _listTile(
          {required String fileName,
          required bool isAnswer,
          required String questionSource,
          required String answerSource,required int index}) =>
      ListTile(
        tileColor: AppColor.lightGrey,
        title: Text(fileName),
        trailing: Wrap(
          children: [
            /// recorded sawal
            GestureDetector(
              onTap: () {
                _player.playing
                    ? _player.pause()
                    : audioFromUrl(context, questionSource);
              },
              child: Image(
                  image: _player.playing
                      ? ImageResolver.play
                      : ImageResolver.pause,
                  height: 35),
            ),
            SizedBox(width: 90),

            ///  jawan from api
            GestureDetector(
              onTap: isAnswer
                  ? () {
                      audioFromUrl(context, answerSource);
                    }
                  : null,
              child: Image(
                  image: isAnswer
                      ? ImageResolver.muftiPink
                      : ImageResolver.muftiGrey,
                  height: 35),
            ),
            SizedBox(width: 10),
          ],
        ),
      );

  ///audio recorder
  void startIt() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyyMMdd kk:mm:ss').format(now);
    filePath =
        '/storage/emulated/0/zong/${context.read<StoredAuthStatus>().authNumber}_VXT_Mufti_APP_Q_${formattedDate}.wav';
    await _myRecorder!.openAudioSession(
        focus: AudioFocus.requestFocusAndStopOthers,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);
    await _myRecorder!
        .setSubscriptionDuration(const Duration(milliseconds: 10));
    await initializeDateFormatting();

    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  Future<void> record() async {
    Directory dir = Directory(path.dirname(filePath));
    if (!dir.existsSync()) {
      dir.createSync();
    }
    _myRecorder!.openAudioSession();
    await _myRecorder!.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
    );
    _recorderSubscription = _myRecorder!.onProgress!.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
          isUtc: true);
      var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
      print("time:: ${e}");
      setState(() {
        filePath = filePath;
        _recorderTxt = txt.substring(0, 8);
      });
    });

    setState(() {});
  }

  Future<String?> stopRecord() async {
    //  _myRecorder!.closeAudioSession();

    showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context,
            StateSetter setter /*You can rename this!*/) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            " Save Recording",
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontSize: 20,
                                    color: AppColor.greenAppBarColor,
                                    fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            child: TextField(
                              cursorColor: AppColor.darkPink,
                              keyboardType: TextInputType.text,
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                " Discard",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        fontSize: 20,
                                        color: AppColor.blackTextColor,
                                        fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                muftiCubit.uploadQirat(
                                    number: context
                                        .read<StoredAuthStatus>()
                                        .authNumber,
                                    filePath: filePath,
                                    fileName: editingController.text);
                                setState(() {
                                  _recorderTxt = "00:00:00";
                                  editingController.text = "";
                                });
                              },
                              child: Text(
                                "Save",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        fontSize: 20,
                                        color: AppColor.blackTextColor,
                                        fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
    return await _myRecorder!.stopRecorder();
  }



  @override
  Widget build(BuildContext context) {
    //return MyApp();
    return Scaffold(
      appBar: WidgetAppBar(title: AppString.muftiSeSawalat),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 35),
          Text(
              isListening
                  ? AppString.tapHereToStop.toUpperCase()
                  : AppString.tapHereToRecord.toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: AppColor.blackTextColor, fontSize: 26)),
          const SizedBox(height: 25),
          GestureDetector(
            onTap: () {
              if (isListening) {
                setState(() {
                  isListening = false;
                });
                stopRecord();
              } else {
                setState(() {
                  isListening = true;
                });
                record();
              }
            },
            child: Image(
                image: isListening
                    ? ImageResolver.stopRecording
                    : ImageResolver.playRecording,
                height: MuftiView._height),
          ),
          const SizedBox(height: 25),
          Text(_recorderTxt,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 34, fontWeight: FontWeight.w400)),
          const SizedBox(height: 25),
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColor.darkPink, width: 2),
                bottom: BorderSide(color: AppColor.darkPink, width: 2),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 60,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Text(
                      AppString.title,
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 24),
                    ),
                    decoration: BoxDecoration(
                        color: AppColor.darkPink,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0))),
                  ),
                ),
                Expanded(
                    child: Text(
                  AppString.sawalat,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: AppColor.pinkTextColor, fontSize: 18.0),
                )),
                VerticalDivider(),
                Expanded(
                    child: Text(
                  AppString.jawabat,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: AppColor.pinkTextColor, fontSize: 18.0),
                )),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          //        _listTile(),
          BlocBuilder<MuftiCubit, MuftiState>(
              bloc: muftiCubit,
              builder: (_, state) {
                if (state is MuftiInitialState) return const SizedBox.shrink();
                if (state is MuftiLoadingState) return const WidgetLoading();
                if (state is MuftiSuccessState) {
                  return Expanded(
                      child: ListView.builder(
                    itemCount: state.mufti.data!.length,
                    itemBuilder: (_, index) {
                      final mufti = state.mufti.data![index];
                      // var split = mufti.filename!.split("_");
                      // print("${split.toString()}");
                      return _listTile(
                          fileName: mufti.filename!,
                          isAnswer: EnumMuftiAnswer.values[mufti.isAnswered!] ==
                              EnumMuftiAnswer.answered,
                          answerSource: mufti.answer!,
                          questionSource: mufti.url!,index:index);
                    },
                  ));
                }
                if (state is MuftiErrorState) return const WidgetLoading();
                return const WidgetLoading();
              }),
        ],
      ),
    );
  }
}

enum EnumMuftiAnswer { notAnswered, answered }
