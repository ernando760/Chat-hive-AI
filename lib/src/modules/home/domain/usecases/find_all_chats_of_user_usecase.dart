import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/domain/errors/chat_exceptions.dart';
import 'package:chat_hive_ai/src/modules/home/domain/repositories/find_all_chats_of_user_repository.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

class FindAllChatsOfUserUsecase {
  final FindAllChatsOfUserRepository _repository;

  FindAllChatsOfUserUsecase(this._repository);
  Future<Either<List<ChatEntity>, FindAllChatsException>> call(
      {required String? userId, int limits = 10}) async {
    if (userId != null && userId.isNotEmpty) {
      return await _repository(userId: userId, limits: limits);
    }
    return Failure(FindAllChatsException(
        label: "$runtimeType", messageErro: "O id do usuário está vazio."));
  }
}
