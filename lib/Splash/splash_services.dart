import 'dart:async';

import 'package:chat_complete/Authentication/sign_in.dart';
import 'package:chat_complete/Interface/interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(const Duration(seconds: 5), () {
        Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => const InterfacePage()));
      });
    } else {
      Timer(const Duration(seconds: 5), () {
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (context) => const SignIn()));
      });
    }
  }
}
