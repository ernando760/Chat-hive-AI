import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/domain/errors/chat_exceptions.dart';
import 'package:chat_hive_ai/src/modules/home/domain/repositories/delete_chat_repository.dart';
import 'package:chat_hive_ai/src/modules/home/domain/usecases/delete_chat_usecase.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/mocks.dart';

class MockDeleteChatRepository extends Mock implements DeleteChatRepository {}

void main() {
  final DeleteChatRepository repository = MockDeleteChatRepository();
  final DeleteChatUsecase usecase = DeleteChatUsecase(repository);
  test(
      "Deve retornar um lista de conversas quando chamo a função [deleteChatUsecase.call]",
      () async {
    when(
      () => repository.call(chatId: "chat5"),
    ).thenAnswer((_) async => Success(chats
      ..removeWhere(
        (element) => element.chatId == "chat5",
      )));

    final res = await usecase(chatId: "chat5");

    expect(res.success.length, equals(9));
    expect(res.success, chats);
    expect(res.success, isA<List<ChatEntity>>());
  });

  test(
      "Deve retonar uma exceção com uma menssagem dizendo 'O id da conversa está vazio.' quando chamo a função [deleteChatUsecase.call]",
      () async {
    when(
      () => repository.call(chatId: ""),
    ).thenAnswer((_) async => Failure(DeleteChatException(
        label: "DeleteChatUsecase",
        messageErro: "O id da conversa está vazio.")));
    final res = await usecase(chatId: "");

    expect(res.failure.messageErro, "O id da conversa está vazio.");
  });
}
