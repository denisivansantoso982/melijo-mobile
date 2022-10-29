import 'package:flutter/material.dart';
import 'package:melijo/utils/colours.dart';

class LoadingWidget {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: Colours.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: const CircularProgressIndicator(
            color: Colours.deepGreen,
            strokeWidth: 4,
          ),
        ),
      ),
    );
  }

  static void close(BuildContext context) {
    Navigator.of(context).pop();
  }
}
