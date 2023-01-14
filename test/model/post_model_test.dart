// ignore_for_file: avoid_print

import 'package:desafio_fpftech_daniel/model/post_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('comment model ...', () async {
    final List<Posts> comments = await fetchPosts(http.Client(), _permalink2);
    print(comments[0].author);
    print(comments[0].title);
    print(comments[0].selftext);
    print(comments[0].url);
    print(comments[0].thumbnail);
  });
}

String _permalink = '/r/FlutterDev/comments/107o8zf/app_feedback_thread_january_09_2023/';
String _permalink2 = '/r/cat/comments/10b766s/meet_roxanne/';
