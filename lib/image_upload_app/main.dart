import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_06/firebase_options.dart';
import 'package:week_06/image_upload_app/page/image_upload_page.dart';
import 'package:week_06/image_upload_app/provider/image_upload_provider.dart';

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
  runApp(
    ChangeNotifierProvider(
      create: (_) => ImageUploadProvider(),
      child: MyWidget(),
    ),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ImageUploadPage());
  }
}
