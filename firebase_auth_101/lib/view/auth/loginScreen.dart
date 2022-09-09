import 'package:firebase_auth_101/firebase/authentication.dart';
import 'package:firebase_auth_101/provider/Provider.dart';
import 'package:firebase_auth_101/view/auth/mobile_login_screen.dart';
import 'package:firebase_auth_101/view/auth/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          automaticallyImplyLeading: false,
          title: const Text("Login Screen"),
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
                },
              ),
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
            Consumer<LoadingProvider>(
              builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: InkWell(
                    onTap: (() {
                      if (formkey.currentState!.validate()) {
                        value.setLoading(true);
                        authentication.login(_emailController.text,
                            _passwordController.text, context);
                      }
                    }),
                    child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade700),
                        child: value.isloading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                              )),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't Have an acount?  ",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                InkWell(
                  onTap: (() {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return const SignUpScreen();
                    }));
                  }),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: InkWell(
                onTap: (() {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: ((context) {
                    return const MobileLogin();
                  })));
                }),
                child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade700),
                    child: const Center(
                      child: Text(
                        "Login With Mobile",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
