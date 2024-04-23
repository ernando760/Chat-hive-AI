import 'package:chat_hive_ai/src/modules/home/presenter/notifiers/chat_notifier.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';

class CreateChatAlertDialogWidget extends StatefulWidget {
  const CreateChatAlertDialogWidget({super.key, required this.chatNotifier});
  final ChatNotifier chatNotifier;

  @override
  State<CreateChatAlertDialogWidget> createState() =>
      _CreateChatAlertDialogWidgetState();
}

class _CreateChatAlertDialogWidgetState
    extends State<CreateChatAlertDialogWidget> {
  final newChatEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  double height = 45;
  @override
  void dispose() {
    newChatEC.dispose();
    super.dispose();
  }

  Future<void> _createChat() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      final nav = Navigator.of(context);
      await widget.chatNotifier.createNewChat(
          userId: widget.chatNotifier.user!.id, title: newChatEC.text);
      nav.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.chatNotifier,
        builder: (context, _) {
          return AlertDialog(
            title: const Text("Nova conversa"),
            content: SizedBox(
              child: Form(
                  key: formKey,
                  child: ChatHiveAiTextFormField(
                    controller: newChatEC,
                    label: "Titulo",
                    height: height,
                    contentPadding: const EdgeInsets.all(8),
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      }
                      if (height == 45) {
                        setState(() {
                          height += 20;
                        });
                      }
                      return "O titulo não pode está vazio.";
                    },
                  )),
            ),
            actions: [
              ChatHiveAiButton(
                shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    side: BorderSide(color: context.red)),
                child: Text(
                  "Cancelar",
                  style: context.caption12Medium.copyWith(color: context.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ChatHiveAiButton(
                onPressed: _createChat,
                child: const Text("Adicionar"),
              ),
            ],
          );
        });
  }
}
