import 'package:chat_hive_ai/src/modules/home/domain/entities/adapters/chat_adapter.dart';
import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/domain/errors/chat_exceptions.dart';
import 'package:chat_hive_ai/src/modules/home/domain/repositories/delete_chat_repository.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDeleteChatRepositoryImpl implements DeleteChatRepository {
  @override
  Future<Either<List<ChatEntity>, DeleteChatException>> call(
      {required String chatId}) async {
    final firestore = FirebaseFirestore.instance;
    try {
      final coll = firestore.collection("chats");

      await coll.doc(chatId).delete();

      final query = await coll.get();
      final chats =
          query.docs.map((e) => ChatAdapter.fromMap(e.data())).toList();
      return Success(chats);
    } on FirebaseException catch (e) {
      return Failure(DeleteChatException(
          label: "$runtimeType-FirebaseException",
          messageErro: "${e.message}",
          stackTrace: e.stackTrace));
    } catch (e, s) {
      return Failure(DeleteChatException(
          label: "$runtimeType.call",
          messageErro: e.toString(),
          stackTrace: s));
    }
  }
}
