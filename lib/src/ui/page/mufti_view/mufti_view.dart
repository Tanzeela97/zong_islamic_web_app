import 'dart:async';
import 'dart:io';
import 'package:flash/flash.dart';
import 'package:audio_session/audio_session.dart' as sessionD;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart' as sound;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zong_islamic_web_app/src/cubit/mufti_cubit/mufti_cubit.dart';
import 'package:zong_islamic_web_app/src/resource/repository/mufti_repositroy.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/resource/utility/common.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/widget/error_text.dart';
import 'package:zong_islamic_web_app/src/ui/widget/k_decoratedScaffold.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class MuftiView extends StatefulWidget {
  const MuftiView({Key? key}) : super(key: key);
  static const _height = 200.0;
  static const _width = 200.0;

  @override
  State<MuftiView> createState() => _MuftiViewState();
}

class _MuftiViewState extends State<MuftiView> with WidgetsBindingObserver {
  final MuftiCubit muftiCubit = MuftiCubit(MuftiRepository.getInstance()!);
  final MuftiCubit muftiCubitUpload =
      MuftiCubit(MuftiRepository.getInstance()!);
  late AudioPlayer _player;

  StreamSubscription? _recorderSubscription;
  late sound.FlutterSoundRecorder? _myRecorder = sound.FlutterSoundRecorder();
  late String filePath;
  String _recorderTxt = '00:00:00';
  bool isListening = false;
  final TextEditingController editingController = TextEditingController();

  Future<void> _init() async {
    final session = await sessionD.AudioSession.instance;
    await session.configure(sessionD.AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    _player = AudioPlayer();
    _init();

    ///api calling....get all qirat
    muftiCubit.getAllQirat(number: context.read<StoredAuthStatus>().authNumber);

    startIt();
    muftiCubitUpload.stream.listen((state) {
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
    _recorderSubscription!.cancel();
    _player.stop();
    super.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  void audioFromUrl(BuildContext context, String url) async {
    var completer = Completer();
    context.showBlockDialog(dismissCompleter: completer);
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(url)));
      //await _player.setAsset('assets/tempOne.wav');
      _player.play();

      showModalBottomSheet(
          backgroundColor: AppColor.transparent,
          context: context,
          builder: (_) => Container(
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: AppColor.mainColor),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: _ControlButtons(_player)),
                    Expanded(
                      flex: 2,
                      child: StreamBuilder<PositionData>(
                        stream: _positionDataStream,
                        builder: (context, snapshot) {
                          final positionData = snapshot.data;
                          return SeekBar(
                            duration: positionData?.duration ?? Duration.zero,
                            position: positionData?.position ?? Duration.zero,
                            bufferedPosition:
                                positionData?.bufferedPosition ?? Duration.zero,
                            onChangeEnd: (newPosition) {
                              _player.seek(newPosition);
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              )).then((value) => _player.stop());
    } catch (e) {
      //todo show error toast
      print("Error loading audio source: $e");
    }
    completer.complete();
    //   await _player.play();
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
          required String answerSource,
          required int index}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: ListTile(
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
                child: Image(image: ImageResolver.play, height: 35),
              ),
              SizedBox(width: 90),
              ///  jawan from api
              GestureDetector(
                onTap: isAnswer
                    ? () {
                        audioFromUrl(context, answerSource);
                      }
                    : () async {
                        await showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.close))
                                  ],
                                ),
                                content: Text(
                                  'Mufti k Jawab k liye inteezar farmiye !',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: AppColor.grey),
                                ),
                              );
                            });
                      },
                child: Image(
                    image: isAnswer
                        ? ImageResolver.muftiPink
                        : ImageResolver.muftiGrey,
                    height: 35),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      );

  ///audio recorder
  void startIt() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyyMMddkkmmss').format(now);
    filePath =
        '/storage/emulated/0/zong/${context.read<StoredAuthStatus>().authNumber}_VXT_Mufti_APP_Q_${formattedDate}.wav';
    await _myRecorder!.openAudioSession(
        focus: sound.AudioFocus.requestFocusAndStopOthers,
        category: sound.SessionCategory.playAndRecord,
        mode: sound.SessionMode.modeDefault,
        device: sound.AudioDevice.speaker);
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
      codec: sound.Codec.pcm16WAV,
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
              width: 300,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    " Save Recording",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppColor.greenAppBarColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    cursorColor: AppColor.darkPink,
                    keyboardType: TextInputType.text,
                    controller: editingController,
                    decoration: InputDecoration(
                      // contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      hintText: 'enter file name',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(" Discard",
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
                              thickness: 0.5, color: AppColor.black)),
                      TextButton(
                          onPressed: () {
                            muftiCubitUpload.uploadQirat(
                                number:
                                    context.read<StoredAuthStatus>().authNumber,
                                filePath: filePath,
                                fileName: editingController.text);
                            setState(() {
                              _recorderTxt = "00:00:00";
                              editingController.text = "";
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            " Save",
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
                  // Container(
                  //   child: Column(
                  //     children: [
                  //       Container(
                  //         child: Text(
                  //           " Save Recording",
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .headline1!
                  //               .copyWith(
                  //                   fontSize: 20,
                  //                   color: AppColor.greenAppBarColor,
                  //                   fontWeight: FontWeight.bold),
                  //           textAlign: TextAlign.left,
                  //         ),
                  //       ),
                  //       SizedBox(height: 20),
                  //       Center(
                  //         child: Container(
                  //           margin: EdgeInsets.all(10.0),
                  //           child: TextField(
                  //             cursorColor: AppColor.darkPink,
                  //             keyboardType: TextInputType.text,
                  //             controller: editingController,
                  //             decoration: InputDecoration(
                  //                 border: OutlineInputBorder(
                  //                     borderSide:
                  //                         BorderSide(color: AppColor.darkPink)),
                  //                 focusedBorder: OutlineInputBorder(
                  //                     borderSide:
                  //                         BorderSide(color: AppColor.darkPink)),
                  //                 contentPadding: EdgeInsets.symmetric(
                  //                     vertical: 0, horizontal: 18.0)),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 20,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           GestureDetector(
                  //             onTap: () {
                  //               Navigator.pop(context);
                  //             },
                  //             child: Text(
                  //               " Discard",
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .headline1!
                  //                   .copyWith(
                  //                       fontSize: 20,
                  //                       color: AppColor.blackTextColor,
                  //                       fontWeight: FontWeight.bold),
                  //               textAlign: TextAlign.left,
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             width: 20,
                  //           ),
                  //           GestureDetector(
                  //             onTap: () {
                  //               Navigator.pop(context);
                  //               muftiCubit.uploadQirat(
                  //                   number: context
                  //                       .read<StoredAuthStatus>()
                  //                       .authNumber,
                  //                   filePath: filePath,
                  //                   fileName: editingController.text);
                  //               setState(() {
                  //                 _recorderTxt = "00:00:00";
                  //                 editingController.text = "";
                  //               });
                  //             },
                  //             child: Text(
                  //               "Save",
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .headline1!
                  //                   .copyWith(
                  //                       fontSize: 20,
                  //                       color: AppColor.blackTextColor,
                  //                       fontWeight: FontWeight.bold),
                  //               textAlign: TextAlign.left,
                  //             ),
                  //           ),
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: Transform.scale(
          scale: 1.5,
          child: FloatingActionButton(
              backgroundColor: AppColor.transparent,
              elevation: 0.0,
              onPressed: () {
                UrlLauncher.launch("tel://786");
              },
              child: Image(image: ImageResolver.Talktomufti, height: 75)),
        ),
      ),
      appBar: WidgetAppBar(title: AppString.muftiSeSawalat),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: AppColor.white,
              child: Column(
                children: [
                  const SizedBox(height: 35),
                  Text(
                      isListening
                          ? AppString.tapHereToStop.toUpperCase()
                          : AppString.tapHereToRecord.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppColor.black, fontSize: 22)),
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
                                  .copyWith(fontSize: 18.0),
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
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: AppColor.pinkTextColor, fontSize: 18.0),
                        )),
                        VerticalDivider(),
                        Expanded(
                            child: Text(
                          AppString.jawabat,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: AppColor.pinkTextColor, fontSize: 18.0),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
            //        _listTile(),
            Expanded(
              child: BlocBuilder<MuftiCubit, MuftiState>(
                  bloc: muftiCubit,
                  builder: (_, state) {
                    if (state is MuftiInitialState)
                      return const SizedBox.shrink();
                    if (state is MuftiLoadingState) return const WidgetLoading();
                    if (state is MuftiSuccessState) {
                      if (state.mufti.data!.isEmpty) {
                        return Center(child: Text('No! records Found'));
                      }
                      return ListView.builder(
                        itemCount: state.mufti.data!.length,
                        itemBuilder: (_, index) {
                          final mufti = state.mufti.data![index];
                          var split = mufti.filename!.split("_");
                          print("${split.toString()}");
                          return _listTile(
                              fileName: split[1],
                              isAnswer:
                                  EnumMuftiAnswer.values[mufti.isAnswered!] ==
                                      EnumMuftiAnswer.answered,
                              answerSource: mufti.answer!,
                              questionSource: mufti.url!,
                              index: index);
                        },
                      );
                    }
                    if (state is MuftiErrorState) return const WidgetLoading();
                    return const ErrorText();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

enum EnumMuftiAnswer { notAnswered, answered }

class _ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const _ControlButtons(this.player);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Align(child: CircularProgressIndicator());
        } else if (playing != true) {
          return GestureDetector(
              onTap: player.play,
              child: Image(image: ImageResolver.play, height: 48));
          return IconButton(
            icon: Icon(Icons.play_arrow, color: AppColor.darkPink),
            iconSize: 64.0,
            onPressed: player.play,
          );
        } else if (processingState != ProcessingState.completed) {
          return GestureDetector(
              onTap: player.pause,
              child: Image(image: ImageResolver.pause, height: 48));
          return IconButton(
            icon: Icon(Icons.pause, color: AppColor.darkPink),
            iconSize: 64.0,
            onPressed: player.pause,
          );
        } else {
          return IconButton(
            icon: Icon(Icons.replay, color: AppColor.darkPink),
            iconSize: 64.0,
            onPressed: () => player.seek(Duration.zero,
                index: player.effectiveIndices!.first),
          );
        }
      },
    );
  }
}
