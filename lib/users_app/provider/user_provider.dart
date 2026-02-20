import 'package:flutter/material.dart';
import 'package:week_06/users_app/api_service/user_api_service.dart';
import '../model/user_model.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> users = [];
  bool isLoading = false;
  String search = "";

  final UserApiService apiService = UserApiService();

  // Fetch Users
  Future<void> fetchUsers() async {
    isLoading = true;
    notifyListeners();

    users = await apiService.fetchUsers();

    isLoading = false;
    notifyListeners();
  }

  // Add User
  Future<void> addUser(UserModel user) async {
    final newUser = await apiService.addUser(user);
    users.add(newUser);
    notifyListeners();
  }

  // Delete User
  Future<void> deleteUser(int id) async {
    await apiService.deleteUser(id);
    users.removeWhere((u) => u.id == id);
    notifyListeners();
  }

  // Search Users
  List<UserModel> get filteredUsers {
    return users
        .where((u) => u.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }
}
