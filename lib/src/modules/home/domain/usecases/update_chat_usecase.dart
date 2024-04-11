import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/domain/errors/chat_exceptions.dart';
import 'package:chat_hive_ai/src/modules/home/domain/repositories/update_chat_repository.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

class UpdateChatUsecase {
  final UpdateChatRepository _repository;

  UpdateChatUsecase(this._repository);

  Future<Either<List<ChatEntity>, UpdateChatException>> call(
      {required String? chatId, required ChatEntity newChat}) async {
    if (chatId != null && chatId.isNotEmpty) {
      if (newChat.title.isEmpty) {
        return Failure(UpdateChatException(
            label: "$runtimeType",
            messageErro: "O titulo não pode está vazio."));
      }
      return await _repository(chatId: chatId, newChat: newChat);
    }

    return Failure(UpdateChatException(
        label: "$runtimeType", messageErro: "O id da conversa está vazio."));
  }
}
