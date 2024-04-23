import 'package:chat_hive_ai/src/modules/auth/presenter/provider/barrel/auth_provider_barrel.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/notifiers/chat_notifier.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/widgets/drawer_widgets/create_chat_alert_dialog_drawer_widget.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';

class NewChatDrawerWidget extends StatelessWidget {
  const NewChatDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final chatNotifier = context.watch<ChatNotifier>();
    return Row(
      children: [
        SizedBox(
          width: 45,
          height: 45,
          child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CreateChatAlertDialogWidget(
                      chatNotifier: chatNotifier,
                    );
                  },
                );
              },
              icon: const Icon(Icons.add),
              style: IconButton.styleFrom()),
        ),
        const SizedBox(width: 8),
        Text("Nova conversa", style: context.body18Medium)
      ],
    );
  }
}
