import 'package:chat_hive_ai/src/modules/auth/presenter/screens/splash/splash_page.dart';
import 'package:chat_hive_ai/src/screens/home_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();

  static const String initialRoute = "/splash";

  static final Map<String, Widget Function(BuildContext context)> routes = {
    AppRouter.initialRoute: (context) => const SplashPage(),
    "/home": (context) => const HomePage()
  };
}
