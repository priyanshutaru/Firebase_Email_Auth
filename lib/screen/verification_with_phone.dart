// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselecture1/constants/constats.dart';
import 'package:firebaselecture1/screen/phone_otp_screen.dart';
import 'package:firebaselecture1/widgets/authbutton.dart';
import 'package:flutter/material.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final phonenumberController = TextEditingController();
  var isloading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login With Phone"),
      ),
      body: Column(
        children: [
          SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: TextFormField(
              controller: phonenumberController,
              decoration: InputDecoration(
                hintText: "+91 0000010000",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black38),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black38),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          LoginButton(
            loading: isloading,
              title: "Verify Your Number",
              onTap: () {
                setState(() {
                  isloading = true;
                });
                auth.verifyPhoneNumber(
                    phoneNumber: phonenumberController.text,
                    verificationCompleted: (_) {},
                    verificationFailed: (e) {
                      Constantss().toastMassege(e.toString());
                    },
                    codeSent: ((verificationId, forceResendingToken) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhoneOtpScreen(
                            verificationId: verificationId,
                          ),
                        ),
                      );
                       setState(() {
                  isloading = false;
                });
                    }),
                    codeAutoRetrievalTimeout: (e) {
                      Constantss().toastMassege(e.toString());
                    });
              }),
        ],
      ),
    );
  }
}
