import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_06/users_app/model/user_model.dart';
import 'package:week_06/users_app/provider/user_provider.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  void showAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final user = UserModel(
                name: nameController.text,
                email: emailController.text,
              );
              context.read<UserProvider>().addUser(user);
              nameController.clear();
              emailController.clear();
              Navigator.pop(context);
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<UserProvider>().fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(title: Text("User App")),
      floatingActionButton: FloatingActionButton(
        onPressed: (showAddDialog),
        child: Icon(Icons.add),
      ),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: provider.fetchUsers,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.all(16),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Search",
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        provider.search = value;
                        provider.notifyListeners();
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.filteredUsers.length,
                      itemBuilder: (_, i) {
                        final user = provider.filteredUsers[i];
                        return ListTile(
                          title: Text(user.name),
                          subtitle: Text(user.email),
                          trailing: IconButton(
                            onPressed: () {
                              provider.deleteUser(user.id!);
                            },
                            icon: Icon(Icons.delete),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
