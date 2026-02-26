import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:week_06/crud_api_app/pages/post_list_page.dart';
import 'package:week_06/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Successfully Connected");
  } catch (e) {
    print("$e");
  }
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: PostListPage());
  }
}
