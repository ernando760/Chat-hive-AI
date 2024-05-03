import 'package:chat_hive_ai/src/modules/auth/domain/usecase/sign_out_usecase.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/provider/barrel/auth_provider_barrel.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/notifiers/logout_notifier.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/widgets/chat_widgets/menu_card_chat_configs_widget.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';

class ButtonLogoutWidget extends StatelessWidget {
  const ButtonLogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MenuController>();
    return ChangeNotifierProvider(
        create: (context) => LogoutNotifier(
            SignOutUsecase(SignOutRepositoryImpl(FirebaseSignOutServiceImpl())),
            SignOutGoogleUsecase(SignOutGoogleRepositoryImpl(
                FirebaseSignOutGoogleServiceImpl()))),
        builder: (context, _) {
          return MenuCardChatConfigsWidget(
            menuController: controller,
            alignmentOffset: const Offset(0, 20),
            items: [
              ChatHiveAISettingsItems(
                icon: const Icon(Icons.logout_outlined),
                label: "Logout",
                onPressed: () async {
                  final nav = Navigator.of(context);
                  await context.read<LogoutNotifier>().logout();
                  nav.pushReplacementNamed("/splash");
                },
              )
            ],
            child: IconButton(
              icon: const Icon(Icons.more_vert_outlined),
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                  return;
                }
                controller.open(position: const Offset(0, 45));
              },
              style: IconButton.styleFrom(
                  backgroundColor: context.isDark
                      ? context.darkGrey.withOpacity(.5)
                      : context.lightGrey.withOpacity(.5)),
            ),
          );
        });
  }
}
