// ignore_for_file: avoid_print

import 'package:chat_complete/Posting/display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDisplay extends StatelessWidget {
  const UserDisplay({super.key});

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
            return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              return Card(
                child: Column(
                  children: [
                    Text(document['description']),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.network(document['imageUrl']),
                    ),
                  ],
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
              builder: (context) => const PostDisplayScreen()));
        },
        child: const Icon(Icons.abc),
      ),
    );
  }
}
