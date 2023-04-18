// ignore_for_file: prefer_const_constructors

import 'package:firebaselecture1/constants/constats.dart';
import 'package:firebaselecture1/screen/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isloading = false;
  bool passwordvisibility = true;
  final _formkey = GlobalKey<FormState>();
  final emailcontrolller = TextEditingController();
  final passwordcontroller = TextEditingController();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailcontrolller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp Page"),
        // automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailcontrolller,
                    decoration: InputDecoration(
                      hintText: "Enter Your Email",
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: passwordcontroller,
                    obscureText: passwordvisibility,
                    decoration: InputDecoration(
                      hintText: "Enter Your Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      suffixIcon: CupertinoButton(
                        onPressed: () {
                          setState(() {
                            passwordvisibility = !passwordvisibility;
                          });
                        },
                        child: Icon(
                          passwordvisibility
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Password";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (_formkey.currentState!.validate()) {
                  setState(() {
                    isloading = true;
                  });
                  _firebaseAuth
                      .createUserWithEmailAndPassword(
                          email: emailcontrolller.text.toString(),
                          password: passwordcontroller.text.toString())
                      .then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  }).onError((error, stackTrace) {
                    Constantss().toastMassege(error.toString());
                    setState(() {
                      isloading = false;
                    });
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black12, width: 1),
                  ),
                  child: Center(
                    child: isloading
                        ? CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          )
                        : Text(
                            "Sign-Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
            ),
            Text("Already have an account??"),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
