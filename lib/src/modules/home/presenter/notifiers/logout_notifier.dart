import 'package:chat_hive_ai/src/modules/auth/domain/usecase/sign_out_google_usecase.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/usecase/sign_out_usecase.dart';
import 'package:flutter/material.dart';

class LogoutNotifier extends ChangeNotifier {
  LogoutNotifier(this._signOutUsecase, this._signOutGoogleUsecase);

  final SignOutUsecase _signOutUsecase;
  final SignOutGoogleUsecase _signOutGoogleUsecase;

  Future<void> logout() async {
    await Future.wait([_signOutUsecase(), _signOutGoogleUsecase()]);
  }
}
