import 'package:chat_complete/Authentication/signup.dart';
import 'package:chat_complete/Interface/interface.dart';
import 'package:chat_complete/Utilities/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  void signIn() {
    setState(() {
      loading = true;
    });
    auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage('Signed In Successfully!');
      Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) => const InterfacePage()));
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage(
          'Error While Signing In! Please Try Again Later Error Code [$error]');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //sizing from top
              const SafeArea(
                child: SizedBox(height: 30),
              ),
              //icon for login
              const Icon(
                Icons.local_shipping_outlined,
                color: Colors.deepPurple,
                size: 75,
              ),
              const SizedBox(height: 30),
              //text for user
              const Text(
                'Welcome Back You\'ve been Missed!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              //login Text
              Text(
                'Sign In'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 50),
              //form for validation
              Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //email Text
                    const Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Text(
                        'Email: ',
                        style:
                            TextStyle(color: Colors.deepPurple, fontSize: 17),
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
                        style:
                            TextStyle(color: Colors.deepPurple, fontSize: 17),
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
                  ],
                ),
              ),
              //submit button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {
                    if (_form.currentState!.validate()) {
                      signIn();
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
                              'Sign In'.toUpperCase(),
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
                    'Not a Member? ',
                    style: TextStyle(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => const Signup()));
                    },
                    child: Text(
                      ' Sign Up'.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
