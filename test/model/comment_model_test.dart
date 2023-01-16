// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:desafio_fpftech_daniel/model/comment_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  _myRecursivePrint(Comments item) {
    if (item.replies != null && item.replies != '-1' && item.replies != "") {
      print(item.author);
      print(item.body.length);
      _myRecursivePrint(Comments.commentReply(item));
    } else {
      print(item.author);
      print(item.body);
    }
  }

  test('comment model ...', () async {
    final List<Comments> comments = await fetchComments(http.Client(), _permalink);

    // print(comments[0].author);
    _myRecursivePrint(comments[0]);
  });
}

String _permalink = '/r/FlutterDev/comments/107o8zf/app_feedback_thread_january_09_2023/';
