import 'package:chat_complete/Utilities/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool loading = false;
  final _form = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.flood_sharp,
              color: Colors.deepPurple,
              size: 55,
            ),
            const SizedBox(height: 30),
            Form(
              key: _form,
              child: Column(
                children: [
                  //email Text
                  const Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Email: ',
                        style:
                            TextStyle(color: Colors.deepPurple, fontSize: 17),
                      ),
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
                ],
              ),
            ),
            //spacing
            const SizedBox(height: 30),
            //submit button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: InkWell(
                onTap: () {
                  if (_form.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    auth
                        .sendPasswordResetEmail(
                            email: emailController.text.toString())
                        .then((value) {
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMessage(
                          "Email to Reset Password Sent! Please Check You Email to Recover your Password");
                    }).onError((error, stackTrace) {
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMessage(error.toString());
                    });
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
                            'Send Email'.toUpperCase(),
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
          ],
        ),
      ),
    );
  }
}
