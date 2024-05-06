import 'package:chat_hive_ai/src/modules/auth/presenter/provider/auth_provider.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/provider/barrel/auth_provider_barrel.dart';
import 'package:flutter/material.dart';

class AuthPageProviderWrapper extends StatelessWidget {
  const AuthPageProviderWrapper({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: AuthProvider.providers, child: child);
  }
}
