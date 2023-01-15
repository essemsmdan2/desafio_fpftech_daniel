import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget ImageOrVideo(BuildContext context, String url, String thumnail) {
  Widget result = SizedBox();

  if (url.isNotEmpty && url.endsWith('.jpg')) {
    return result = Card(child: Image.network(url));
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
            child: thumnail.endsWith('.jpg')
                ? Card(
                    child: Image.network(
                      thumnail,
                      fit: BoxFit.fitWidth,
                    ),
                  )
                : SizedBox(),
          )
        ],
      ),
    );
  }
}
