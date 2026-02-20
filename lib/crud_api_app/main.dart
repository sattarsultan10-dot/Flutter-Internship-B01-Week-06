import 'package:flutter/material.dart';
import 'package:week_06/crud_api_app/pages/post_list_page.dart';

void main() {
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: PostListPage());
  }
}
