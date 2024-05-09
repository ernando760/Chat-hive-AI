import 'package:chat_hive_ai/src/modules/auth/presenter/notifiers/auth_notifier.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/widgets/btns/auth_google_button_widget.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/widgets/btns/auth_button_widget.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/widgets/btns/auth_text_button_widget.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/widgets/text_form_fields/text_form_fied_password_widget.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/widgets/text_form_fields/text_form_field_email_widget.dart';
import 'package:chat_hive_ai/src/shared/widgets/logo_widget.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormLoginWidget extends StatefulWidget {
  const FormLoginWidget({super.key});

  @override
  State<FormLoginWidget> createState() => _FormLoginWidgetState();
}

class _FormLoginWidgetState extends State<FormLoginWidget>
    with MessagesViewMixin {
  final formLoginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<AuthNotifier>();
    return Form(
        key: formLoginKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LogoWidget(),
              const SizedBox(
                height: 59,
              ),
              const TextFormFieldEmailWidget(),
              const SizedBox(
                height: 20,
              ),
              const TextFormFiedPasswordWidget(),
              const SizedBox(
                height: 2,
              ),
              const AuthTextButtonWidget(),
              const SizedBox(
                height: 5,
              ),
              AuthButtonWidget(
                label: "Entrar",
                onPressed: () async {
                  final nav = Navigator.of(context);
                  final isValid =
                      formLoginKey.currentState?.validate() ?? false;
                  if (isValid) {
                    await notifier.signIn();
                    if (notifier.user != null) {
                      nav.pushReplacementNamed("/home",
                          arguments: notifier.user);
                    }
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              AuthGoogleButtonWidget(
                onPressed: () async {
                  final nav = Navigator.of(context);
                  await notifier.signInGoogle();
                  messagelistener(notifier);
                  if (notifier.user != null) {
                    nav.pushReplacementNamed("/home", arguments: notifier.user);
                  }
                },
              ),
            ],
          ),
        ));
  }
}
