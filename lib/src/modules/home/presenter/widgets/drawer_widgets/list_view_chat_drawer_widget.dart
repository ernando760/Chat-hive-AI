import 'package:chat_hive_ai/src/modules/auth/presenter/provider/barrel/auth_provider_barrel.dart';
import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/notifiers/chat_notifier.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/widgets/chat_widgets/card_with_menu_anchor_chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListViewChatDrawerWidget extends StatelessWidget {
  const ListViewChatDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final chats =
        context.select<ChatNotifier, List<ChatEntity>>((value) => value.chats);
    return chats.isEmpty
        ? const Center(
            child: Text("Nenhuma conversa adicionada"),
          )
        : ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              if (index == 2) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("teste"),
                    Provider(
                      create: (context) => MenuController(),
                      child: CardWithMenuAnchorChatWidget(chat: chat),
                    )
                  ],
                );
              }
              return Provider(
                create: (context) => MenuController(),
                child: CardWithMenuAnchorChatWidget(chat: chat),
              );
            },
          );
  }
}
