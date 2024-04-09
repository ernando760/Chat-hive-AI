import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/is_user_logged_repository.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/services/is_user_logged_service.dart';
import 'package:chat_hive_ai/src/modules/auth/infra/repositories/is_login_logged_repository_impl.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/user_mock.dart';

class IsUserLoggedServiceMock extends Mock implements IsUserLoggedService {}

void main() {
  final IsUserLoggedService service = IsUserLoggedServiceMock();
  final IsUserLoggedRepository repository = IsUserLoggedRepositoryImpl(service);
  test("Quando o usuario estiver logado deve retonar um UserModel", () async {
    when(
      () => service(),
    ).thenAnswer((_) async => Success(userModelMock));

    final res = await repository();

    expect(res.success?.email, equals(userDtoMock.email));
    expect(res.success, isA<UserEntity?>());
    verify(() => service()).called(1);
  });

  test("Quando o usuario não estiver logado deve retonar um valor nulo",
      () async {
    when(
      () => service(),
    ).thenAnswer((_) async => Success(null));

    final res = await repository();

    expect(res.success, isNull);
    expect(res.success, isA<UserEntity?>());
    verify(() => service()).called(1);
  });
}
