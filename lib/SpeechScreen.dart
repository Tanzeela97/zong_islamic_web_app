import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

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
    return AvatarGlow(
      animate: _isListening,
      glowColor: Theme.of(context).primaryColor,
      endRadius: 75.0,
      duration: const Duration(milliseconds: 2000),
      repeatPauseDuration: const Duration(milliseconds: 100),
      repeat: true,
      child: FloatingActionButton(
        onPressed: startListening,
        child: Icon(_isListening ? Icons.mic : Icons.mic_none),
      ),
    );
    return MaterialApp(
      home: Scaffold(
        body: AvatarGlow(
          animate: _isListening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 75.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            onPressed: startListening,
            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
          ),
        ),
        // Column(children: [
        //   Container(
        //     child: Column(
        //       children: <Widget>[
        //         AvatarGlow(
        //           animate: _isListening,
        //           glowColor: Theme.of(context).primaryColor,
        //           endRadius: 75.0,
        //           duration: const Duration(milliseconds: 2000),
        //           repeatPauseDuration: const Duration(milliseconds: 100),
        //           repeat: true,
        //           child: FloatingActionButton(
        //             onPressed: startListening,
        //             child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        //   Expanded(
        //     flex: 4,
        //     child: RecognitionResultsWidget(lastWords: lastWords, level: level),
        //   ),
        //   Expanded(
        //     flex: 1,
        //     child: ErrorWidget(lastError: lastError),
        //   ),
        // ]),
      ),
    );
  }

  void startListening() {
    if (!_isListening) {
      lastWords = '';
      lastError = '';
      setState(() => _isListening = true);
      speech.listen(
          onResult: resultListener,
          // listenFor: Duration(seconds: listenFor ?? 30),
          // pauseFor: Duration(seconds: pauseFor ?? 3),
          partialResults: true,
          localeId: _currentLocaleId,
          cancelOnError: true,
          listenMode: ListenMode.confirmation);
      setState(() {});
    } else {
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

class RecognitionResultsWidget extends StatelessWidget {
  const RecognitionResultsWidget({
    Key? key,
    required this.lastWords,
    required this.level,
  }) : super(key: key);

  final String lastWords;
  final double level;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            'Recognized Words',
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.amber,
                child: Center(
                  child: Text(
                    lastWords,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Speech recognition available',
        style: TextStyle(fontSize: 22.0),
      ),
    );
  }
}

/// Display the current error status from the speech
/// recognizer
class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key? key,
    required this.lastError,
  }) : super(key: key);

  final String lastError;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            'Error Status',
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        Center(
          child: Text(lastError),
        ),
      ],
    );
  }
}
