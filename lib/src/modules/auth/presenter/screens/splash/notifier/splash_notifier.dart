// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/errors/is_user_logged_exception.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';

import 'package:chat_hive_ai/src/modules/auth/domain/usecase/is_user_logged_usecase.dart';
import 'package:provider/provider.dart';

final $SplashNotifier = ChangeNotifierProvider(
  lazy: true,
  create: (context) => SplashNotifier(context.read<IsUserLoggedUsecase>()),
);

class SplashNotifier extends ChangeNotifier {
  SplashNotifier(this._isUserLoggedUsecase) {
    Future(() async {
      await isUserLogged();
    });
  }

  final IsUserLoggedUsecase _isUserLoggedUsecase;

  UserEntity? user;
  Future<void> isUserLogged() async {
    final res = await _isUserLoggedUsecase();

    switch (res) {
      case Success<UserEntity?, IsUserLoggedException>(:final success):
        user = success;
        log("${user?.email}", name: "User");
        notifyListeners();
      case Failure<UserEntity?, IsUserLoggedException>(:final failure):
        log(failure.messageErro,
            error: failure.label, stackTrace: failure.stackTrace);
        notifyListeners();
    }
  }
}
