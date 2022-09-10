import 'package:firebase_auth_101/firebase/authentication.dart';
import 'package:firebase_auth_101/utils/flutter_toast.dart';
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
  TextEditingController searchController = TextEditingController();
  TextEditingController updateController = TextEditingController();
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
                          String titleName = list[index]["title"].toString();
                          if (searchController.text.isEmpty) {
                            return ListTile(
                              title: Text(list[index]["title"]),
                              subtitle: Text(list[index]["id"]),
                              trailing: PopupMenuButton(
                                icon: const Icon(Icons.more_vert),
                                itemBuilder: ((context) => [
                                      PopupMenuItem(
                                        child: ListTile(
                                          onTap: (() {
                                            Navigator.pop(context);
                                            showMyDialog(
                                                titleName, list[index]["id"]);
                                          }),
                                          leading: const Icon(Icons.edit),
                                          title: const Text("Edit"),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.pop(context);
                                            postRef
                                                .child(list[index]["id"]
                                                    .toString())
                                                .remove();
                                          },
                                          leading: const Icon(Icons.delete),
                                          title: const Text("Delete"),
                                        ),
                                      )
                                    ]),
                              ),
                            );
                          } else if (titleName
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return ListTile(
                              title: Text(list[index]["title"]),
                              subtitle: Text(list[index]["id"]),
                              trailing: PopupMenuButton(
                                icon: const Icon(Icons.more_vert),
                                itemBuilder: ((context) => [
                                      PopupMenuItem(
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.pop(context);
                                            showMyDialog(
                                                titleName, list[index]["id"]);
                                          },
                                          leading: const Icon(Icons.edit),
                                          title: const Text("Edit"),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        child: ListTile(
                                          leading: const Icon(Icons.delete),
                                          onTap: () {
                                            Navigator.pop(context);
                                            postRef
                                                .child(list[index]["id"]
                                                    .toString())
                                                .remove();
                                          },
                                          title: const Text("Delete"),
                                        ),
                                      )
                                    ]),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }));
                  }
                }),
              ),
            ),
          ],
        ),
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
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    updateController.text = title;
    return showDialog(
        context: context,
        builder: ((BuildContext context) {
          return AlertDialog(
            title: const Text("Edit"),
            content: Container(
              child: TextField(
                controller: updateController,
                decoration: const InputDecoration(hintText: "edit"),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (() {
                    Navigator.pop(context);
                    updateController.clear();
                  }),
                  child: const Text("Cancil")),
              TextButton(
                  onPressed: (() {
                    postRef.child(id).update({
                      "title": updateController.text.toString()
                    }).then((value) {
                      Utils().toastMessage("Post Updated Successfuly");
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(
                          "Post Update Failed :- ${error.toString()}");
                    });
                    Navigator.pop(context);
                    updateController.clear();
                  }),
                  child: const Text("Update"))
            ],
          );
        }));
  }
}
