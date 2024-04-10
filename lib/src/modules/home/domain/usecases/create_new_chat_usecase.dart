import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/domain/errors/chat_exceptions.dart';

import 'package:chat_hive_ai/src/modules/home/domain/repositories/create_new_chat_repository.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

class CreateNewChatUsecase {
  final CreateNewChatRepository _repository;

  CreateNewChatUsecase(this._repository);
  Future<Either<List<ChatEntity>, CreateNewChatException>> call(
      {String? userId, required String title}) async {
    if (userId != null && userId.isNotEmpty) {
      if (title.isNotEmpty) {
        return await _repository(userId: userId, title: title);
      }
      return Failure(CreateNewChatException(
          label: "$runtimeType", messageErro: "O título está vazio."));
    }
    return Failure(CreateNewChatException(
        label: "$runtimeType", messageErro: "O id do usuário está vazio."));
  }
}
