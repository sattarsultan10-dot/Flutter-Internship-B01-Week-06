import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_06/firebase_options.dart';
import 'package:week_06/users_app/page/users_page.dart';
import 'package:week_06/users_app/provider/user_provider.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Successfully Connected");
  } catch (e) {
    print("$e");
  }

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
