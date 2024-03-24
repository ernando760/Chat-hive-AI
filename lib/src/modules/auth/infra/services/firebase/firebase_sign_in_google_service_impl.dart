import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_in_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/services/sign_in_service.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseSignInGoogleServiceImpl implements SignInService {
  @override
  Future<Either<UserModel?, SignInServiceException>> call(
      UserDto userDto) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        final user = UserModel(
            id: userCredential.user!.uid,
            username: userCredential.user!.displayName!,
            avatarUrl: userCredential.user!.photoURL,
            email: userDto.email);

        return Success(user);
      }
      return Success(null);
    } on FirebaseAuthException catch (e) {
      return Failure(SignInServiceException(
          label: "$runtimeType-FirebaseAuthException",
          messageErro: e.message ?? "Error ao fazer o login!",
          stackTrace: e.stackTrace));
    } on FirebaseException catch (e) {
      return Failure(SignInServiceException(
          label: "$runtimeType-FirebaseException",
          messageErro: e.message ?? "Error ao fazer o login!",
          stackTrace: e.stackTrace));
    } catch (e, s) {
      return Failure(SignInServiceException(
          label: "$runtimeType-FirebaseException",
          messageErro: e.toString(),
          stackTrace: s));
    }
  }
}
