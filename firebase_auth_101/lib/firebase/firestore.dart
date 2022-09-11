import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_101/provider/Provider.dart';
import 'package:firebase_auth_101/utils/flutter_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FireStoreDatabase {
  final firestoreRef = FirebaseFirestore.instance.collection("post");
  setData(String title, BuildContext context) {
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    loadingProvider.setLoading(true);
    firestoreRef.doc(id).set({"title": title, "id": id}).then((value) {
      Utils().toastMessage("Data posted successfully");
      loadingProvider.setLoading(false);
    }).onError((error, stackTrace) {
      loadingProvider.setLoading(false);
      Utils().toastMessage("data posted Failed :- ${error.toString()}");
    });
  }
}
