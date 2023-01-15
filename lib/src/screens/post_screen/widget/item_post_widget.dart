import 'package:desafio_fpftech_daniel/core/config/constants.dart';
import 'package:desafio_fpftech_daniel/model/post_model.dart';
import 'package:desafio_fpftech_daniel/src/screens/post_screen/widget/image_handler_widget.dart';
import 'package:flutter/material.dart';

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
      child: listItemPost(items, context),
    );
  }
}

Widget listItemPost(Posts item, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        'Posted by u/${item.author}',
        style: kSubTitleTextStyle,
      ),
      Text(
        item.title,
        style: kPrimaryTextStyle.copyWith(fontSize: 22),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        item.selftext,
        style: kSubTitleTextStyle.copyWith(fontSize: 18),
      ),
      const SizedBox(
        height: 10,
      ),
      ImageOrVideo(context, item.url, item.thumbnail),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              const Icon(Icons.file_upload_rounded),
              Text(item.score),
              const Icon(Icons.download),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Row(
            children: [
              const Icon(Icons.comment),
              const SizedBox(
                width: 5,
              ),
              Text(item.numComments),
            ],
          )
        ],
      )
    ],
  );
}
