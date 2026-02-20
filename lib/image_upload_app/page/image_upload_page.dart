import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_06/image_upload_app/provider/image_upload_provider.dart';

class ImageUploadPage extends StatelessWidget {
  const ImageUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ImageUploadProvider>();
    return Scaffold(
      appBar: AppBar(title: Text('Image Upload Page')),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: provider.pickImage,
              child: Text("Pick Image"),
            ),
            const SizedBox(height: 150),
            if (provider.selectedimage != null)
              Image.file(provider.selectedimage!, height: 150),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: provider.uploadImage,
              child: Text("Upload Image"),
            ),
            if (provider.isUploading)
              LinearProgressIndicator(value: provider.uploadProgress),
            if (provider.uploadImageURL != null)
              Column(
                children: [
                  Text("Uploaded Image"),
                  Image.network(provider.uploadImageURL!),
                ],
              ),
            if (provider.error != null)
              Text(provider.error!, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
