// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_hive_ai/src/modules/auth/domain/services/is_user_logged_service.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/errors/is_user_logged_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/is_user_logged_repository.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:provider/provider.dart';

final $IsUserLoggedRepositoryProvider = Provider<IsUserLoggedRepository>(
    create: (context) =>
        IsUserLoggedRepositoryImpl(context.read<IsUserLoggedService>()));

class IsUserLoggedRepositoryImpl implements IsUserLoggedRepository {
  IsUserLoggedRepositoryImpl(this._service);
  final IsUserLoggedService _service;

  @override
  Future<Either<UserEntity?, IsUserLoggedException>> call() async {
    final res = await _service();
    return switch (res) {
      Success<UserEntity?, IsUserLoggedServicesException>(:final success) =>
        Success(success),
      Failure<UserEntity?, IsUserLoggedServicesException>(:final failure) =>
        Failure(failure)
    };
  }
}
