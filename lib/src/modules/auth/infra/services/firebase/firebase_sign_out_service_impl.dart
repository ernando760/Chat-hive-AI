import 'package:chat_hive_ai/src/modules/auth/domain/services/sign_out_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseSignOutServiceImpl implements SignOutService {
  @override
  Future<void> call() async {
    await FirebaseAuth.instance.signOut();
  }
}
