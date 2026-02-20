import 'dart:convert';
import 'package:week_06/api_basics_app/model/post_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Post>> fetchPosts() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception("Failed to load posts");
    }
  }
}
