import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';

class AuthGoogleButtonWidget extends StatelessWidget {
  const AuthGoogleButtonWidget({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sizeOf.width * .8,
      child: ChatHiveAiGoogleButton(
        iconPath: "assets/images/icons/icon_google.svg",
        padding: const EdgeInsets.symmetric(vertical: 10),
        text: "Continue com o google",
        onPressed: onPressed,
      ),
    );
  }
}
