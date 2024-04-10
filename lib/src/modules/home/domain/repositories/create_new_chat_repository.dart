import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/domain/errors/chat_exceptions.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

abstract class CreateNewChatRepository {
  Future<Either<List<ChatEntity>, CreateNewChatException>> call(
      {required String userId, required String title});
}
