// ignore_for_file: unused_element, prefer_final_fields, avoid_print

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePageController {
  TextEditingController textController = TextEditingController(text: 'FlutterDev');
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    print(_speechEnabled);
  }

  void startListening() async {
    if (_speechEnabled) {
      await _speechToText.listen(onResult: onSpeechResult);
    } else {
      print('não inicializado');
    }
  }

  void stopListening() async {
    await _speechToText.stop();
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    textController.text = result.recognizedWords;
  }
}
