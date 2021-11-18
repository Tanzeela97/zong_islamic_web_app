import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:zong_islamic_web_app/src/cubit/surah_cubit/surah_cubit.dart';
import 'package:zong_islamic_web_app/src/model/surah_wise.dart';
import 'package:zong_islamic_web_app/src/model/trending.dart';
import 'package:zong_islamic_web_app/src/resource/repository/surah_repository.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_empty_box.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';

import 'audio_config.dart';

class SurahWisePage extends StatefulWidget {
  final List<Trending> surah;

  const SurahWisePage(this.surah, {Key? key}) : super(key: key);

  @override
  State<SurahWisePage> createState() => _SurahWisePageState();
}

class _SurahWisePageState extends State<SurahWisePage> {
  String? dropdownValue;
  final surahCubit = SurahCubit(SurahRepository.getInstance()!);
  final AudioPlayer player = AudioPlayer();
  int surahNumber = 1;

  @override
  void initState() {
    dropdownValue = widget.surah.first.itemName!;
    surahCubit.getSurahByIdAndLang(int.parse(widget.surah.first.id!));

    super.initState();
  }

  @override
  void dispose() {
    surahCubit.close();
    player.dispose()
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PhysicalModel(
          color: Colors.white,
          elevation: 4.0,
          shadowColor: Colors.grey,
          child: SizedBox(
            height: 80,
            width: double.infinity,
            child: Row(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: widget.surah
                              .map<DropdownMenuItem<String>>((Trending value) {
                            return DropdownMenuItem<String>(
                              onTap: () {
                                if (widget.surah.contains(value)) {
                                  surahCubit.getSurahByIdAndLang(
                                      int.parse(value.id!));
                                  surahNumber = int.parse(value.id!);
                                }
                              },
                              value: value.itemName,
                              child: Text(value.itemName!),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                _PlayPause(
                    icon: Icons.play_arrow,
                    onPressed: () {
                      player.play();
                    }),
                const Spacer(),
                _PlayPause(
                    icon: Icons.pause,
                    onPressed: () {
                      player.pause();
                    }),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
        BlocBuilder<SurahCubit, SurahState>(
            bloc: surahCubit,
            builder: (context, state) {
              if (state is SurahInitial) {
                return const EmptySizedBox();
              } else if (state is SurahLoadingState) {
                return const WidgetLoading();
              } else if (state is SurahSuccessState) {
                return _SurahListUi(
                    state.arbiSurah, state.urduSurah, surahNumber, player);
              } else if (state is SurahErrorState) {
                return Text(state.message);
              } else {
                return const Text('failed');
              }
            }),
      ],
    );
  }
}

class _SurahListUi extends StatefulWidget {
  final List<SurahWise> arabicList;
  final List<SurahWise> urduList;
  final int surahNumber;
  final AudioPlayer player;

  const _SurahListUi(
      this.arabicList, this.urduList, this.surahNumber, this.player,
      {Key? key})
      : super(key: key);

  @override
  State<_SurahListUi> createState() => _SurahListUiState();
}

class _SurahListUiState extends State<_SurahListUi> {
  late final AudioConfiguration audioConfiguration;
  late final PageController pageController;
  int currentIndex = 0;
  ScrollController scroll = ScrollController();

  @override
  void initState() {
    pageController = PageController();
    audioConfiguration = AudioConfiguration(widget.player);
    playAudio();
    widget.player.playerStateStream.listen((snapshot) async {
      final playerState = snapshot;
      final processingState = playerState.processingState;
      final playing = playerState.playing;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        print(playing);
      } else if (processingState == ProcessingState.completed) {
        currentIndex++;
        print(currentIndex);
        playAudio();
        setState(() {});

        scroll.animateTo(currentIndex.toDouble() * 190,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
        //pageController.animateToPage(count++, duration: Duration(milliseconds: 500), curve: Curves.ease);
      }
    });
    super.initState();
  }

  playAudio() async {
    int updatedCurrentIndex = currentIndex + 1;

    String ayat = (updatedCurrentIndex < 10)
        ? "00$updatedCurrentIndex"
        : (updatedCurrentIndex < 100)
            ? "0$updatedCurrentIndex"
            : updatedCurrentIndex.toString();
    String surah = (widget.surahNumber < 10)
        ? "00${widget.surahNumber}"
        : (widget.surahNumber < 100)
            ? "0${widget.surahNumber}"
            : "${widget.surahNumber}";

    print('https://vp.vxt.net:31786/quran/audio/ar/ghamdi/$surah$ayat.mp3');
    await audioConfiguration
        .init('https://vp.vxt.net:31786/quran/audio/ar/ghamdi/$surah$ayat.mp3');
    await widget.player.play();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          controller: scroll,
          physics: const ClampingScrollPhysics(),
          itemCount: widget.arabicList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                setState(() {
                  currentIndex = index;
                });
                playAudio();
                //  pageController.animateToPage(index+1, duration: const Duration(milliseconds: 500), curve: Curves.ease);
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: AppColor.whiteTextColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[400]!, width: 0.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 0.75),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      widget.arabicList[index].ar,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: currentIndex == index
                              ? Colors.pink
                              : Colors.grey[600]!),
                      textAlign: TextAlign.center,
                    ),
                    Text(widget.urduList[index].ur,
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.grey[600]!),
                        textAlign: TextAlign.center),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Text(
                            'Surah:${widget.arabicList[index].surah}-Ayat:${widget.arabicList[index].ayat}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey[600]!),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class _PlayPause extends StatelessWidget {
  final void Function() onPressed;
  final IconData icon;

  const _PlayPause({Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: AppColor.greenTextColor),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: AppColor.whiteTextColor),
      ),
    );
  }
}
