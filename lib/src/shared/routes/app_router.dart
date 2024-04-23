import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/screens/splash/splash_page.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/screens/home_page.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/widgets/wrapper/home_provider_wrapper_widget.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();

  static const String initialRoute = "/splash";

  static final Map<String, Widget Function(BuildContext context)> routes = {
    "/splash": (context) => const SplashPage(),
    "/home": (context) {
      final user = ModalRoute.of(context)?.settings.arguments as UserEntity?;
      return HomeProviderWrapperWidget(child: HomePage(user: user));
    }
  };
}
