import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

class CreateNewChatException extends ExceptionBase {
  CreateNewChatException(
      {required super.label, required super.messageErro, super.stackTrace});
}

class FindAllChatsException extends ExceptionBase {
  FindAllChatsException(
      {required super.label, required super.messageErro, super.stackTrace});
}

class DeleteChatException extends ExceptionBase {
  DeleteChatException(
      {required super.label, required super.messageErro, super.stackTrace});
}

class UpdateChatException extends ExceptionBase {
  UpdateChatException(
      {required super.label, required super.messageErro, super.stackTrace});
}
