// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_hive_ai/src/modules/auth/domain/services/is_user_logged_service.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/errors/is_user_logged_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/is_user_logged_repository.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

class IsLoginLoggedRepositoryImpl implements IsUserLoggedRepository {
  IsLoginLoggedRepositoryImpl(this.service);
  final IsUserLoggedService service;

  @override
  Future<Either<UserModel?, IsUserLoggedException>> call() async {
    final res = await service();
    return switch (res) {
      Success<UserModel?, IsUserLoggedServicesException>(:final success) =>
        Success(success),
      Failure<UserModel?, IsUserLoggedServicesException>(:final failure) =>
        Failure(failure)
    };
  }
}
