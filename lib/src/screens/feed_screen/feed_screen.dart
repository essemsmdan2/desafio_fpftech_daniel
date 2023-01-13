import 'dart:convert';

import 'package:desafio_fpftech_daniel/src/screens/feed_screen/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeedScreen extends StatefulWidget {
  String subreddit;
  FeedScreen({super.key, required this.subreddit});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.subreddit)),
      body: FutureBuilder<List<Posts>>(
        future: fetchPosts(http.Client(), widget.subreddit),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Posts> posts = snapshot.data as List<Posts>;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                Posts post = posts[index];
                return ListTile(
                  onTap: () {},
                  title: Text(post.title),
                  leading: Text(post.score),
                  trailing: Text('${post.num_comments}'),
                  subtitle: _loadPreview(post),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _loadPreview(Posts post) {
    final thumbnail = post.thumbnail;
    String fileUrl = "file:///default";
    Uri uri = Uri.parse(fileUrl);
    if (thumbnail != null && thumbnail != 'self' && thumbnail != uri && thumbnail != "default") {
      return Image.network(
        thumbnail,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      );
    } else {
      return SizedBox();
    }
  }
}
