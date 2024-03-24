// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/sign_out_repository.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/services/sign_out_service.dart';

class SignOutRepositoryImpl implements SignOutRepository {
  SignOutRepositoryImpl(this.service);

  SignOutService service;

  @override
  Future<void> call() async {
    await service();
  }
}
