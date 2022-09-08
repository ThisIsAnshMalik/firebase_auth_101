import 'package:firebase_auth_101/authentication/authentication.dart';
import 'package:firebase_auth_101/provider/Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MobileLogin extends StatefulWidget {
  const MobileLogin({Key? key}) : super(key: key);

  @override
  State<MobileLogin> createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  final _phoneNoController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Authentication authentication = Authentication();
    return Form(
      key: formkey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Mobile Login"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _phoneNoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Mobile No",
                      hintText: "enter mobile no",
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "phone no should not be empty";
                    } else if (value.length < 10) {
                      return "phone no is not valed";
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
                          authentication.loginWithNo(
                              _phoneNoController.text, context);
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
                                    "Send Code",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
