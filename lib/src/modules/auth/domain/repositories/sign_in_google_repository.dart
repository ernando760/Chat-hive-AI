import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_in_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/user_model.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

abstract class SignInGoogleRepository {
  Future<Either<UserModel, SignInGoogleRepositoryException>> call(
      UserDto userDto);
}
