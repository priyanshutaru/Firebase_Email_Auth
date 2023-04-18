// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselecture1/screen/postscreen.dart';
import 'package:firebaselecture1/widgets/authbutton.dart';
import 'package:flutter/material.dart';

class PhoneOtpScreen extends StatefulWidget {
  final String verificationId;
  const PhoneOtpScreen({super.key, required this.verificationId});

  @override
  State<PhoneOtpScreen> createState() => _PhoneOtpScreenState();
}

class _PhoneOtpScreenState extends State<PhoneOtpScreen> {
  final phoneotpController = TextEditingController();
  var isloading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Your Number"),
      ),
      body: Column(
        children: [
          SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: TextFormField(
              controller: phoneotpController,
              decoration: InputDecoration(
                hintText: " 6 Digit code ",
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
              title: "Verify Your Number",
              onTap: () async {
                setState(() {
                  isloading = true;
                });

                final credetential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: phoneotpController.text.toString());

                try {
                  await auth.signInWithCredential(credetential);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PostScreen()));
                } catch (e) {
                  setState(() {
                    isloading = false;
                  });
                }
              }),
        ],
      ),
    );
  }
}
