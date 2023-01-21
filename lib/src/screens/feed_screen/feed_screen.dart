import 'package:desafio_fpftech_daniel/core/config/constants.dart';
import 'package:desafio_fpftech_daniel/src/screens/post_screen/post_screen.dart';
import 'package:desafio_fpftech_daniel/model/feed_model.dart';
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
      body: FutureBuilder<List<Feed>>(
        future: fetchFeed(http.Client(), widget.subreddit),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Feed> posts = snapshot.data as List<Feed>;
            if (posts.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  final snapshot = await fetchFeed(http.Client(), widget.subreddit);
                  setState(() {
                    posts = snapshot;
                  });
                },
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    Feed post = posts[index];
                    return Card(
                      child: ListTile(
                        style: ListTileStyle.drawer,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => posts[index].numComments == ""
                                    ? FeedScreen(subreddit: posts[index].url)
                                    : CommentScreen(
                                        post: post,
                                      )),
                          );
                        },
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Posted by u/${post.author}",
                              style: kSubTitleTextStyle.copyWith(fontSize: 13),
                            ),
                            Text(
                              post.title,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        leading: FittedBox(
                          child: post.numComments!.isEmpty || post.numComments == null
                              ? null
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.file_upload_rounded),
                                    Text(post.score),
                                    Icon(Icons.download),
                                  ],
                                ),
                        ),
                        trailing: post.numComments!.isEmpty || post.numComments == null
                            ? null
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.comment),
                                  Text('${post.numComments}'),
                                ],
                              ),
                        subtitle: _previewHandler(post),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Sorry couldn\'t find any result',
                  style: kPrimaryTextStyle,
                  textAlign: TextAlign.center,
                ),
              ));
            }
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text("Sorry couldn't find any result"));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _previewHandler(Feed post) {
    final thumbnail = post.thumbnail;
    String fileUrl = "file:///default";
    Uri uri = Uri.parse(fileUrl);
    if (thumbnail.endsWith('.jpg')) {
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
