import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_in_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

abstract class SignInRepository {
  Future<Either<UserEntity?, SignInRepositoryException>> call(UserDto userDto);
}
