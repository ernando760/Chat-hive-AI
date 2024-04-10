import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_in_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/email_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/password_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/sign_in_repository.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/usecase/sign_in_usecase.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/mocks.dart';

class SignInRepositoryMock extends Mock implements SignInRepository {}

void main() {
  final repository = SignInRepositoryMock();
  final usecase = SignInUsecase(repository);

  test('Deve fazer o login e retornar um UserModel', () async {
    when(() => repository.call(userDtoMock)).thenAnswer((_) async =>
        Success<UserEntity, SignInRepositoryException>(userModelMock));

    final res = await usecase(userDtoMock);

    expect(res, isA<Success<UserEntity, SignInRepositoryException>>());
    verify(() => repository.call(userDtoMock)).called(1);
  });

  test('Quando fazer o login deve retornar um SignInRepositoryException',
      () async {
    when(() => repository.call(userDtoMock)).thenAnswer((_) async =>
        Failure<UserEntity, SignInRepositoryException>(
            SignInRepositoryException(
                label: "${repository.runtimeType}",
                messageErro: "Erro ao fazer o login")));

    final res = await usecase(userDtoMock);

    expect(res, isA<Failure<UserEntity, SignInRepositoryException>>());
    verify(() => repository.call(userDtoMock)).called(1);
  });

  test(
      'Quando fazer o login e se o email estiver invalido deve retornar um SignInUsecaseException',
      () async {
    final res = await usecase(const UserDto(
        username: "Fulano",
        email: EmailDto(email: "fulano.com"),
        password: PasswordDto(password: "fulano123")));

    expect(res, isA<Failure<UserEntity, SignInUsecaseException>>());
  });

  test(
      'Quando fazer o login e se a senha estiver inválida deve retornar um SignInUsecaseException',
      () async {
    final res = await usecase(const UserDto(
        username: "Fulano",
        email: EmailDto(email: "fulano@fulano.com"),
        password: PasswordDto(password: "")));

    expect(res, isA<Failure<UserEntity, SignInUsecaseException>>());
  });
}
