import 'package:chat_hive_ai/src/modules/auth/domain/repositories/sign_out_repository.dart';

class SignOutUsecase {
  SignOutUsecase(this.repository);
  final SignOutRepository repository;

  Future<void> call() async => await repository();
}
