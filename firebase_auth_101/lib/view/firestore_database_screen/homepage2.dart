import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_101/firebase/authentication.dart';
import 'package:firebase_auth_101/view/firestore_database_screen/postscreen2.dart';
import 'package:flutter/material.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  TextEditingController searchController = TextEditingController();
  TextEditingController updateController = TextEditingController();
  Authentication authentication = Authentication();
  final fireStoreRef =
      FirebaseFirestore.instance.collection("post").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Home Screen"),
        actions: [
          IconButton(
              onPressed: (() {
                authentication.logout(context);
              }),
              icon: const Icon(Icons.logout_outlined)),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              onChanged: ((value) {
                setState(() {});
              }),
              controller: searchController,
              decoration: const InputDecoration(
                  hintText: "search", border: OutlineInputBorder()),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: fireStoreRef,
                builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Something went Wrong"),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              title: Text(snapshot.data!.docs[index]["title"]
                                  .toString()),
                              subtitle: Text(
                                  snapshot.data!.docs[index]["id"].toString()),
                            );
                          })),
                    );
                  }
                }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: (() {
          Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
            return PostScreen2();
          })));
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
