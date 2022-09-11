import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_101/firebase/firestore.dart';
import 'package:firebase_auth_101/provider/Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostScreen2 extends StatefulWidget {
  PostScreen2({Key? key}) : super(key: key);

  @override
  State<PostScreen2> createState() => _PostScreen2State();
}

class _PostScreen2State extends State<PostScreen2> {
  final titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FireStoreDatabase fireStoreRef = FireStoreDatabase();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            TextFormField(
              controller: titleController,
              maxLines: 4,
              maxLength: 50,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "what is in your mind"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Consumer<LoadingProvider>(
              builder: ((context, value, child) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.deepPurple),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: InkWell(
                    onTap: (() {
                      fireStoreRef.setData(
                          titleController.text.toString(), context);
                      Navigator.pop(context);
                    }),
                    child: value.isloading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Center(
                            child: Text(
                            "Add",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          )),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
