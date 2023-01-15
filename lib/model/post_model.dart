import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

String url = 'https://www.reddit.com';

Future<List<Posts>> fetchPosts(http.Client client, String permalink) async {
  final response = await client.get(Uri.parse("$url$permalink.json"));
  return compute(parsePosts, response.body);
}

List<Posts> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody)[0]['data']['children'].cast<Map<String, dynamic>>();

  return parsed.map<Posts>((json) => Posts.fromJson(json['data'])).toList();
}

class Posts {
  final String author;
  final String url;
  final String thumbnail;
  final String title;
  final String selftext;
  final String score;
  final String numComments;
  Posts(
      {required this.thumbnail,
      required this.score,
      required this.numComments,
      required this.selftext,
      required this.author,
      required this.url,
      required this.title});

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      score: json['score'].toString(),
      numComments: json['num_comments'].toString(),
      thumbnail: json['thumbnail'] ?? "",
      title: json['title'] ?? "",
      selftext: json['selftext'] ?? "",
      author: json['author'] ?? "",
      url: json['url_overridden_by_dest'] ?? "",
    );
  }
}
