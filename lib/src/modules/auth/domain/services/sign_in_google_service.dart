import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_in_exception.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

abstract class SignInGoogleService {
  Future<Either<UserEntity?, SignInServiceException>> call();
}
