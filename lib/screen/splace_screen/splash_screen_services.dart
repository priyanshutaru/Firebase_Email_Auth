import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselecture1/screen/login.dart';
import 'package:firebaselecture1/screen/postscreen.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(
        const Duration(seconds: 5),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PostScreen(),
          ),
        ),
      );
    } else {
      Timer(
        const Duration(seconds: 5),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        ),
      );
    }
  }
}
