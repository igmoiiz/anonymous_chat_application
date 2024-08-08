// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:io';
import 'package:chat_complete/Utilities/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostUploadScreen extends StatefulWidget {
  const PostUploadScreen({super.key});

  @override
  _PostUploadScreenState createState() => _PostUploadScreenState();
}

class _PostUploadScreenState extends State<PostUploadScreen> {
  File? _image;
  String _description = '';

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('Image selection cancelled.');
    }
  }

  Future<void> _uploadPost() async {
    if (_image == null) {
      return; // Prevent upload without an image
    }
    // ... rest of your uploadPost function
    // Upload image to Firebase Storage
    Reference ref = FirebaseStorage.instance
        .ref('POSTS')
        .child('posts/${DateTime.now().millisecondsSinceEpoch}');
    UploadTask uploadTask = ref.putFile(_image!);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await snapshot.ref.getDownloadURL();

    // Save post data to Firestore
    await FirebaseFirestore.instance.collection('posts').add({
      'imageUrl': imageUrl,
      'description': _description,
      'timestamp': FieldValue.serverTimestamp(),
      'postId': DateTime.now().millisecondsSinceEpoch,
    });

    // Clear form fields
    setState(() {
      _image = null;
      _description = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Upload Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image preview
            GestureDetector(
              onTap: () {
                _pickImage().then((value) {
                  Utils().toastMessage('Post Uploaded');
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: _image != null
                    ? Image.file(_image!) // Show image if available
                    : const Icon(Icons.image),
              ),
            ),
            // Placeholder for no image
            const SizedBox(height: 16.0),
            TextField(
              onChanged: (value) => _description = value,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            ElevatedButton(
              onPressed: () {
                _uploadPost().then((value) {
                  Utils().toastMessage('Post Uploaded');
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              }, // Call uploadPost directly
              child: const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
