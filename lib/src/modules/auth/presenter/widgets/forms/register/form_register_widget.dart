import 'package:chat_hive_ai/src/modules/auth/presenter/notifiers/auth_notifier.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/widgets/btns/auth_button_widget.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/widgets/btns/auth_google_button_widget.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/widgets/btns/auth_text_button_widget.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/widgets/text_form_fields/text_form_fied_password_widget.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/widgets/text_form_fields/text_form_field_email_widget.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/widgets/text_form_fields/text_form_field_username_widget.dart';
import 'package:chat_hive_ai/src/shared/widgets/logo_widget.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class FormRegisterWidget extends StatefulWidget {
  const FormRegisterWidget({super.key});

  @override
  State<FormRegisterWidget> createState() => _FormRegisterWidgetState();
}

class _FormRegisterWidgetState extends State<FormRegisterWidget>
    with MessageViewMixin {
  final formRegisterKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<AuthNotifier>();
    return Form(
        key: formRegisterKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LogoWidget(),
              const SizedBox(
                height: 59,
              ),
              const TextFormFieldUsernameWidget(),
              const SizedBox(
                height: 20,
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
                height: 20,
              ),
              AuthButtonWidget(
                label: "Cadastrar",
                onPressed: () async {
                  final nav = Navigator.of(context);
                  final isValid =
                      formRegisterKey.currentState?.validate() ?? false;
                  if (isValid) {
                    await notifier.signUp();
                    messageViewListener(notifier);
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
                  messageViewListener(notifier);
                  if (notifier.user != null) {
                    nav.pushReplacementNamed("/home", arguments: notifier.user);
                  }
                },
              )
            ],
          ),
        ));
  }
}
