import 'dart:ffi';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class Utils {
  toastMessage(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
