import 'package:flutter/material.dart';

class MyAppMethods {
  static Future<void> showErrorORWarningDialog({
    required BuildContext context,
    required String time,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Seconds'),
                Text('Seconds'),
              ],
            ),
          );
        });
  }
}
