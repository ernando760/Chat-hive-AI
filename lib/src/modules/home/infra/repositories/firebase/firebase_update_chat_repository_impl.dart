import 'package:chat_hive_ai/src/modules/home/domain/entities/adapters/chat_adapter.dart';
import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/domain/errors/chat_exceptions.dart';
import 'package:chat_hive_ai/src/modules/home/domain/repositories/update_chat_repository.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUpdateChatRepositoryImpl implements UpdateChatRepository {
  @override
  Future<Either<List<ChatEntity>, UpdateChatException>> call(
      {required String chatId, required ChatEntity newChat}) async {
    final firestore = FirebaseFirestore.instance;
    try {
      final coll = firestore.collection("chats");

      await coll.doc(chatId).update(ChatAdapter.toMap(newChat));

      final query = await coll.get();
      final chats =
          query.docs.map((e) => ChatAdapter.fromMap(e.data())).toList();
      return Success(chats);
    } on FirebaseException catch (e) {
      return Failure(UpdateChatException(
          label: "$runtimeType-FirebaseException",
          messageErro: "${e.message}",
          stackTrace: e.stackTrace));
    } catch (e, s) {
      return Failure(UpdateChatException(
          label: "$runtimeType.call",
          messageErro: e.toString(),
          stackTrace: s));
    }
  }
}
