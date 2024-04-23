import 'dart:convert';

import 'package:chat_hive_ai/src/modules/home/domain/entities/message_entity.dart';

class MessageAdapter {
  MessageAdapter._();
  static Map<String, dynamic> toMap(MessageEntity message) {
    return <String, dynamic>{
      'id': message.id,
      'message': message.message,
      'sender': message.sender.name,
    };
  }

  static MessageEntity fromMap(Map<String, dynamic> map) {
    return MessageEntity(
        id: map['id'] != null ? map['id'] as String : null,
        message: map["message"] as String,
        sender: MessageSender.values
            .firstWhere((element) => element.name == map["sender"] as String));
  }

  static String toJson(MessageEntity messageEntity) =>
      json.encode(toMap(messageEntity));

  static MessageEntity fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);
}
