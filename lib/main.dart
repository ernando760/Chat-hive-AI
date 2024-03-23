import 'dart:async';
import 'package:chat_hive_ai/src/shared/routes/app_router.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChatHiveAiAppMain(
      initialRoute: AppRouter.initialRoute,
      routes: AppRouter.routes,
    );
  }
}
