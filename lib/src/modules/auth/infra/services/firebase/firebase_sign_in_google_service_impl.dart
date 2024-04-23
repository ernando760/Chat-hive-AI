import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/email_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_in_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/provider/barrel/auth_provider_barrel.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final $SignInGoogleServiceProvider = Provider<SignInGoogleService>(
    create: (context) => FirebaseSignInGoogleServiceImpl());

class FirebaseSignInGoogleServiceImpl implements SignInGoogleService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<Either<UserEntity?, SignInServiceException>> call() async {
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
        await _firebaseFirestore
            .collection("emails")
            .doc()
            .set({"email": userCredential.user!.email!});
        final user = UserEntity(
            id: userCredential.user!.uid,
            username: userCredential.user!.displayName!,
            avatarUrl: userCredential.user!.photoURL,
            email: EmailDto(email: userCredential.user!.email!));

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
