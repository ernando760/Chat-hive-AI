import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/sign_in_google_repository.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/services/sign_in_google_service.dart';
import 'package:chat_hive_ai/src/modules/auth/infra/repositories/sign_in_google_repository_impl.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/user_mock.dart';

class SignInGoogleServiceMock extends Mock implements SignInGoogleService {}

void main() {
  final SignInGoogleService service = SignInGoogleServiceMock();
  final SignInGoogleRepository repository = SignInGoogleRepositoryImpl(service);
  test("Quando o usuario fazer o login deve retonar um UserModel", () async {
    when(() => service()).thenAnswer((_) async => Success(userModelMock));

    final res = await repository();

    expect(res.success?.email, equals(res.success?.email));
    expect(res.success, isA<UserEntity?>());
    verify(() => service()).called(1);
  });

  test(
      "Quando o usuario fazer o login, e se ocorrer um error deve retonar nulo",
      () async {
    when(() => service()).thenAnswer((_) async => Success(null));

    final res = await repository();

    expect(res.success, isNull);
    expect(res.success, isA<UserEntity?>());
    verify(() => service()).called(1);
  });
}
