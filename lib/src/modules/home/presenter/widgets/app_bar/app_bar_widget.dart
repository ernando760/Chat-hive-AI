import 'package:chat_hive_ai/src/modules/auth/presenter/provider/barrel/auth_provider_barrel.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/notifiers/chat_notifier.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/widgets/app_bar/button_logout_widget.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoadingSendMessage = context
        .select<ChatNotifier, bool>((value) => value.isLoadingSendMessage);
    return AppBar(
      elevation: 0,
      backgroundColor: context.isDark ? context.black : context.white,
      actions: [
        Provider(
            create: (context) => MenuController(),
            child: const ButtonLogoutWidget())
      ],
      bottom: isLoadingSendMessage
          ? const PreferredSize(
              preferredSize: Size.fromHeight(2),
              child: LinearProgressIndicator())
          : null,
      centerTitle: true,
      title: Text(
        'CHAT HIVE AI',
        style: context.body18Medium
            .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
