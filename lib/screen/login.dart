// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselecture1/constants/constats.dart';
import 'package:firebaselecture1/screen/postscreen.dart';
import 'package:firebaselecture1/screen/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isvisiable = true;
  bool isloading = false;
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
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      obscureText: isvisiable,
                      decoration: InputDecoration(
                        hintText: "Enter Your Password",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        suffixIcon: CupertinoButton(
                          onPressed: () {
                            setState(() {
                              isvisiable = !isvisiable;
                            });
                          },
                          child: Icon(
                            isvisiable
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black,
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
                  isloading = isloading;

                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      isloading = true;
                    });
                    _firebaseAuth
                        .signInWithEmailAndPassword(
                            email: emailcontrolller.text,
                            password: passwordcontroller.text)
                        .then((value) {
                      Constantss().toastMassege(value.user!.email.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostScreen(),
                        ),
                      );
                      setState(() {
                        isloading = false;
                      });
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
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ),
              ),
              Text("don't have an account??"),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ),
                  );
                },
                child: Text(
                  "Sign-up",
                  style: TextStyle(
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
