import 'dart:developer';

import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/email_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/password_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/provider/barrel/auth_provider_barrel.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/notifiers/form_auth_mixin.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

import 'package:flutter/material.dart';

final $AuthNotifierProvider = ChangeNotifierProvider<AuthNotifier>(
  create: (context) => AuthNotifier(context.read<SignUpUsecase>(),
      context.read<SignInUsecase>(), context.read<SignInGoogleUsecase>()),
);

enum TypeAuth { signIn, signUp }

class AuthNotifier extends ChangeNotifier
    with FormAuthMixin, MessagesStateMixin {
  AuthNotifier(
      this._signUpUsecase, this._signInUsecase, this._signInGoogleUsecase);

  UserEntity? user;
  TypeAuth _typeAuth = TypeAuth.signIn;
  final SignUpUsecase _signUpUsecase;
  final SignInUsecase _signInUsecase;
  final SignInGoogleUsecase _signInGoogleUsecase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  TypeAuth get typeAuth => _typeAuth;

  void setTypeAuth(TypeAuth typeAuth) {
    _typeAuth = typeAuth;
    notifyListeners();
  }

  void _setLoading(bool newIsLoading) {
    _isLoading = newIsLoading;
    notifyListeners();
  }

  Future<void> signIn() async {
    _setLoading(true);
    final res = await _signInUsecase(UserDto(
        username: usernameEC.text,
        email: EmailDto(email: emailEC.text),
        password: PasswordDto(password: passwordEC.text)));

    switch (res) {
      case Success(:final success):
        user = success;
        _setLoading(false);
        break;
      case Failure(:final failure):
        log(failure.messageErro,
            error: failure.label, stackTrace: failure.stackTrace);
        showMessageError(failure.messageErro);
        _setLoading(false);
    }
  }

  Future<void> signUp() async {
    _setLoading(true);
    final res = await _signUpUsecase(UserDto(
        username: usernameEC.text,
        email: EmailDto(email: emailEC.text),
        password: PasswordDto(password: passwordEC.text)));

    switch (res) {
      case Success(:final success):
        user = success;
        _setLoading(false);
        break;
      case Failure(:final failure):
        log(failure.messageErro,
            error: failure.label, stackTrace: failure.stackTrace);
        showMessageError(failure.messageErro);
        _setLoading(false);
    }
  }

  Future<void> signInGoogle() async {
    _setLoading(true);
    final res = await _signInGoogleUsecase();

    switch (res) {
      case Success(:final success):
        user = success;
        _setLoading(false);
        break;
      case Failure(:final failure):
        user = null;
        log(failure.messageErro,
            error: failure.label, stackTrace: failure.stackTrace);
        showMessageError(failure.messageErro);
        _setLoading(false);
    }
  }
}
