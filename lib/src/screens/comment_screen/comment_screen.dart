import 'package:desafio_fpftech_daniel/core/config/constants.dart';
import 'package:desafio_fpftech_daniel/model/comment_model.dart';
import 'package:desafio_fpftech_daniel/model/feed_model.dart';
import 'package:flutter/material.dart';
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

    return Scaffold(appBar: _appBar(), body: Container());
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
