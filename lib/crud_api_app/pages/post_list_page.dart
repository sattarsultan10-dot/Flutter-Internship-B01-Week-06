import 'package:flutter/material.dart';
import 'package:week_06/crud_api_app/api_services/api_services.dart';
import 'package:week_06/crud_api_app/model/post_model.dart';
import 'package:week_06/crud_api_app/pages/post_form_page.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  final ApiServices apiServices = ApiServices();
  void refresh() {
    setState(() {});
  }

  void deletePosts(int id) async {
    final confirm = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("DeletePost"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text("Delete Post"),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await apiServices.deletePost(id);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Post Deleted")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CRUD API APP")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: ((context) => PostFormPage())),
          );
          refresh();
        },
      ),
      body: FutureBuilder<List<PostModel>>(
        future: apiServices.fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error has occured"));
          }
          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (_, i) {
              final post = posts[i];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostFormPage(post: post),
                          ),
                        );
                        refresh();
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        deletePosts(post.id!);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
