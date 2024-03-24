import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_in_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/services/sign_in_service.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseSignInServiceImpl implements SignInService {
  @override
  Future<Either<UserModel?, SignInServiceException>> call(
      UserDto userDto) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;

      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: userDto.email.email, password: userDto.password.password);
      if (credential.user != null) {
        final user = UserModel(
            id: credential.user!.uid,
            username: credential.user!.displayName!,
            avatarUrl: credential.user!.photoURL,
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
