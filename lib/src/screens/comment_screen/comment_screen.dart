import 'package:desafio_fpftech_daniel/core/config/constants.dart';
import 'package:desafio_fpftech_daniel/model/comment_model.dart';
import 'package:desafio_fpftech_daniel/model/feed_model.dart';
import 'package:desafio_fpftech_daniel/model/post_model.dart';
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
      appBar: _appBar(),
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
    );
  }

  AppBar _appBar() {
    return AppBar(
        title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(post.title),
        SizedBox(
          height: 5,
        ),
        Text(
          'Posted by u/${post.author}',
          style: const TextStyle(color: Colors.blueGrey, fontSize: 16),
        )
      ],
    ));
  }
}

class ListItemPosts extends StatefulWidget {
  final List<dynamic> items;

  ListItemPosts({required this.items});

  @override
  State<ListItemPosts> createState() => _ListItemPostsState();
}

class _ListItemPostsState extends State<ListItemPosts> {
  late final Posts items;
  @override
  void initState() {
    items = widget.items[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 30, top: 20, bottom: 20),
      child: listItemPost(items),
    );
  }
}

Widget listItemPost(Posts item) {
  return Column(
    children: [
      Text(
        item.title,
        style: kPrimaryTextStyle.copyWith(fontSize: 22),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        item.selftext,
        style: kSubTitleTextStyle.copyWith(fontSize: 18),
      ),
      _imageOrVideo(item.url, item.thumbnail)
    ],
  );
}

Widget _imageOrVideo(BuildContext context, String url, String thumnail) {
  Widget result = SizedBox();
  if (url.isNotEmpty && url.endsWith('.jpg')) {
    return result = Image.network(url);
  } else {
    return result = GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Column(
        children: [
          Text('Click here to access the content'),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              thumnail,
              fit: BoxFit.fitWidth,
            ),
          )
        ],
      ),
    );
  }
}

class ListItemComment extends StatelessWidget {
  final List<dynamic> items;

  ListItemComment({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: items.length,
            primary: false,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int position) {
              return Column(
                children: <Widget>[
                  listItemComment(items[position]),
                  Divider(height: 5.0),
                ],
              );
            }));
  }
}

Widget listItemComment(Comments items) {
  return Text(
    items.author,
    style: kPrimaryTextStyle,
  );
}
