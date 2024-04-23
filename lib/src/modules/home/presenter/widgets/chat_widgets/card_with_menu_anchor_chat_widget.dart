import 'package:chat_hive_ai/src/modules/auth/presenter/provider/barrel/auth_provider_barrel.dart';
import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/notifiers/chat_notifier.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/widgets/chat_widgets/menu_card_chat_configs_widget.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/widgets/drawer_widgets/rename_title_alert_dialog_widget.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';

class CardWithMenuAnchorChatWidget extends StatelessWidget {
  const CardWithMenuAnchorChatWidget({super.key, required this.chat});
  final ChatEntity chat;
  @override
  Widget build(BuildContext context) {
    final chatNotifier = context.read<ChatNotifier>();
    final controller = context.watch<MenuController>();
    return ChatHiveAiButton(
      onPressed: () {
        final scaffoldState = Scaffold.of(context);
        context.read<ChatNotifier>().selectChat(chat);
        if (scaffoldState.isDrawerOpen) {
          scaffoldState.closeDrawer();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.chat_outlined),
          const SizedBox(width: 8),
          Text(chat.title,
              style: context.caption12Medium
                  .copyWith(overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 8),
          MenuCardChatConfigsWidget(
              menuController: controller,
              alignmentOffset: const Offset(50, -25),
              items: [
                ChatHiveAISettingsItems(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) => RenameTitleAlertDialogWidget(
                              chatNotifier: chatNotifier,
                              chatId: chat.chatId!));
                      await chatNotifier.renameChatTitle(
                          chatId: chat.chatId, title: "");
                      controller.close();
                    },
                    icon: const Icon(Icons.edit),
                    label: "renomear"),
                ChatHiveAISettingsItems(
                  onPressed: () async {
                    context.read<ChatNotifier>().selectChat(chat);
                    await context
                        .read<ChatNotifier>()
                        .deleteChat(chatId: chat.chatId);
                    controller.close();
                  },
                  icon: Icon(
                    Icons.delete,
                    color: context.red,
                  ),
                  label: "remover",
                  labelStyle:
                      context.caption12Medium.copyWith(color: context.red),
                ),
              ],
              child: IconButton(
                  onPressed: () async {
                    if (controller.isOpen) {
                      controller.close();
                      return;
                    }
                    controller.open(position: const Offset(55, 0));
                  },
                  icon: const Icon(Icons.more_vert_outlined)))
        ],
      ),
    );
  }
}
