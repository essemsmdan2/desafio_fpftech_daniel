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
            return RefreshIndicator(
              onRefresh: () async {
                final snapshot = await fetchPosts(http.Client(), widget.subreddit);
                setState(() {
                  posts = snapshot;
                });
              },
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  Posts post = posts[index];
                  return Card(
                    child: ListTile(
                      style: ListTileStyle.drawer,
                      onTap: () {},
                      title: Text(
                        post.title,
                        style: TextStyle(fontSize: 16),
                      ),
                      leading: FittedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.file_upload_rounded),
                            Text(post.score),
                            Icon(Icons.download),
                          ],
                        ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.comment),
                          Text('${post.num_comments}'),
                        ],
                      ),
                      subtitle: _loadPreview(post),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
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
