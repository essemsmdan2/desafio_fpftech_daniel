import 'package:desafio_fpftech_daniel/core/config/constants.dart';
import 'package:desafio_fpftech_daniel/model/comment_model.dart';
import 'package:flutter/material.dart';

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
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  listItemComment(items[index]),
                ],
              );
            }));
  }
}

Widget listItemComment(Comments items) {
  if (items.replies != null && items.replies != '-1' && items.replies != "") {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  items.author,
                  style: kPrimaryTextStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  items.body,
                  style: kSubTitleTextStyle.copyWith(fontSize: 18),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: listItemComment(Comments.commentReply(items)),
        )
      ],
    );
  } else {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              items.author,
              style: kPrimaryTextStyle,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              items.body,
              style: kSubTitleTextStyle.copyWith(fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
