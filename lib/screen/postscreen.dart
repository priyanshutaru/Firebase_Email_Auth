import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselecture1/constants/constats.dart';
import 'package:firebaselecture1/screen/login.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Screen"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }).onError((error, stackTrace) {
                Constantss().toastMassege(error.toString());
              });
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),
      body: Column(
        children: const [
          Text("This is post screen"),
        ],
      ),
    );
  }
}
