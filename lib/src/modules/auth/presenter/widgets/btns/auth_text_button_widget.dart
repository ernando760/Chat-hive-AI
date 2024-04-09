import 'package:chat_hive_ai/src/modules/auth/presenter/notifiers/auth_notifier.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthTextButtonWidget extends StatelessWidget {
  const AuthTextButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<AuthNotifier>();
    return SizedBox(
      width: context.sizeOf.width * .85,
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
            onPressed: () => notifier.setTypeAuth(
                notifier.typeAuth == TypeAuth.signUp
                    ? TypeAuth.signIn
                    : TypeAuth.signUp),
            child: Text(
              notifier.typeAuth == TypeAuth.signUp
                  ? "Você já tem uma conta? entra aqui"
                  : "Você não tem uma conta? cadastra-se aqui",
              style: context.caption10Medium.copyWith(
                  color: context.isDark ? context.gray : context.black2),
            )),
      ),
    );
  }
}
