import 'package:desafio_fpftech_daniel/model/feed_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('post model ...', () async {
    final List<Feed> posts = await fetchFeed(http.Client(), 'testing');
    try {
      print(posts[0].author);
      print(posts[0].score);
      print(posts[0].body);
    } catch (e) {
      print(e);
    }
  });
}
