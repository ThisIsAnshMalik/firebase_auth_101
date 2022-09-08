import 'package:firebase_auth_101/provider/Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
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
                    onTap: (() {}),
                    child: value.isloading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Center(
                            child: Text(
                            "Add Data",
                            style: TextStyle(fontSize: 20),
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
