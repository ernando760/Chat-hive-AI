import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';

class Messages {
  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.greenAccent,
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
      content: Text(
        message,
        style: context.caption12Medium.copyWith(color: context.white),
      ),
    ));
  }

  static void showInfo(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.orangeAccent,
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
        content: Text(
          message,
          style: context.caption12Medium.copyWith(color: context.white),
        )));
  }

  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
        content: Text(
          message,
          style: context.caption12Medium.copyWith(color: context.white),
        )));
  }
}
