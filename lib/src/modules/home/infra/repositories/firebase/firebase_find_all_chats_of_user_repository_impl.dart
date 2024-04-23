import 'package:chat_hive_ai/src/modules/home/domain/entities/adapters/chat_adapter.dart';
import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/domain/errors/chat_exceptions.dart';
import 'package:chat_hive_ai/src/modules/home/domain/repositories/find_all_chats_of_user_repository.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFindAllChatsOfUserRepositoryImpl
    implements FindAllChatsOfUserRepository {
  @override
  Future<Either<List<ChatEntity>, FindAllChatsException>> call(
      {required String userId, required int limits}) async {
    final firestore = FirebaseFirestore.instance;
    try {
      final chatColl = firestore.collection("chats").limit(limits);

      final query = await chatColl.get();
      if (query.docs.isEmpty) {
        return Success([]);
      }
      final chats = query.docs
          .where((element) => element.data()["user_id"] == userId)
          .map((e) => ChatAdapter.fromMap(e.data()))
          .toList();

      return Success(chats);
    } on FirebaseException catch (e) {
      return Failure(FindAllChatsException(
          label: "$runtimeType-FirebaseException",
          messageErro: "${e.message}",
          stackTrace: e.stackTrace));
    } catch (e, s) {
      return Failure(FindAllChatsException(
          label: "$runtimeType.call",
          messageErro: e.toString(),
          stackTrace: s));
    }
  }
}
