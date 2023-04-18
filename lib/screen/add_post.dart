// ignore_for_file: prefer_const_constructors

import 'package:firebaselecture1/constants/constats.dart';
import 'package:firebaselecture1/widgets/authbutton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddpostScreen extends StatefulWidget {
  const AddpostScreen({super.key});

  @override
  State<AddpostScreen> createState() => _AddpostScreenState();
}

class _AddpostScreenState extends State<AddpostScreen> {
  var isloading = false;
  final firebasedatabaseref = FirebaseDatabase.instance.ref("Priyanshu");
  final addcontentcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post Here"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: TextFormField(
              controller: addcontentcontroller,
              maxLines: 6,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: "Enter What You Want to ............."),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          LoginButton(
            title: "Add Post",
            loading: isloading,
            onTap: () {
              setState(() {
                isloading = true;
              });

              firebasedatabaseref
                  .child(DateTime.now().microsecondsSinceEpoch.toString())
                  .set({'title': addcontentcontroller.text.toString()}).then(
                      (value) {
                Constantss().toastMassege("Post Added Succesfully");
                setState(() {
                  isloading = false;
                });
              }).onError((error, stackTrace) {
                Constantss().toastMassege(error.toString());
                setState(() {
                  isloading = false;
                });
              });
            },
          ),
        ],
      ),
    );
  }
}
