import 'package:flutter/material.dart';

class UiUtils {
  static void showSnackBar(
      {required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
