import 'package:chat_complete/Authentication/sign_in.dart';
import 'package:chat_complete/Utilities/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool loading = false;
  final postController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final ref = FirebaseDatabase.instance.ref('BLACK CHAT');
  final auth = FirebaseAuth.instance;
  String id = DateTime.now().microsecondsSinceEpoch.toString();
  void postThought() {
    setState(() {
      loading = true;
    });
    ref.child(id).set({
      'Thought': postController.text.toString(),
      'ID': id,
    }).then((value) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage('Post Added Successfully!');
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage(error.toString());
    });
  }

  void signOut() {
    auth.signOut().then((value) {
      Utils().toastMessage('Signed Out Successfully!');
      Navigator.of(context)
          .push(CupertinoPageRoute(builder: (context) => const SignIn()));
    }).onError((error, stackTrace) {
      Utils().toastMessage('Error While Signing Out \n $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
            color: Colors.deepPurple), // Change to your desired color
        // other properties
      ),
      //drawer
      endDrawer: Drawer(
        backgroundColor: Colors.grey.shade900,
        child: ListView(
          children: [
            const SafeArea(child: SizedBox(height: 30)),
            const Icon(
              Icons.pets_rounded,
              color: Colors.deepPurple,
              size: 60,
            ),
            const SizedBox(height: 50),
            //item 1
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: signOut,
                    icon: const Icon(
                      Icons.logout_outlined,
                      color: Colors.deepPurple,
                    )),
                const SizedBox(width: 10),
                Text(
                  'Sign Out'.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      //body of code
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SafeArea(child: SizedBox(height: 30)),
              //infinity icon
              const Icon(
                Icons.all_inclusive_outlined,
                color: Colors.deepPurple,
                size: 75,
              ),
              const SizedBox(height: 20),
              //text for user
              Text(
                'What\'s on your Mind?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.montaga().fontFamily,
                ),
              ),
              const SizedBox(height: 50),
              //input of thought
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  key: _form,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: postController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Can\'t share an Empty Thought';
                      } else {
                        return null;
                      }
                    },
                    maxLines: 4,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Share your Intrusive thoughts Anonymously!',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              //button to submit
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: postThought,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: loading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Center(
                            child: Text(
                              'Post'.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}