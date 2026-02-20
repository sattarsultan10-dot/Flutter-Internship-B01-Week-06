import 'dart:convert';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageUploadProvider extends ChangeNotifier {
  File? selectedimage;
  String? uploadImageURL;
  bool isUploading = false;
  double uploadProgress = 0;
  String? error;
  final picker = ImagePicker();
  //File Picker
  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedimage = File(image.path);
      notifyListeners();
    }
  }

  // Compress File
  Future<File> compressimage(File file) async {
    final bytes = await file.readAsBytes(); //open the file, read it.
    final decodeimage = img.decodeImage(
      bytes,
    ); //convert it into some format which can be edit.
    final compressed = img.encodeJpg(
      decodeimage!,
      quality: 70,
    ); //Convert it to JPG Format,reduces its quality to 70% means smaller size.
    final compressFile = File(file.path); // Create File.
    compressFile.writeAsBytesSync(
      compressed,
    ); //write the compress bytes into it.
    return compressFile;
  }

  //Upload Image
  Future<void> uploadImage() async {
    if (selectedimage == null) return;
    try {
      isUploading = true;
      uploadProgress = 0;
      error = null;
      notifyListeners(); // Uploadig Started
      final compressedFile = await compressimage(
        selectedimage!,
      ); // Reduce image size before uploading.
      var request = http.MultipartRequest(
        'Post',
        Uri.parse("https://your-api-endpoint.com/upload"),
      ); //sending request,using post method,using this API URL.
      var bytes = await compressedFile.readAsBytes();
      var multipartfile = http.MultipartFile.fromBytes(
        'image',
        bytes,
        filename: 'upload.jpg',
      ); //preparing image for uploading.
      request.files.add(multipartfile); // Adding file to request.
      var response = await request.send(); // Start uploadin the image.
      response.stream.listen(
        (event) {
          uploadProgress += event.length / bytes.length;
          notifyListeners();
        }, // Tracks how much data is uploaded.
      );
      final respStr = await response.stream
          .bytesToString(); // Getting Server Response
      final jsonData = jsonDecode(respStr); // Getting Server Response
      uploadImageURL = jsonData["url"];
      isUploading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isUploading = false;
      notifyListeners();
    }
  }
}
