import 'dart:async';
import 'dart:convert';

import 'package:desafio_fpftech_daniel/model/feed_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

String url = 'https://www.reddit.com';

Future<List<Comments>> fetchComments(http.Client client, String permalink) async {
  final response = await client.get(Uri.parse("$url${permalink}.json"));
  // print("$url${post['permalink']}");
  return compute(parseComments, response.body);
}

List<Comments> parseComments(String responseBody) {
  final parsed = json.decode(responseBody)[1]['data']['children'].cast<Map<String, dynamic>>();

  return parsed.map<Comments>((json) => Comments.fromJson(json['data'])).toList();
}

class Comments {
  final String body;
  final String author;
  final String score;
  Comments({
    required this.author,
    required this.body,
    required this.score,
  });
  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      body: json['body'] ?? "",
      author: json['author'] ?? "",
      score: json['score'].toString(),
    );
  }
}
