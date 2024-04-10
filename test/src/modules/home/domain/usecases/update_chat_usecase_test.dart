import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/domain/repositories/update_chat_repository.dart';
import 'package:chat_hive_ai/src/modules/home/domain/usecases/update_chat_usecase.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/mocks.dart';

class MockUpdateChatRepository extends Mock implements UpdateChatRepository {}

void main() {
  final UpdateChatRepository repository = MockUpdateChatRepository();
  final UpdateChatUsecase usecase = UpdateChatUsecase(repository);

  List<ChatEntity> updateChat(String id, String title) {
    return chats.map(
      (element) {
        if (element.chatId != id) {
          return element;
        }
        element = ChatEntity(chatId: id, title: title, messages: messages);
        return element;
      },
    ).toList();
  }

  test(
      "Deve retornar um lista de conversas quando chamo a função [findAllchatsOfUser]",
      () async {
    final newChats = updateChat("chat5", "chat update");
    when(
      () => repository
          .call(ids: (userId: "userId", chatId: "chat5"), title: "chat update"),
    ).thenAnswer((_) async => Success(newChats));

    final res = await usecase(
        ids: (userId: "userId", chatId: "chat5"), title: "chat update");
    expect(res.success, newChats);
    expect(
        res.success
            .firstWhere((element) => element.title == "chat update")
            .title,
        equals(newChats
            .firstWhere((element) => element.title == "chat update")
            .title));
    expect(res.success, isA<List<ChatEntity>>());
  });

  test(
      "Deve retornar uma Exceção com a messagem dizendo 'O id do usuário está vazio.', quando chamo a função [updateChatUsecase.call]",
      () async {
    final res =
        await usecase(ids: (userId: "", chatId: "chat5"), title: "chat update");

    expect(res.failure.messageErro, 'O id do usuário está vazio.');
  });

  test(
      "Deve retonar uma exceção com uma menssagem dizendo 'O id da conversa está vazio.' quando chamo a função [updateChatUsecase.call]",
      () async {
    final res = await usecase(
        ids: (userId: "userId", chatId: ""), title: "chat update");

    expect(res.failure.messageErro, "O id da conversa está vazio.");
  });

  test(
      "Deve retonar uma exceção com uma menssagem dizendo 'O titulo não pode está vazio.' quando chamo a função [updateChatUsecase.call]",
      () async {
    final res =
        await usecase(ids: (userId: "userId", chatId: "chat5"), title: "");

    expect(res.failure.messageErro, "O titulo não pode está vazio.");
  });
  test(
      "Deve retonar uma exceção com uma menssagem dizendo 'O id do usuário e da conversa está vazio.' quando chamo a função [updateChatUsecase.call]",
      () async {
    final res =
        await usecase(ids: (userId: null, chatId: null), title: "chat update");

    expect(
        res.failure.messageErro, "O id do usuário e da conversa está vazio.");
  });
}
