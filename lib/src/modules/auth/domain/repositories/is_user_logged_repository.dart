import 'package:chat_hive_ai/src/modules/auth/domain/errors/is_user_logged_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/user_model.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

abstract class IsUserLoggedRepository {
  Future<Either<UserModel?, IsUserLoggedException>> call();
}
