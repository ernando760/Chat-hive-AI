import 'dart:convert';

import 'package:chat_hive_ai/src/modules/home/domain/entities/adapters/message_adapter.dart';
import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';

class ChatAdapter {
  ChatAdapter._();
  static Map<String, dynamic> toMap(ChatEntity chat) {
    return <String, dynamic>{
      'chat_id': chat.chatId,
      'title': chat.title,
      'messages': chat.messages.map((x) => MessageAdapter.toMap(x)).toList(),
      'created_at': chat.createdAt?.millisecondsSinceEpoch,
    };
  }

  static ChatEntity fromMap(Map<String, dynamic> map) {
    return ChatEntity(
      chatId: map['chat_id'] != null ? map['chat_id'] as String : null,
      title: map['title'] as String,
      messages: (map["messages"] as List)
          .map((e) => MessageAdapter.fromMap(e))
          .toList(),
      createdAt: map['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int)
          : null,
    );
  }

  static String toJson(ChatEntity chatEntity) => json.encode(toMap(chatEntity));

  static ChatEntity fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);
}
