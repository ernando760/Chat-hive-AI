import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/provider/barrel/auth_provider_barrel.dart';
import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/notifiers/chat_notifier.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/widgets/app_bar/app_bar_widget.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/widgets/chat_widgets/messages_widget.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/widgets/chat_widgets/prompt_message_widget.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/widgets/drawer_widgets/drawer_widget.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/widgets/floating_button_widget.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.user});
  final UserEntity? user;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MessagesViewMixin {
  @override
  void initState() {
    super.initState();
    final chatNotifier = context.read<ChatNotifier>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      messagelistener(chatNotifier);
      await chatNotifier.findAllChatOfUser(userId: widget.user!.id);
      chatNotifier.getUser(widget.user);
    });
  }

  @override
  Widget build(BuildContext context) {
    final chat = context
        .select<ChatNotifier, ChatEntity?>((value) => value.chatSelected);
    final isAppLoading =
        context.select<ChatNotifier, bool>((value) => value.isApploading);
    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: const AppBarWidget(),
        body: Center(
          child: isAppLoading
              ? CircularProgressIndicator(
                  color: context.purple.withOpacity(.5),
                  valueColor: AlwaysStoppedAnimation(context.purple))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: chat == null
                            ? const Center(
                                child: Text("Cria uma conversa"),
                              )
                            : const ChatMessageWidget(),
                      ),
                    ),
                    const PromptMessageWidget()
                  ],
                ),
        ),
        floatingActionButton: const FloatingButtonWidget());
  }
}
