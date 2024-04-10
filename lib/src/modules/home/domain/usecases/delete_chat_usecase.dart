import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/domain/errors/chat_exceptions.dart';
import 'package:chat_hive_ai/src/modules/home/domain/repositories/delete_chat_repository.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

class DeleteChatUsecase {
  final DeleteChatRepository _repository;

  DeleteChatUsecase(this._repository);
  Future<Either<List<ChatEntity>, DeleteChatException>> call(
      {required String? userId, required String? chatId}) async {
    if (userId != null && userId.isNotEmpty) {
      if (chatId != null && chatId.isNotEmpty) {
        return await _repository(userId: userId, chatId: chatId);
      }
      return Failure(DeleteChatException(
          label: "$runtimeType", messageErro: "O id da conversa está vazio."));
    }
    return Failure(DeleteChatException(
        label: "$runtimeType", messageErro: "O id do usuário está vazio."));
  }
}
