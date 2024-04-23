import 'package:chat_hive_ai/src/modules/auth/domain/services/sign_out_google_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

final $SignOutGoogleServiceProvider = Provider<SignOutGoogleService>(
    create: (context) => FirebaseSignOutGoogleServiceImpl());

class FirebaseSignOutGoogleServiceImpl implements SignOutGoogleService {
  @override
  Future<void> call() async {
    final googleSignInUser = GoogleSignIn();
    if (googleSignInUser.clientId != null) {
      await googleSignInUser.disconnect();
    }
  }
}
