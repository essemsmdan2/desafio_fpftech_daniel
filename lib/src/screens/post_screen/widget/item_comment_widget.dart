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
            itemBuilder: (BuildContext context, int position) {
              return Column(
                children: <Widget>[
                  listItemComment(items[position]),
                ],
              );
            }));
  }
}

Widget listItemComment(Comments items) {
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
