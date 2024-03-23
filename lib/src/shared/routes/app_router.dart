import 'package:chat_hive_ai/src/screens/home_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();

  static const String initialRoute = "/";

  static final Map<String, Widget Function(BuildContext context)> routes = {
    AppRouter.initialRoute: (context) => const HomePage(),
  };
}
