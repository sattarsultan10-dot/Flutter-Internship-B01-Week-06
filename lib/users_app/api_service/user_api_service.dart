import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:week_06/users_app/model/user_model.dart';

class UserApiService {
  final String baseURLs = "https://jsonplaceholder.typicode.com/users";
  Future<List<UserModel>> fetchUsers() async {
    final user_Response = await http.get(Uri.parse(baseURLs));
    if (user_Response.statusCode == 200) {
      final List user_Data = jsonDecode(user_Response.body);
      return user_Data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load User Data");
    }
  }

  Future<UserModel> addUser(UserModel user) async {
    final user_Response = await http.post(
      Uri.parse(baseURLs),
      headers: {"Content-Type": "applicatoin/json"},
      body: jsonEncode(user.toJson()),
    );
    return UserModel.fromJson(jsonDecode(user_Response.body));
  }

  Future<void> deleteUser(int id) async {
    final user_Response = await http.delete(Uri.parse(baseURLs));
    if (user_Response.statusCode != 200 && user_Response.statusCode != 204) {
      throw Exception('Failed to delete the user');
    }
  }
}
