import 'package:chat_hive_ai/src/modules/auth/presenter/notifiers/auth_notifier.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/provider/auth_provider.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/widgets/login/form_login_widget.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/widgets/register/form_register_widget.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AuthProvider.providers,
      builder: (context, _) {
        final notifier = context.watch<AuthNotifier>();

        return Scaffold(
          body: Center(
              child: Stack(
            alignment: Alignment.center,
            children: [
              notifier.typeAuth == TypeAuth.signIn
                  ? const FormLoginWidget()
                  : const FormRegisterWidget(),
              if (notifier.isLoading) const LoadingPage(),
            ],
          )),
        );
      },
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.black.withOpacity(.5),
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: context.purple,
        ),
      ),
    );
  }
}
