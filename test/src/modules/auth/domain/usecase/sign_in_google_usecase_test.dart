import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_in_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/email_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/password_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/sign_in_google_repository.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/usecase/sign_in_google_usecase.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/user_mock.dart';

class SignInGoogleRepositoryMock extends Mock
    implements SignInGoogleRepository {}

void main() {
  final repository = SignInGoogleRepositoryMock();
  final usecase = SignInGoogleUsecase(repository);

  test('Deve fazer o login e retornar um UserModel', () async {
    when(() => repository.call(userDtoMock)).thenAnswer((_) async =>
        Success<UserModel, SignInGoogleRepositoryException>(userModelMock));

    final res = await usecase(userDtoMock);

    debugPrint("${res.success}");
    expect(res, isA<Success<UserModel, SignInGoogleRepositoryException>>());
    verify(() => repository.call(userDtoMock)).called(1);
  });

  test('Quando fazer o login deve retornar um SignInGoogleRepositoryException',
      () async {
    when(() => repository.call(userDtoMock)).thenAnswer((_) async =>
        Failure<UserModel, SignInGoogleRepositoryException>(
            SignInGoogleRepositoryException(
                label: "${repository.runtimeType}",
                messageErro: "Erro ao fazer o login")));

    final res = await usecase(userDtoMock);
    debugPrint(res.failure.messageErro);
    expect(res, isA<Failure<UserModel, SignInGoogleRepositoryException>>());
    verify(() => repository.call(userDtoMock)).called(1);
  });

  test(
      'Quando fazer o login e se o email estiver invalido deve retornar um SignInGoogleUsecaseException',
      () async {
    final res = await usecase(const UserDto(
        username: "Fulano",
        email: EmailDto(email: "fulano.com"),
        password: PasswordDto(password: "fulano123")));
    debugPrint(res.failure.messageErro);
    expect(res, isA<Failure<UserModel, SignInGoogleUsecaseException>>());
  });

  test(
      'Quando fazer o login e se a senha estiver inválida deve retornar um SignInGoogleUsecaseException',
      () async {
    final res = await usecase(const UserDto(
        username: "Fulano",
        email: EmailDto(email: "fulano@fulano.com"),
        password: PasswordDto(password: "")));
    expect(res, isA<Failure<UserModel, SignInGoogleUsecaseException>>());
  });
}
