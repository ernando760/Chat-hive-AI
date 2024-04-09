import 'package:chat_hive_ai/src/modules/auth/presenter/notifiers/auth_notifier.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/widgets/forms/validator/form_validator.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/widgets/text_form_fields/notifier/visibility_password_notifier.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFormFiedPasswordWidget extends StatefulWidget {
  const TextFormFiedPasswordWidget({super.key});

  @override
  State<TextFormFiedPasswordWidget> createState() =>
      _TextFormFiedPasswordWidgetState();
}

class _TextFormFiedPasswordWidgetState
    extends State<TextFormFiedPasswordWidget> {
  double height = 45;
  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<AuthNotifier>();
    return ChangeNotifierProvider(
        create: (context) => VisibilityPasswordNotifier(),
        builder: (context, child) {
          final visibilityPassword =
              context.watch<VisibilityPasswordNotifier>();
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
            label: "Senha",
            prefix: const Icon(
              Icons.password_outlined,
            ),
            suffix: IconButton(
                onPressed: visibilityPassword.toggleVisibility,
                icon: Icon(visibilityPassword.value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined)),
            height: height,
            obscureText: visibilityPassword.value,
            controller: notifier.passwordEC,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            keyboardType: TextInputType.visiblePassword,
            validator: FormValidator.validatePassword,
          );
        });
  }
}
