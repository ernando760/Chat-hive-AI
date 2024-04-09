import 'package:chat_hive_ai/src/modules/auth/domain/services/sign_out_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

final $SignOutServiceProvider =
    Provider<SignOutService>(create: (context) => FirebaseSignOutServiceImpl());

class FirebaseSignOutServiceImpl implements SignOutService {
  @override
  Future<void> call() async {
    await FirebaseAuth.instance.signOut();
  }
}
