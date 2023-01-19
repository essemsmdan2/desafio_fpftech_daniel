// ignore_for_file: prefer_const_constructors

import 'package:desafio_fpftech_daniel/core/config/constants.dart';
import 'package:desafio_fpftech_daniel/model/comment_model.dart';
import 'package:desafio_fpftech_daniel/model/feed_model.dart';
import 'package:desafio_fpftech_daniel/model/post_model.dart';
import 'package:desafio_fpftech_daniel/src/screens/post_screen/widget/item_comment_widget.dart';
import 'package:desafio_fpftech_daniel/src/screens/post_screen/widget/item_post_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class CommentScreen extends StatefulWidget {
  final Feed post;
  const CommentScreen({super.key, required this.post});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late Feed post;
  @override
  void initState() {
    post = widget.post;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, __) => [_appBar()],
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.0),
                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  height: 40.0,
                  width: double.infinity,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(25.0), color: Colors.green.withOpacity(0.25)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0),
                    child: Text(
                      'Community',
                      style: TextStyle(
                          fontFamily: 'Quicksand', fontSize: 20.0, color: Colors.green, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                FutureBuilder<List<Posts>>(
                  future: fetchPosts(http.Client(), widget.post.permalink),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ListItemPosts(items: snapshot.data!)
                        : Center(child: CircularProgressIndicator());
                  },
                ),
                SizedBox(height: 10.0)
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.0),
                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  height: 40.0,
                  width: double.infinity,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(25.0), color: Colors.red.withOpacity(0.25)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0),
                    child: Text(
                      'Comments',
                      style: TextStyle(
                          fontFamily: 'Quicksand', fontSize: 20.0, color: Colors.red, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                FutureBuilder<List<Comments>>(
                  future: fetchComments(http.Client(), widget.post.permalink),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ListItemComment(items: snapshot.data!)
                        : Center(child: CircularProgressIndicator());
                  },
                ),
                SizedBox(height: 10.0)
              ],
            )
          ],
        ),
      ),
    );
  }

  _appBar() {
    return SliverAppBar(
      snap: true,
      floating: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Text(post.title),
          SizedBox(
            height: 5,
          ),
          Text(
            'Posted by u/${post.author}',
            style: const TextStyle(color: Colors.black54, fontSize: 16),
          )
        ],
      ),
    );
  }
}
