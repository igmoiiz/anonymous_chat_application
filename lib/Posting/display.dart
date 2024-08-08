// ignore_for_file: avoid_print

import 'package:chat_complete/Posting/posting.dart';
import 'package:chat_complete/Utilities/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostDisplayScreen extends StatelessWidget {
  const PostDisplayScreen({super.key});
  Future<void> _deletePost(String postId) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(postId).delete();
      print('Post deleted successfully');
      Utils().toastMessage('Post Deleted Successfully');
    } catch (e) {
      print('Error deleting post: $e');
      // Handle the error, e.g., show an error message to the user
      Utils().toastMessage(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              String postId = document.id; // Get the post ID from the document

              return ListTile(
                leading: Image.network(document['imageUrl']),
                title: Text(document['description']),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _deletePost(postId).then((value) {
                      Utils().toastMessage('Post Deleted');
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    }); // Pass the postId as an argument
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade700,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const PostUploadScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
