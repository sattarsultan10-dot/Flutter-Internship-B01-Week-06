import 'package:flutter/material.dart';
import 'package:week_06/api_basics_app/api_services/api_service.dart';

class PostPage extends StatefulWidget {
  PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts Page")),
      body: FutureBuilder(
        future: apiService.fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Card(
                child: ListTile(
                  title: Text("${post.id} - ${post.title}"),
                  subtitle: Text(post.body),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
