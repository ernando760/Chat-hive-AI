import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_up_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/user_model.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

abstract class SignUpRepository {
  Future<Either<UserModel?, SignUpRepositoryException>> call(UserDto userDto);
}
