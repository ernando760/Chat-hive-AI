import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_in_exception.dart';

import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
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
    when(() => repository.call()).thenAnswer((_) async =>
        Success<UserEntity, SignInGoogleRepositoryException>(userModelMock));

    final res = await usecase();

    debugPrint("${res.success}");
    expect(res, isA<Success<UserEntity, SignInGoogleRepositoryException>>());
    verify(() => repository.call()).called(1);
  });

  test('Quando fazer o login deve retornar um SignInGoogleRepositoryException',
      () async {
    when(() => repository.call()).thenAnswer((_) async =>
        Failure<UserEntity, SignInGoogleRepositoryException>(
            SignInGoogleRepositoryException(
                label: "${repository.runtimeType}",
                messageErro: "Erro ao fazer o login")));

    final res = await usecase();
    debugPrint(res.failure.messageErro);
    expect(res, isA<Failure<UserEntity, SignInGoogleRepositoryException>>());
    verify(() => repository.call()).called(1);
  });

  test(
      'Quando fazer o login e se o email estiver invalido deve retornar um SignInGoogleUsecaseException',
      () async {
    final res = await usecase();
    debugPrint(res.failure.messageErro);
    expect(res, isA<Failure<UserEntity, SignInGoogleUsecaseException>>());
  });

  test(
      'Quando fazer o login e se a senha estiver inválida deve retornar um SignInGoogleUsecaseException',
      () async {
    final res = await usecase();
    expect(res, isA<Failure<UserEntity, SignInGoogleUsecaseException>>());
  });
}
