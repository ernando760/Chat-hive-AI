import 'package:chat_hive_ai/src/modules/auth/presenter/provider/barrel/auth_provider_barrel.dart';
import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/notifiers/chat_notifier.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/widgets/chat_widgets/card_message_widget.dart';

import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final chat = context
        .select<ChatNotifier, ChatEntity?>((value) => value.chatSelected);
    final isApploading =
        context.select<ChatNotifier, bool>((value) => value.isApploading);
    return isApploading
        ? Container()
        : chat!.messages.isEmpty
            ? Center(
                child: Text("Faça alguma pergunta...",
                    style: context.body18Medium),
              )
            : ListView.builder(
                itemCount: chat.messages.length,
                itemBuilder: (context, index) {
                  final message = chat.messages[index];

                  return CardMessageWidget(message: message);
                },
              );
  }
}
