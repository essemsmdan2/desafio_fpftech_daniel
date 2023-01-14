import 'package:desafio_fpftech_daniel/src/screens/feed_screen/feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:desafio_fpftech_daniel/src/screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'home',
      routes: {
        'home': (context) => const MyHomePage(),
        'feed': (context) => FeedScreen(
              subreddit: '',
            ),
      },
    );
  }
}
