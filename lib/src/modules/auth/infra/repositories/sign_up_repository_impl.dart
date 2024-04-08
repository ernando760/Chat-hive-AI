import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_up_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/sign_up_repository.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/services/sign_up_service.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:provider/provider.dart';

final $SignUpRepositoryProvider = Provider<SignUpRepository>(
    create: (context) => SignUpRepositoryImpl(context.read<SignUpService>()));

class SignUpRepositoryImpl extends SignUpRepository {
  final SignUpService _service;

  SignUpRepositoryImpl(this._service);
  @override
  Future<Either<UserEntity?, SignUpRepositoryException>> call(
      UserDto userDto) async {
    final res = await _service(userDto);
    return switch (res) {
      Success<UserEntity?, SignUpServiceException>(:final success) =>
        Success(success),
      Failure<UserEntity?, SignUpServiceException>(:final failure) => Failure(
          SignUpRepositoryException(
              label: "$runtimeType => ${failure.label}",
              messageErro: failure.messageErro,
              stackTrace: failure.stackTrace))
    };
  }
}
