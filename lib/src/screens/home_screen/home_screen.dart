import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;

  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    print(_speechEnabled);
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    if (_speechEnabled) {
      await _speechToText.listen(onResult: _onSpeechResult);
    } else {
      print('não inicializado');
    }

    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _controller.text = result.recognizedWords;
    });
  }

  Widget _textField() {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Digite a Subreddit',
      ),
      controller: _controller,
    );
  }

  @override
  void initState() {
    _initSpeech();
    super.initState();
    _controller = TextEditingController(text: 'FlutterDev');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desafio - Feed Tecnologia'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 20,
                ),
                FractionallySizedBox(
                  widthFactor: 0.7,
                  child: Image.asset(
                    'images/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                _textField(),
                const SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  _iconHandler(icon: Icons.mic, function: _startListening),
                  SizedBox(
                    width: 15,
                  ),
                  _iconHandler(icon: Icons.qr_code, function: () => {}),
                ]),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () => {},
                    child: Text(
                      'Search',
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconHandler({required IconData icon, required Function() function}) {
    return GestureDetector(
      onTap: function,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.blueAccent,
        child: Icon(
          icon,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
