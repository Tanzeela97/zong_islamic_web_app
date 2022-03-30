import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';

class VoiceCommandSearch extends StatefulWidget {
  Function(String words) searchedWords;

  VoiceCommandSearch(this.searchedWords);

  @override
  _VoiceCommandSearchState createState() => _VoiceCommandSearchState();
}

class _VoiceCommandSearchState extends State<VoiceCommandSearch> {
  bool _hasSpeech = false;
  bool _logEvents = false;

  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  Future<void> initSpeechState() async {
    try {
      var hasSpeech = await speech.initialize(
        debugLogging: true,
      );
      if (hasSpeech) {
        // Get the list of languages installed on the supporting platform so they
        // can be displayed in the UI for selection by the user.
        _localeNames = await speech.locales();

        var systemLocale = await speech.systemLocale();
        _currentLocaleId = systemLocale?.localeId ?? '';
        _currentLocaleId = "ur_PK";
      }
      if (!mounted) return;

      setState(() {
        _hasSpeech = hasSpeech;
      });
    } catch (e) {
      setState(() {
        lastError = 'Speech recognition failed: ${e.toString()}';
        _hasSpeech = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: AvatarGlow(
        animate: _isListening,
        glowColor: AppColor.greenAppBarColor,
        endRadius: 200.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: GestureDetector(
          onLongPress: startListening,
          onLongPressEnd: (val) {
            startListening();
          },
          //onPressed: startListening,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none, size: 25),
        ),
      ),
    );
  }

  void startListening() {
    if (!_isListening) {
      print("start listening");
      lastWords = '';
      lastError = '';
      setState(() => _isListening = true);
      speech.listen(
          onResult: resultListener,
          listenFor: Duration(seconds: 5),
          partialResults: true,
          localeId: _currentLocaleId,
          cancelOnError: true,
          listenMode: ListenMode.confirmation);
      setState(() {});
    } else {
      print("stop listening");
      setState(() => _isListening = false);
      speech.stop();
      widget.searchedWords(lastWords);
    }
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = '${result.recognizedWords}';
    });
  }
}




