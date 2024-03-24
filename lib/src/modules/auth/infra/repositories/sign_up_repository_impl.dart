import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_up_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/sign_up_repository.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/services/sign_up_service.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

class SignUpRepositoryImpl extends SignUpRepository {
  final SignUpService service;

  SignUpRepositoryImpl(this.service);
  @override
  Future<Either<UserModel?, SignUpRepositoryException>> call(
      UserDto userDto) async {
    final res = await service(userDto);
    return switch (res) {
      Success<UserModel?, SignUpServiceException>(:final success) =>
        Success(success),
      Failure<UserModel?, SignUpServiceException>(:final failure) => Failure(
          SignUpRepositoryException(
              label: "$runtimeType => ${failure.label}",
              messageErro: failure.messageErro,
              stackTrace: failure.stackTrace))
    };
  }
}
