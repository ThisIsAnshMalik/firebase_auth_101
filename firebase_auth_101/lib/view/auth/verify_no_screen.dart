import 'package:firebase_auth_101/authentication/authentication.dart';
import 'package:firebase_auth_101/provider/Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyNoScreen extends StatefulWidget {
  final String verificationId;
  const VerifyNoScreen({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<VerifyNoScreen> createState() => _VerifyNoScreenState();
}

class _VerifyNoScreenState extends State<VerifyNoScreen> {
  final TextEditingController _verificationCodeController =
      TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Authentication authentication = Authentication();
    return Form(
      key: formkey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Verify your no."),
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
                  maxLength: 6,
                  controller: _verificationCodeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "enter 6 digit code",
                      hintText: "enter 6 digit code",
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "code should not be empty";
                    } else if (value.length < 6) {
                      return "code no is not valed";
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
                          authentication.verifyNo(widget.verificationId,
                              _verificationCodeController.text, context);
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
                                    "Verify",
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
