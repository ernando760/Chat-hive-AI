import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget(
      {super.key, required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sizeOf.width * .8,
      child: ChatHiveAiButton(
        backgroundColor: context.purple,
        padding: const EdgeInsets.symmetric(vertical: 10),
        onPressed: onPressed,
        child: Text(
          label,
          style: context.body16Medium.copyWith(color: context.white),
        ),
      ),
    );
  }
}
