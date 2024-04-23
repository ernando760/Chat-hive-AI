import 'package:chat_hive_ai/src/modules/auth/presenter/provider/barrel/auth_provider_barrel.dart';
import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/notifiers/chat_notifier.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';

class PromptMessageWidget extends StatefulWidget {
  const PromptMessageWidget({super.key});

  @override
  State<PromptMessageWidget> createState() => _PromptMessageWidgetState();
}

class _PromptMessageWidgetState extends State<PromptMessageWidget> {
  final promptMessageEC = TextEditingController();
  final focusNode = FocusNode();
  double height = 45;
  @override
  void dispose() {
    focusNode.dispose();
    promptMessageEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chat = context
        .select<ChatNotifier, ChatEntity?>((value) => value.chatSelected);
    return chat != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ChatHiveAiTextFormField(
                errorStyle: context.caption10Medium,
                height: height,
                width: MediaQuery.sizeOf(context).width * .8,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 11),
                controller: promptMessageEC,
                hintText: "Digite algo...",
                focusNode: focusNode,
                hintStyle: context.body16Medium.copyWith(
                    color: context.isDark
                        ? context.white.withOpacity(.5)
                        : context.black.withOpacity(.5)),
                onTapOutside: (event) => focusNode.unfocus(),
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.sizeOf(context).width * .15,
                child: ChatHiveAIIconButton(
                    shapeBorder: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    icon: const Icon(Icons.send_outlined),
                    onPressed: () async {
                      if (promptMessageEC.text.isEmpty) {
                        return;
                      }
                      await context
                          .read<ChatNotifier>()
                          .sendMessage(message: promptMessageEC.text);
                      promptMessageEC.clear();
                    }),
              )
            ],
          )
        : Container();
  }
}
