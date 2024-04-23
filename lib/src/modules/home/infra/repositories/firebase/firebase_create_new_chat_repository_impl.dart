import 'package:chat_hive_ai/src/modules/home/domain/entities/adapters/chat_adapter.dart';
import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/domain/errors/chat_exceptions.dart';
import 'package:chat_hive_ai/src/modules/home/domain/repositories/create_new_chat_repository.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCreateNewChatRepositoryImpl implements CreateNewChatRepository {
  @override
  Future<Either<List<ChatEntity>, CreateNewChatException>> call(
      {required String userId, required String title}) async {
    final firestore = FirebaseFirestore.instance;
    try {
      final coll = firestore.collection("chats");

      final doc = coll.doc();
      await doc.set({
        "user_id": userId,
        "title": title,
        "chat_id": doc.id,
        "messages": [],
        "created_at": DateTime.now().millisecondsSinceEpoch
      });

      final query = await coll.get();
      final chats =
          query.docs.map((e) => ChatAdapter.fromMap(e.data())).toList();
      return Success(chats);
    } on FirebaseException catch (e) {
      return Failure(CreateNewChatException(
          label: "$runtimeType-FirebaseException",
          messageErro: "${e.message}",
          stackTrace: e.stackTrace));
    } catch (e, s) {
      return Failure(CreateNewChatException(
          label: "$runtimeType.call",
          messageErro: e.toString(),
          stackTrace: s));
    }
  }
}
