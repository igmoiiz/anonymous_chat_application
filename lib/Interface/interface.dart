// ignore_for_file: unused_local_variable

import 'package:chat_complete/Interface/post_screen.dart';
import 'package:chat_complete/Utilities/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InterfacePage extends StatefulWidget {
  const InterfacePage({super.key});

  @override
  State<InterfacePage> createState() => _InterfacePageState();
}

class _InterfacePageState extends State<InterfacePage> {
  final searchController = TextEditingController();
  final editController = TextEditingController();
  final ref = FirebaseDatabase.instance.ref('BLACK CHAT');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            const SafeArea(child: SizedBox(height: 30)),
            //text Icon
            const Icon(
              Icons.insert_comment_outlined,
              color: Colors.deepPurple,
              size: 75,
            ),
            const SizedBox(height: 30),
            //text for User
            const Text(
              'See What\'s New!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontSize: 19,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                controller: searchController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'No results Found';
                  } else {
                    return null;
                  }
                },
                onChanged: (String value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Search a Thought!',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.deepPurple.shade600,
                  ),
                ),
              ),
            ),
            //firebase animated list
            Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                defaultChild: const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text(
                    'Loading',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child('Thought').value.toString();
                  if (searchController.text.isEmpty) {
                    return ListTile(
                      //popup menu button
                      trailing: PopupMenuButton<int>(
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.deepPurple,
                        ),
                        //item builder from popup menu button
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                showMyDialog(
                                    title,
                                    DateTime.now()
                                        .microsecondsSinceEpoch
                                        .toString());
                              },
                              leading: const Icon(
                                Icons.edit,
                                color: Colors.deepPurple,
                              ),
                              title: const Text(
                                'Edit',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              leading: Icon(
                                Icons.delete_outline_outlined,
                                color: Colors.deepPurple,
                              ),
                              title: Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                        color: Colors.grey.shade900,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      title: Text(
                        snapshot.child('Thought').value.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        snapshot.child('ID').value.toString(),
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else if (title.toLowerCase().contains(
                      searchController.text.toLowerCase().toString())) {
                    return ListTile(
                      title: Text(
                        snapshot.child('Thought').value.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        snapshot.child('ID').value.toString(),
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      //floating action button to add a new post
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        elevation: 30,
        onPressed: () {
          Navigator.of(context).push(
              CupertinoPageRoute(builder: (context) => const PostScreen()));
        },
        tooltip: 'Add a Post',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

//dialogue buttons
  Future<void> showMyDialog(String title, String id) async {
    editController.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          title: Text(
            'Update',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.montserrat().fontFamily,
              letterSpacing: 1,
            ),
          ),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color: Colors.grey.shade900),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              fillColor: Colors.grey.shade800,
              filled: true,
              hintText: 'Edit..',
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.montaga().fontFamily),
                )),
            TextButton(
                onPressed: () {
                  ref.child(id).update({
                    'Thought': editController.text.toString(),
                  }).then((value) {
                    Utils().toastMessage('Thought Updated Successfully!');
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  'Update',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.montaga().fontFamily),
                )),
          ],
        );
      },
    );
  }
}
