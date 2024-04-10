import 'package:chat_hive_ai/src/modules/home/domain/entities/chat_entity.dart';
import 'package:chat_hive_ai/src/modules/home/domain/errors/chat_exceptions.dart';
import 'package:chat_hive_ai/src/modules/home/domain/repositories/find_all_chats_of_user_repository.dart';
import 'package:chat_hive_ai/src/modules/home/domain/usecases/find_all_chats_of_user_usecase.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/mocks.dart';

class MockFindAllChatsOfUserRepository extends Mock
    implements FindAllChatsOfUserRepository {}

void main() {
  final FindAllChatsOfUserRepository repository =
      MockFindAllChatsOfUserRepository();
  final FindAllChatsOfUserUsecase findAllChatsOfUserUsecase =
      FindAllChatsOfUserUsecase(repository);
  test(
      "Deve retornar um lista de conversas quando chamo a função [findAllchatsOfUserUsecase.call]",
      () async {
    when(
      () => repository.call(userId: "userId", limits: 10),
    ).thenAnswer((_) async => Success(chats));

    final res = await findAllChatsOfUserUsecase(userId: "userId", limits: 10);

    expect(res.success.length, equals(10));
    expect(res.success, chats);
    expect(res.success, isA<List<ChatEntity>>());
  });

  test(
      "Deve retornar uma Exceção com a messagem dizendo 'O id do usuário está vazio.', quando chamo a função [findAllchatsOfUserUsecase.call]",
      () async {
    when(
      () => repository.call(userId: "", limits: 10),
    ).thenAnswer((_) async => Failure(FindAllChatsException(
        label: "FindAllChatsOfUserUsecase",
        messageErro: 'O id do usuário está vazio.')));

    final res = await findAllChatsOfUserUsecase(userId: "", limits: 10);

    expect(res.failure.messageErro, 'O id do usuário está vazio.');
  });
}
