import 'package:chat_hive_ai/src/modules/auth/domain/repositories/sign_out_repository.dart';
import 'package:provider/provider.dart';

final signOutUsecaseProvider = Provider(
    create: (context) => SignOutUsecase(context.read<SignOutRepository>()));

class SignOutUsecase {
  SignOutUsecase(this._repository);
  final SignOutRepository _repository;

  Future<void> call() async => await _repository();
}
