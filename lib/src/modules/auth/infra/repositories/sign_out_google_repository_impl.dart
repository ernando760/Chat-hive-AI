import 'package:chat_hive_ai/src/modules/auth/domain/repositories/sign_out_google_repository.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/services/sign_out_google_service.dart';
import 'package:provider/provider.dart';

final $SignOutGoogleRepositoryProvider = Provider<SignOutGoogleRepository>(
    create: (context) =>
        SignOutGoogleRepositoryImpl(context.read<SignOutGoogleService>()));

class SignOutGoogleRepositoryImpl implements SignOutGoogleRepository {
  final SignOutGoogleService _service;

  SignOutGoogleRepositoryImpl(this._service);

  @override
  Future<void> call() async {
    await _service.call();
  }
}
