import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/usecase/sign_out_usecase.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/provider/barrel/auth_provider_barrel.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.user});
  final UserEntity? user;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = widget.user ??
        ModalRoute.of(context)?.settings.arguments as UserEntity?;
    return MultiProvider(
      providers: [
        $SignOutServiceProvider,
        $SignOutGoogleServiceProvider,
        $SignOutRepositoryProvider,
        $SignOutGoogleRepositoryProvider,
        $SignOutUsecaseProvider,
        $SignOutGoogleUsecaseProvider,
        ChangeNotifierProvider<SignOutNotifier>(
          create: (context) => SignOutNotifier(context.read<SignOutUsecase>(),
              context.read<SignOutGoogleUsecase>()),
        )
      ],
      builder: (context, _) {
        final notifier = context.watch<SignOutNotifier>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home page'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${user?.username}"),
                Text("${user?.email.email}"),
                ElevatedButton(
                    onPressed: () async {
                      final nav = Navigator.of(context);
                      await notifier.signOut();
                      nav.pushReplacementNamed("/splash");
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(color: context.white),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}

class SignOutNotifier extends ChangeNotifier {
  SignOutNotifier(this._signOutUsecase, this._signOutGoogleUsecase);
  final SignOutUsecase _signOutUsecase;
  final SignOutGoogleUsecase _signOutGoogleUsecase;
  Future<void> signOut() async {
    await _signOutUsecase();
    notifyListeners();
  }

  Future<void> signOutGoogle() async {
    await _signOutGoogleUsecase();
    notifyListeners();
  }

  Future<void> signOutFull() async {
    await Future.value([
      await _signOutUsecase(),
      await _signOutGoogleUsecase(),
    ]);

    notifyListeners();
  }
}
