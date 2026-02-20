import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_06/users_app/page/users_page.dart';
import 'package:week_06/users_app/provider/user_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => UserProvider(), child: MyWidget()),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: UsersPage());
  }
}
