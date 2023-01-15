import 'package:desafio_fpftech_daniel/src/screens/feed_screen/feed_screen.dart';
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

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    print(_speechEnabled);
    setState(() {});
  }

  void _startListening() async {
    if (_speechEnabled) {
      await _speechToText.listen(onResult: _onSpeechResult);
    } else {
      print('não inicializado');
    }

    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

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
<<<<<<< Updated upstream
                    onPressed: (() => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeedScreen(
                                    subreddit: _controller.text,
                                  )),
                        )),
=======
                    onPressed: () => _controller.text.isNotEmpty
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeedScreen(
                                      subreddit: _controller.text.trim(),
                                    )),
                          )
                        : () {},
>>>>>>> Stashed changes
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
