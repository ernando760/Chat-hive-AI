import 'package:chat_hive_ai/src/modules/auth/domain/errors/is_user_logged_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/is_user_logged_repository.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

class IsUserLoggedUsecase {
  final IsUserLoggedRepository repository;

  IsUserLoggedUsecase(this.repository);

  Future<Either<UserModel?, IsUserLoggedException>> call() async {
    return repository();
  }
}
