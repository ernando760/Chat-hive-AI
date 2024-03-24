import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_in_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/sign_in_google_repository.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/services/sign_in_service.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

class SignInGoogleRepositoryImpl implements SignInGoogleRepository {
  SignInGoogleRepositoryImpl(this.service);
  final SignInService service;

  @override
  Future<Either<UserModel?, SignInGoogleRepositoryException>> call(
      UserDto userDto) async {
    final res = await service(userDto);

    return switch (res) {
      Success<UserModel?, SignInServiceException>(:final success) =>
        Success(success),
      Failure<UserModel?, SignInServiceException>(:final failure) => Failure(
          SignInGoogleRepositoryException(
              label: "$runtimeType => ${failure.label}",
              messageErro: failure.messageErro,
              stackTrace: failure.stackTrace))
    };
  }
}
