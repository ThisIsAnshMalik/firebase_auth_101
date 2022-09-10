// import 'package:flutter/material.dart';
import 'package:firebase_auth_101/provider/Provider.dart';
import 'package:firebase_auth_101/utils/flutter_toast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DataBase {
  DatabaseReference postRef = FirebaseDatabase.instance.ref("post");

// ----------------------------------------------------------------------------//
  addpost(String title, BuildContext context) {
    LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    loadingProvider.setLoading(true);
    postRef.child(DateTime.now().microsecond.toString()).set({
      "title": title,
    }).then((value) {
      Utils().toastMessage("Post added Successfuly");
      loadingProvider.setLoading(false);
    }).onError((error, stackTrace) {
      Utils().toastMessage("Post have Failed :- ${error.toString()}");
      loadingProvider.setLoading(false);
    });
  }

// ----------------------------------------------------------------------------//
}
