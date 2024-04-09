import 'package:flutter/material.dart';

mixin FormAuthMixin {
  final TextEditingController usernameEC = TextEditingController();
  final TextEditingController emailEC = TextEditingController();
  final TextEditingController passwordEC = TextEditingController();

  void clean() {
    usernameEC.clear();
    emailEC.clear();
    passwordEC.clear();
  }
}
