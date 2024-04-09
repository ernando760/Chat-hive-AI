import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_up_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/email_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/password_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/sign_up_repository.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/usecase/sign_up_usecase.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/user_mock.dart';

class SignUpRepositoryMock extends Mock implements SignUpRepository {}

void main() {
  final repository = SignUpRepositoryMock();
  final usecase = SignUpUsecase(repository);

  test('Deve fazer o cadastro e retornar um UserModel', () async {
    when(() => repository.call(userDtoMock)).thenAnswer((_) async =>
        Success<UserEntity, SignUpRepositoryException>(userModelMock));

    final res = await usecase(userDtoMock);

    expect(res, isA<Success<UserEntity, SignUpRepositoryException>>());
    verify(() => repository.call(userDtoMock)).called(1);
  });

  test('Quando fazer o cadastro deve retornar um SignUpRepositoryException',
      () async {
    when(() => repository.call(userDtoMock)).thenAnswer((_) async =>
        Failure<UserEntity, SignUpRepositoryException>(
            SignUpRepositoryException(
                label: "${repository.runtimeType}",
                messageErro: "Erro ao fazer o cadastro")));

    final res = await usecase(userDtoMock);

    expect(res, isA<Failure<UserEntity, SignUpRepositoryException>>());
    verify(() => repository.call(userDtoMock)).called(1);
  });

  test(
      'Quando fazer o cadastro e se o email estiver invalido deve retornar um SignUpUsecaseException',
      () async {
    final res = await usecase(const UserDto(
        username: "Fulano",
        email: EmailDto(email: "fulano.com"),
        password: PasswordDto(password: "fulano123")));

    expect(res, isA<Failure<UserEntity, SignUpUsecaseException>>());
  });

  test(
      'Quando fazer o cadastro e se a senha estiver inválida deve retornar um SignUpUsecaseException',
      () async {
    final res = await usecase(const UserDto(
        username: "Fulano",
        email: EmailDto(email: "fulano@fulano.com"),
        password: PasswordDto(password: "")));

    expect(res, isA<Failure<UserEntity, SignUpUsecaseException>>());
  });
}
