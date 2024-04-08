// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/sign_out_repository.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/services/sign_out_service.dart';
import 'package:provider/provider.dart';

final $SignOutRepositoryProvider = Provider<SignOutRepository>(
    create: (context) => SignOutRepositoryImpl(context.read<SignOutService>()));

class SignOutRepositoryImpl implements SignOutRepository {
  SignOutRepositoryImpl(this._service);

  final SignOutService _service;

  @override
  Future<void> call() async {
    await _service();
  }
}
