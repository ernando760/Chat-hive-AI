import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/domain/errors/chat_exceptions.dart';
import 'package:chat_hive_ai/src/modules/home/domain/repositories/update_chat_repository.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

class UpdateChatUsecase {
  final UpdateChatRepository _repository;

  UpdateChatUsecase(this._repository);

  Future<Either<List<ChatEntity>, UpdateChatException>> call(
      {required ({String? userId, String? chatId}) ids,
      required String title}) async {
    if (ids.chatId != null && ids.userId != null) {
      if (ids.chatId!.isEmpty) {
        return Failure(UpdateChatException(
            label: "$runtimeType",
            messageErro: "O id da conversa está vazio."));
      } else if (ids.userId!.isEmpty) {
        return Failure(UpdateChatException(
            label: "$runtimeType", messageErro: "O id do usuário está vazio."));
      }
      if (title.isEmpty) {
        return Failure(UpdateChatException(
            label: "$runtimeType",
            messageErro: "O titulo não pode está vazio."));
      }
      return await _repository(
          ids: (chatId: ids.chatId!, userId: ids.userId!), title: title);
    }

    return Failure(UpdateChatException(
        label: "$runtimeType",
        messageErro: "O id do usuário e da conversa está vazio."));
  }
}
