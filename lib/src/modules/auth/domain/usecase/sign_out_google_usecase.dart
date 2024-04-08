import 'package:chat_hive_ai/src/modules/auth/domain/repositories/sign_out_google_repository.dart';
import 'package:provider/provider.dart';

final $SignOutGoogleUsecaseProvider = Provider(
    create: (context) =>
        SignOutGoogleUsecase(context.read<SignOutGoogleRepository>()));

class SignOutGoogleUsecase {
  SignOutGoogleUsecase(this._repository);
  final SignOutGoogleRepository _repository;

  Future<void> call() async => await _repository();
}
