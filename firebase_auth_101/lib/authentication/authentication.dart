import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_101/provider/Provider.dart';
import 'package:firebase_auth_101/utils/flutter_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signUp(String email, String password, BuildContext context) {
    LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      loadingProvider.setLoading(false);
      Utils().toastMessage("User Created Succesfully");
    }).onError((error, stackTrace) {
      loadingProvider.setLoading(false);
      Utils().toastMessage("user not created :- ${error.toString()}");
    });
  }
}