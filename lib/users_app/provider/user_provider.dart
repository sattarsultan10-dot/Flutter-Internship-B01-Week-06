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

    users = await apiService
        .fetchUsers(); // Replace the old list with the new list.

    isLoading = false;
    notifyListeners();
  }

  // Add User
  Future<void> addUser(UserModel user) async {
    users.add(
      await apiService.addUser(user),
    ); // Just add one user to the existing list.
    notifyListeners();
  }

  // Delete User
  Future<void> deleteUser(int id) async {
    await apiService.deleteUser(
      id,
    ); //Send request to user to delete the user with that id.
    users.removeWhere(
      (u) => u.id == id,
    ); //Delete that user from your local list.
    notifyListeners();
  }

  // Search Users
  List<UserModel> get filteredUsers {
    return users
        .where((u) => u.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }
}
