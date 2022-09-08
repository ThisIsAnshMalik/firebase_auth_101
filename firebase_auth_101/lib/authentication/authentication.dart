import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_101/provider/Provider.dart';
import 'package:firebase_auth_101/utils/flutter_toast.dart';
import 'package:firebase_auth_101/view/auth/loginScreen.dart';
import 'package:firebase_auth_101/view/auth/verify_no_screen.dart';
import 'package:firebase_auth_101/view/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
//-------------------------------------------------------------------------------------------//
  signUp(String email, String password, BuildContext context) {
    LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      loadingProvider.setLoading(false);
      Utils().toastMessage("User Created Succesfully :- ${value.toString()}");
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: ((context) {
        return const HomeScreen();
      })));
    }).onError((error, stackTrace) {
      loadingProvider.setLoading(false);
      Utils().toastMessage("user not created :- ${error.toString()}");
    });
  }

//-------------------------------------------------------------------------------------------//
  login(String email, String password, BuildContext context) {
    LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);

    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      loadingProvider.setLoading(false);
      Utils().toastMessage("Login Successfuly");
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: ((context) {
        return const HomeScreen();
      })));
    }).onError((error, stackTrace) {
      loadingProvider.setLoading(false);
      Utils().toastMessage(error.toString());
    });
  }

//-------------------------------------------------------------------------------------------//
  logout(BuildContext context) {
    _auth.signOut().then((value) {
      Utils().toastMessage("Loged out");
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: ((context) {
        return const LoginScreen();
      })));
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
  }

//-------------------------------------------------------------------------------------------//
  loginWithNo(String no, BuildContext context) {
    LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    _auth.verifyPhoneNumber(
        phoneNumber: "+91$no",
        verificationCompleted: ((_) {
          Utils().toastMessage("Code sended to your no");
          loadingProvider.setLoading(false);
        }),
        verificationFailed: ((e) {
          Utils().toastMessage(e.toString());
          loadingProvider.setLoading(false);
        }),
        codeSent: ((String verificationId, int? forceResendingToken) {
          loadingProvider.setLoading(false);
          Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
            return VerifyNoScreen(verificationId: verificationId);
          })));
        }),
        codeAutoRetrievalTimeout: ((e) {
          loadingProvider.setLoading(false);
        }));
  }

  //-------------------------------------------------------------------------------------------//
  verifyNo(String verificationId, String smsCode, BuildContext context) async {
    LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    try {
      await _auth.signInWithCredential(credential);
      loadingProvider.setLoading(false);
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: ((context) {
        return const HomeScreen();
      })));
      Utils().toastMessage("Login Successfuly");
    } catch (e) {
      debugPrint("Login verifation falied :- ${e.toString()}");
      Utils().toastMessage(e.toString());
      loadingProvider.setLoading(false);
    }
  }
}
