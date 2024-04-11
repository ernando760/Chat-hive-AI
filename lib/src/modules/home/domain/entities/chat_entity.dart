// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:chat_hive_ai/src/modules/home/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';

class ChatEntity extends Equatable {
  final String? chatId;
  final String title;
  final List<MessageEntity> messages;
  final DateTime? createdAt;

  const ChatEntity(
      {required this.chatId,
      required this.title,
      required this.messages,
      this.createdAt});

  ChatEntity copyWith(
      {ValueGetter<String>? chatId,
      ValueGetter<String>? title,
      ValueGetter<List<MessageEntity>>? messages,
      ValueGetter<DateTime>? createdAt}) {
    return ChatEntity(
        chatId: chatId != null ? chatId() : this.chatId,
        title: title != null ? title() : this.title,
        messages: messages != null ? messages() : this.messages,
        createdAt: createdAt != null ? createdAt() : this.createdAt);
  }

  @override
  String toString() =>
      "$runtimeType(chatId:$chatId,title:$title,messages:$messages,createdAt:$createdAt)";

  @override
  List<Object?> get props => [chatId, title, messages];
}
