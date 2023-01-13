import 'package:desafio_fpftech_daniel/model/post_model.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  final Posts post;
  const CommentScreen({super.key, required this.post});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late Posts post;
  @override
  void initState() {
    post = widget.post;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title),
            Text(
              'Posted by u/${post.author}',
              style: TextStyle(color: Colors.blueGrey, fontSize: 16),
            )
          ],
        )),
        body: ListView(
          children: [
            Column(
              children: [Text(post.title,style: ,)],
            )
          ],
        ));
  }
}
