// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebaselecture1/constants/constats.dart';
import 'package:firebaselecture1/screen/add_post.dart';
import 'package:firebaselecture1/screen/login.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final getdatarefrence = FirebaseDatabase.instance.ref("Priyanshu");
  final searchFilter = TextEditingController();
  final editcontroller = TextEditingController();
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
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: TextFormField(
              controller: searchFilter,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search Here............",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.black38, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.black38, width: 1),
                ),
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: getdatarefrence,
              //defaultChild: Text("Loading....."),
              itemBuilder: (context, snapshot, animation, index) {
                final title = Text(snapshot.child('title').value.toString());

                // final title = Text(snapshot.child('title').value.toString());

                // if (searchFilter.text.isEmpty) {
                //   return ListTile(
                //     title: Text(snapshot.child('title').value.toString()),
                //   );
                // } else if (title.toLowerCase()
                //     .contains(searchFilter.text.toLowerCase().toLowerCase())) {
                //   return ListTile(
                //     title: Text(snapshot.child('title').value.toString()),
                //   );
                // } else {
                //   return Container();
                // }

                return ListTile(
                  title: Text(snapshot.child('title').value.toString()),
                  subtitle: Text(snapshot.child('id').value.toString()),
                  trailing: PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            showMydailaug(
                              title.toString(),
                              Text(snapshot.child('id').value.toString())
                                  as String,
                            );
                          },
                          title: Text("Edit"),
                          leading: Icon(Icons.edit),
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          title: Text("Delete"),
                          leading: Icon(Icons.delete),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddpostScreen()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> showMydailaug(String titlee, String id) async {
    editcontroller.text = titlee;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update"),
          content: Container(
            child: TextField(
              controller: editcontroller,
              decoration: InputDecoration(),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // getdatarefrence.child(id).update(
                  //   titlee :editcontroller.text.toLowerCase());
                },
                child: Text("Update")),
          ],
        );
      },
    );
  }
}
