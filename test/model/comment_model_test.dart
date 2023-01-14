import 'dart:convert';

import 'package:desafio_fpftech_daniel/model/comment_model.dart';
import 'package:desafio_fpftech_daniel/model/feed_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('comment model ...', () async {
    final List<Comments> comments = await fetchComments(http.Client(), _permalink);
    print(comments[0].author);
    print(comments[0].score);
    print(comments[0].body);
  });
}

String _permalink = '/r/cat/comments/10b95uu/my_sassy_little_cat_she_has_no_manners/';
