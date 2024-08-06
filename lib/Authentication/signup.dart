import 'package:chat_complete/Authentication/sign_in.dart';
import 'package:chat_complete/Interface/interface.dart';
import 'package:chat_complete/Utilities/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _form = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  void signUp() {
    setState(() {
      loading = true;
    });
    auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage('Signed Up and Signed In Successfully!');
      Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) => const InterfacePage()));
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage('Error while Signing Up \n $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          const SafeArea(child: SizedBox(height: 30)),
          //main icon HAMBURGER
          const Icon(
            Icons.lunch_dining_outlined,
            size: 75,
            color: Colors.deepPurple,
          ),
          const SizedBox(height: 30),
          //greeting text
          const Center(
            child: Text(
              'Share Your Intrusive Thoughts Anonymously!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          //sign up text
          Center(
            child: Text(
              'SIGN UP',
              style: TextStyle(
                color: Colors.deepPurple.shade600,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 40),
          //FORM WIDGET FOR VALIDATING INPUT FIELDS
          Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Name Text
                const Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Full Name: ',
                    style: TextStyle(color: Colors.deepPurple, fontSize: 17),
                  ),
                ),
                const SizedBox(height: 5),
                //text field for input of name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: nameController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Name';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'John Doe',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                //spacing
                const SizedBox(height: 30),
                //email Text
                const Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Email: ',
                    style: TextStyle(color: Colors.deepPurple, fontSize: 17),
                  ),
                ),
                const SizedBox(height: 5),
                //text field for input of email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: emailController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'abc@xyz.com',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                //spacing
                const SizedBox(height: 30),
                //password Text
                const Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Password: ',
                    style: TextStyle(color: Colors.deepPurple, fontSize: 17),
                  ),
                ),
                const SizedBox(height: 5),
                //text field for input of password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: '***********',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                //spacing
                const SizedBox(height: 30),
                //confirm password Text
                const Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Confirm Password: ',
                    style: TextStyle(color: Colors.deepPurple, fontSize: 17),
                  ),
                ),
                const SizedBox(height: 5),
                //text field for input of Confirmation
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: confirmPasswordController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Confirm your password';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: '***********',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                //spacing
                const SizedBox(height: 30),
              ],
            ),
          ),
          //submit button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GestureDetector(
              onTap: () {
                if (_form.currentState!.validate()) {
                  signUp();
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Center(
                        child: Text(
                          'Sign Up'.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          //signup text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already a Member? ',
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      CupertinoPageRoute(builder: (context) => const SignIn()));
                },
                child: Text(
                  ' Sign In'.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
