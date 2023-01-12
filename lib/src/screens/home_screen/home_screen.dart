import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;
  Widget _textField() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Digite a Subreddit',
      ),
      controller: _controller,
    );
  }

  @override
  void initState() {
    _controller = TextEditingController(text: 'FlutterDev');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desafio - Feed Tecnologia'),
      ),
      body: Padding(
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
            ElevatedButton(
                onPressed: () => {},
                child: Text(
                  'Search',
                  style: TextStyle(fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
