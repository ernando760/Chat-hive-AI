import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum MessageSender { me, robot }

class MessageEntity extends Equatable {
  final String? id;
  final String message;
  final MessageSender sender;

  const MessageEntity({this.id, required this.message, required this.sender});

  MessageEntity copyWith({
    ValueGetter<String>? id,
    ValueGetter<String>? message,
    ValueGetter<MessageSender>? sender,
  }) {
    return MessageEntity(
        id: id != null ? id() : this.id,
        message: message != null ? message() : this.message,
        sender: sender != null ? sender() : this.sender);
  }

  @override
  String toString() => "$runtimeType(id:$id,message:$message,sender:$sender)";

  @override
  List<Object?> get props => [id, message, sender];
}
