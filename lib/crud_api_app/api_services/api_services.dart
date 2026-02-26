import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:week_06/crud_api_app/model/post_model.dart';

class ApiServices {
  final String baseURL = "https://jsonplaceholder.typicode.com/posts";
  //Read Function
  Future<List<PostModel>> fetchPosts() async {
    final response = await http.get(Uri.parse(baseURL));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => PostModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load the posts");
    }
  }

  //Create Post
  Future<PostModel> createPosts(PostModel post) async {
    final response = await http.post(
      Uri.parse(baseURL),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode == 201) {
      return PostModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to create post");
    }
  }

  //Update Method
  Future<PostModel> updatePost(int id, PostModel post) async {
    final response = await http.put(
      Uri.parse("$baseURL/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode == 200) {
      return PostModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update the post");
    }
  }

  //Delete Post
  Future<void> deletePost(int id) async {
    final response = await http.delete(Uri.parse("$baseURL/$id"));
    if (response.statusCode == 200 || response.statusCode == 204) {
      //sucees
    } else {
      throw Exception('Failed to delete post');
    }
  }
}
