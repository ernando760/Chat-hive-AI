import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_in_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/sign_in_google_repository.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:provider/provider.dart';

final $SignInGoogleUsecaseProvider = Provider(
    create: (context) =>
        SignInGoogleUsecase(context.read<SignInGoogleRepository>()));

class SignInGoogleUsecase {
  final SignInGoogleRepository _repository;

  SignInGoogleUsecase(this._repository);

  Future<Either<UserEntity?, SignInException>> call() async {
    return await _repository.call();
  }
}
