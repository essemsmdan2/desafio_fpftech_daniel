import 'package:desafio_fpftech_daniel/src/screens/feed_screen/feed_screen.dart';
import 'package:desafio_fpftech_daniel/src/screens/home_screen/home_controller.dart';
import 'package:desafio_fpftech_daniel/src/screens/home_screen/widget/qr_code_widget.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late HomePageController _controller;

  @override
  void initState() {
    _controller = HomePageController();
    _controller.initSpeech();
    _controller.textController = TextEditingController(text: 'FlutterDev');
    super.initState();
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
                _textField(_controller.textController),
                const SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  _iconHandler(icon: Icons.mic, function: _controller.startListening),
                  SizedBox(
                    width: 15,
                  ),
                  QrCodeButton()
                ]),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () => _controller.textController.text.isNotEmpty
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeedScreen(
                                      subreddit: _controller.textController.text.trim(),
                                    )),
                          )
                        : () {},
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

Widget _textField(controller) {
  return TextField(
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Digite a Subreddit',
    ),
    controller: controller,
  );
}
