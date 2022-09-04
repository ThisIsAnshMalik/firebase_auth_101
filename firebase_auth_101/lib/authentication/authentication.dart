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
      Utils().toastMessage("User Created Succesfully :- ${value.toString()}");
    }).onError((error, stackTrace) {
      loadingProvider.setLoading(false);
      Utils().toastMessage("user not created :- ${error.toString()}");
    });
  }

  login(String email, String password, BuildContext context) {
    LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);

    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      loadingProvider.setLoading(false);
      Utils().toastMessage("Login Successfuly");
    }).onError((error, stackTrace) {
      loadingProvider.setLoading(false);
      Utils().toastMessage(error.toString());
    });
  }

  logout() {
    _auth.signOut().then((value) {
      Utils().toastMessage("Loging out..");
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
  }
}
