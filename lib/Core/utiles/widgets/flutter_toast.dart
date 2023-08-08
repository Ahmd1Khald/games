import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void myToast({required var state, required ToastState toastState}) =>
    Fluttertoast.showToast(
        msg: '$state',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        backgroundColor: toastColor(toastState),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { success, warning, error }

Color toastColor(ToastState state) {
  Color? color;
  if (state == ToastState.success) {
    color = Colors.green;
  } else if (state == ToastState.warning) {
    color = Colors.amber;
  } else {
    color = Colors.red;
  }
  return color;
}
