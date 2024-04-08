import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_in_exception.dart';

import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/sign_in_google_repository.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/services/sign_in_google_service.dart';

import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:provider/provider.dart';

final $SignInGoogleRepositoryProvider = Provider<SignInGoogleRepository>(
    create: (context) =>
        SignInGoogleRepositoryImpl(context.read<SignInGoogleService>()));

class SignInGoogleRepositoryImpl implements SignInGoogleRepository {
  SignInGoogleRepositoryImpl(this._service);
  final SignInGoogleService _service;

  @override
  Future<Either<UserEntity?, SignInGoogleRepositoryException>> call() async {
    final res = await _service();

    return switch (res) {
      Success<UserEntity?, SignInServiceException>(:final success) =>
        Success(success),
      Failure<UserEntity?, SignInServiceException>(:final failure) => Failure(
          SignInGoogleRepositoryException(
              label: "$runtimeType => ${failure.label}",
              messageErro: failure.messageErro,
              stackTrace: failure.stackTrace))
    };
  }
}
