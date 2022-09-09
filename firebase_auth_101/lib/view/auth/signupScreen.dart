import 'package:firebase_auth_101/firebase/authentication.dart';
import 'package:firebase_auth_101/provider/Provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_101/view/auth/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Authentication authentication = Authentication();
    return Form(
      key: formkey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text("Sign Up Screen"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      labelText: "email",
                      hintText: "enter email",
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "email should not be empty";
                    } else if (!value.endsWith("@gmail.com")) {
                      return "enter a valid email";
                    } else {
                      return null;
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    labelText: "password",
                    hintText: "enter password",
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "password should not be empty";
                  } else if (value.length < 6) {
                    return "password is short";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Consumer<LoadingProvider>(
                builder: ((context, value, child) {
                  return InkWell(
                    onTap: (() {
                      if (formkey.currentState!.validate()) {
                        value.setLoading(true);
                        authentication.signUp(_emailController.text,
                            _passwordController.text, context);
                      }
                    }),
                    child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade700),
                        child: Center(
                          child: value.isloading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                        )),
                  );
                }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Allready Have an acount?  ",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                InkWell(
                  onTap: (() {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (_) {
                      return const LoginScreen();
                    }));
                  }),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
