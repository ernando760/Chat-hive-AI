import 'package:chat_hive_ai/src/modules/home/domain/entities/message_entity.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CardMessageWidget extends StatelessWidget {
  const CardMessageWidget({super.key, required this.message});
  final MessageEntity message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.sender == MessageSender.me
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
            color: message.sender == MessageSender.me
                ? context.purple
                : context.isDark
                    ? context.black2
                    : context.gray,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: MarkdownBody(
          data: message.message,
          styleSheet: MarkdownStyleSheet(
              p: context.caption12Medium.copyWith(fontSize: 15)),
        ),
      ),
    );
  }
}
