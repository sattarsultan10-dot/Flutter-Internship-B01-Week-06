import 'package:flutter/material.dart';
import 'package:week_06/crud_api_app/api_services/api_services.dart';
import 'package:week_06/crud_api_app/model/post_model.dart';

class PostFormPage extends StatefulWidget {
  final PostModel? post;

  const PostFormPage({super.key, this.post});

  @override
  State<PostFormPage> createState() => _PostFormPageState();
}

class _PostFormPageState extends State<PostFormPage> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  final ApiServices apiService = ApiServices();

  @override
  void initState() {
    super.initState();

    if (widget.post != null) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    }
  }

  void submit() async {
    if (!_formKey.currentState!.validate()) return;

    final newPost = PostModel(
      title: titleController.text,
      body: bodyController.text,
    );
    try {
      if (widget.post == null) {
        await apiService.createPosts(newPost);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Post Created")));
      } else {
        await apiService.updatePost(widget.post!.id!, newPost);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Post Updated")));
      }
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post == null ? "Add Post" : "Edit Post"),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
                validator: (value) => value!.isEmpty ? "Enter title" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: bodyController,
                decoration: InputDecoration(labelText: "Body"),
                validator: (value) => value!.isEmpty ? "Enter body" : null,
              ),
              const SizedBox(height: 10),
              ElevatedButton(onPressed: submit, child: Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }
}
