import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/sign_up_repository.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/services/sign_up_service.dart';
import 'package:chat_hive_ai/src/modules/auth/infra/repositories/sign_up_repository_impl.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/mocks.dart';

class SignUpServiceMock extends Mock implements SignUpService {}

void main() {
  final SignUpService service = SignUpServiceMock();
  final SignUpRepository repository = SignUpRepositoryImpl(service);
  test("Quando o usuario fazer o login deve retonar um UserModel", () async {
    when(() => service(userDtoMock))
        .thenAnswer((_) async => Success(userModelMock));

    final res = await repository(userDtoMock);

    expect(res.success?.email, equals(res.success?.email));
    expect(res.success, isA<UserEntity?>());
    verify(() => service(userDtoMock)).called(1);
  });

  test(
      "Quando o usuario fazer o login, e se ocorrer um error deve retonar nulo",
      () async {
    when(() => service(userDtoMock)).thenAnswer((_) async => Success(null));

    final res = await repository(userDtoMock);

    expect(res.success, isNull);
    expect(res.success, isA<UserEntity?>());
    verify(() => service(userDtoMock)).called(1);
  });
}
