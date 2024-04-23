import 'package:chat_hive_ai/src/modules/home/presenter/widgets/drawer_widgets/info_user_drawer_widget.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/widgets/drawer_widgets/list_view_chat_drawer_widget.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/widgets/drawer_widgets/button_new_chat_drawer_widget.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * .7,
      child: ChatHiveAiDrawer(
        isDivider: true,
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 28, bottom: 10),
        headerDrawer: const Column(
          children: [
            InfoUserDrawerWidget(),
            SizedBox(height: 16),
            NewChatDrawerWidget()
          ],
        ),
        bodyDrawer: const ListViewChatDrawerWidget(),
        footerDrawer: ChatHiveAiButton(
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 5),
          child: Row(
            children: [
              const Icon(Icons.settings_outlined, size: 26),
              const SizedBox(width: 5),
              Text(
                "Configurações",
                style: context.body16Medium,
              )
            ],
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
