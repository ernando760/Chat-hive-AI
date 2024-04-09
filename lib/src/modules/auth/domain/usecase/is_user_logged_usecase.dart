import 'package:chat_hive_ai/src/modules/auth/domain/errors/is_user_logged_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/is_user_logged_repository.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:provider/provider.dart';

final $IsUserLoggedUsecaseProvider = Provider(
    create: (context) =>
        IsUserLoggedUsecase(context.read<IsUserLoggedRepository>()));

class IsUserLoggedUsecase {
  final IsUserLoggedRepository _repository;

  IsUserLoggedUsecase(this._repository);

  Future<Either<UserEntity?, IsUserLoggedException>> call() async {
    return _repository();
  }
}
