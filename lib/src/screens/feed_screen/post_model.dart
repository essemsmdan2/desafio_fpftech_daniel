import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

String url = 'https://www.reddit.com';

Future<List<Posts>> fetchPosts(http.Client client, topic) async {
  final response = await client.get(Uri.parse("$url/r/$topic/hot.json"));

  return compute(parsePosts, response.body);
}

List<Posts> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody)['data']['children'].cast<Map<String, dynamic>>();

  return parsed.map<Posts>((json) => Posts.fromJson(json['data'])).toList();
}

class Posts {
  final String title;
  final String author;
  final String score;
  final int num_comments;
  final String thumbnail;

  Posts(
      {required this.title,
      required this.author,
      required this.num_comments,
      required this.thumbnail,
      required this.score});

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
        title: json['title'],
        thumbnail: json['thumbnail'],
        num_comments: json['num_comments'],
        author: json['author'],
        score: json['score'].toString());
  }
}
