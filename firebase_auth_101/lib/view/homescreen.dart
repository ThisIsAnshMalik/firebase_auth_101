import 'package:firebase_auth_101/firebase/authentication.dart';
import 'package:firebase_auth_101/view/add_post_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

DatabaseReference postRef = FirebaseDatabase.instance.ref("post");

class _HomeScreenState extends State<HomeScreen> {
  Authentication authentication = Authentication();
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: (() {
          Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
            return const AddPostScreen();
          })));
        }),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: postRef.onValue,
              builder: ((context, AsyncSnapshot<DatabaseEvent> snapshot) {
                Map<dynamic, dynamic> map =
                    snapshot.data!.snapshot.value as dynamic;
                List<dynamic> list = [];
                list.clear();
                list = map.values.toList();
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.snapshot.children.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: Text(list[index]["title"]),
                        );
                      }));
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}
