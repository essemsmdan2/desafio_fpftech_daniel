import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

String url = 'https://www.reddit.com';

Future<List<Feed>> fetchFeed(http.Client client, topic) async {
  final response = await client.get(Uri.parse("$url/r/$topic/hot.json"));

  return compute(parseFeeds, response.body);
}

List<Feed> parseFeeds(String responseBody) {
  final parsed = json.decode(responseBody)['data']['children'].cast<Map<String, dynamic>>();

  return parsed.map<Feed>((json) => Feed.fromJson(json['data'])).toList();
}

class Feed {
  final String title;
  final String author;
  final String score;
  final int numComments;
  final String thumbnail;
  final String permalink;
  final String body;
  Feed(
      {required this.title,
      required this.body,
      required this.author,
      required this.numComments,
      required this.thumbnail,
      required this.permalink,
      required this.score});

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
        title: json['title'],
        thumbnail: json['thumbnail'],
        numComments: json['num_comments'],
        permalink: json['permalink'],
        body: json['selftext'],
        author: json['author'],
        score: json['score'].toString());
  }
}