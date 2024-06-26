import 'package:chat_hive_ai/src/modules/auth/presenter/screens/auth_page.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/screens/auth_page_provider_wrapper.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/screens/splash/notifier/splash_notifier.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/screens/splash/provider/splash_provider.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/screens/home_page.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/widgets/wrapper/home_provider_wrapper_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: SplashProvider.providers,
      builder: (context, child) {
        final notifier = context.watch<SplashNotifier>();
        if (notifier.user != null) {
          return HomeProviderWrapperWidget(
            child: HomePage(
              user: notifier.user,
            ),
          );
        }
        return const AuthPageProviderWrapper(child: AuthPage());
      },
    );
  }
}
