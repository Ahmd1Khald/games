import 'package:flutter/material.dart';

loadingPage({required context}) => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
        child: circleLoading(color: Colors.white),
      ),
    );

Widget circleLoading({required Color color}) => Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
