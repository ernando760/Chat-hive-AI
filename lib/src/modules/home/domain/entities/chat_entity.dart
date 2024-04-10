// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:chat_hive_ai/src/modules/home/domain/entities/message_entity.dart';

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

  @override
  String toString() =>
      "$runtimeType(chatId:$chatId,title:$title,messages:$messages,createdAt:$createdAt)";

  @override
  List<Object?> get props => [chatId, title, messages];
}
