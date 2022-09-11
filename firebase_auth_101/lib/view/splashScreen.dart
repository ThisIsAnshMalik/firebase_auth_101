import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_101/view/auth/loginScreen.dart';
import 'package:firebase_auth_101/view/firebase_database_screens/homescreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user == null) {
      Timer(const Duration(seconds: 3), (() {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: ((context) {
          return const LoginScreen();
        })));
      }));
    } else {
      Timer(const Duration(seconds: 3), (() {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: ((context) {
          return const HomeScreen();
        })));
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(
            color: Colors.white,
          ),
          Text(
            "  Firebase 101",
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.w500),
          ),
        ],
      )),
    );
  }
}
