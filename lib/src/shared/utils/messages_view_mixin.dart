import 'package:chat_hive_ai/src/shared/utils/messages.dart';
import 'package:chat_hive_ai/src/shared/utils/messages_state_mixin.dart';
import 'package:flutter/material.dart';

mixin MessagesViewMixin<T extends StatefulWidget> on State<T> {
  void messagelistener(MessagesStateMixin messagesStateMixin) {
    final MessagesStateMixin(:typeMessage, :message) = messagesStateMixin;
    switch (typeMessage) {
      case TypeMessage.error:
        Messages.showError(context, message!);
      case TypeMessage.success:
        Messages.showSuccess(context, message!);
      case TypeMessage.info:
        Messages.showInfo(context, message!);
      case _:
    }
  }
}
