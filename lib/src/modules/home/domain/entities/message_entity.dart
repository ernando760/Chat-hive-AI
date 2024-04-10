import 'package:equatable/equatable.dart';

enum MessageSender { me, robot }

class MessageEntity extends Equatable {
  final String? id;
  final String message;
  final MessageSender sender;

  const MessageEntity({this.id, required this.message, required this.sender});

  @override
  String toString() => "$runtimeType(id:$id,message:$message,sender:$sender)";

  @override
  List<Object?> get props => [id, message, sender];
}
