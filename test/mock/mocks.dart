import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/email_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/password_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/home/domain/entities/adapters/chat_adapter.dart';
import 'package:chat_hive_ai/src/modules/home/domain/entities/adapters/message_adapter.dart';
import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';

const userDtoMock = UserDto(
    username: "fulano",
    email: EmailDto(email: "fulano@fulano.com"),
    password: PasswordDto(password: "fulano123"));

const userModelMock =
    UserEntity(username: "fulano", email: EmailDto(email: "fulano@fulano.com"));

final messagesToMap = [
  {"id": "id_1", "message": "wdwdwwd", "sender": "me"},
  {"id": "id_2", "message": "wdwdwwd", "sender": "robot"},
  {"id": "id_3", "message": "wdwdwwd", "sender": "me"},
  {"id": "id_4", "message": "wdwdwwd", "sender": "robot"},
  {"id": "id_5", "message": "wdwdwwd", "sender": "me"},
  {"id": "id_6", "message": "wdwdwwd", "sender": "robot"},
  {"id": "id_7", "message": "wdwdwwd", "sender": "me"},
  {"id": "id_8", "message": "wdwdwwd", "sender": "robot"},
];

final chats = <ChatEntity>[
  ChatEntity(chatId: "chat1", title: "title1", messages: messages),
  ChatEntity(chatId: "chat2", title: "title2", messages: messages),
  ChatEntity(chatId: "chat3", title: "title3", messages: messages),
  ChatEntity(chatId: "chat4", title: "title4", messages: messages),
  ChatEntity(chatId: "chat5", title: "title5", messages: messages),
  ChatEntity(chatId: "chat6", title: "title6", messages: messages),
  ChatEntity(chatId: "chat7", title: "title7", messages: messages),
  ChatEntity(chatId: "chat8", title: "title8", messages: messages),
  ChatEntity(chatId: "chat9", title: "title9", messages: messages),
  ChatEntity(chatId: "chat10", title: "title10", messages: messages),
];

final newChat =
    ChatEntity(chatId: "chat5", title: "chat update", messages: messages);

final chatsToMap =
    List<ChatEntity>.from(chats).map((e) => ChatAdapter.toMap(e)).toList();

final messages = List<Map<String, dynamic>>.from(messagesToMap)
    .map((e) => MessageAdapter.fromMap(e))
    .toList();
