import 'package:chat_hive_ai/src/modules/auth/presenter/notifiers/auth_notifier.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/widgets/forms/validator/form_validator.dart';

import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFormFieldUsernameWidget extends StatefulWidget {
  const TextFormFieldUsernameWidget({super.key});

  @override
  State<TextFormFieldUsernameWidget> createState() =>
      _TextFormFieldUsernameWidgetState();
}

class _TextFormFieldUsernameWidgetState
    extends State<TextFormFieldUsernameWidget> {
  double height = 45;
  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<AuthNotifier>();
    return ChatHiveAiTextFormField(
      statesController: MaterialStatesController(),
      onListenMaterialState: (states) {
        if (states.contains(MaterialState.error)) {
          if (height == 45) {
            setState(() {
              height += 20;
            });
          }
        }
      },
      prefix: const Icon(Icons.person_2_outlined),
      label: "Nome do usúario",
      height: height,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      controller: notifier.usernameEC,
      validator: FormValidator.validateUsername,
    );
  }
}
