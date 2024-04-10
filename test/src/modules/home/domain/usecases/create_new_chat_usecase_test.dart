import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/domain/errors/chat_exceptions.dart';
import 'package:chat_hive_ai/src/modules/home/domain/repositories/create_new_chat_repository.dart';
import 'package:chat_hive_ai/src/modules/home/domain/usecases/create_new_chat_usecase.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/user_mock.dart';

class MockCreateNewChatRepository extends Mock
    implements CreateNewChatRepository {}

void main() {
  final CreateNewChatRepository repository = MockCreateNewChatRepository();
  final CreateNewChatUsecase usecase = CreateNewChatUsecase(repository);
  test(
      "Deve retonar um lista de conversas quando chamo a função [createNewChatUsecase.call]",
      () async {
    final newChat =
        ChatEntity(chatId: "chatId", title: "title", messages: messages);
    when(
      () => repository.call(userId: "userId", title: "title"),
    ).thenAnswer((_) async => Success([...chats, newChat]));
    final res = await usecase(userId: "userId", title: "title");
    final findChat =
        res.success.firstWhere((element) => element.title == "title");
    expect(res.success.length, equals(11));
    expect(findChat.title, equals(newChat.title));
  });

  test(
      "Deve retonar uma exceção com uma menssagem dizendo 'O id do usuário está vazio.' quando chamo a função [createNewChatUsecase.call]",
      () async {
    when(
      () => repository.call(userId: "", title: "title"),
    ).thenAnswer((_) async => Failure(CreateNewChatException(
        label: "CreateNewChatUsecase",
        messageErro: "O id do usuário está vazio.")));
    final res = await usecase(userId: "", title: "title");

    expect(res.failure.messageErro, "O id do usuário está vazio.");
  });
  test(
      "Deve retonar uma exceção com uma menssagem dizendo 'O título está vazio.' quando chamo a função [createNewChatUsecase.call]",
      () async {
    when(
      () => repository.call(userId: "userId", title: ""),
    ).thenAnswer((_) async => Failure(CreateNewChatException(
        label: "CreateNewChatUsecase", messageErro: "O título está vazio.")));
    final res = await usecase(userId: "userId", title: "");

    expect(res.failure.messageErro, "O título está vazio.");
  });
}
