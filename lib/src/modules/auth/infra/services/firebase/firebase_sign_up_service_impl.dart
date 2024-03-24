import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_up_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/services/sign_up_service.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseSignUpServiceImpl implements SignUpService {
  @override
  Future<Either<UserModel?, SignUpServiceException>> call(
      UserDto userDto) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;

      final credential = await firebaseAuth.createUserWithEmailAndPassword(
          email: userDto.email.email, password: userDto.password.password);

      if (credential.user != null) {
        await credential.user!.updateDisplayName(userDto.username);
        await credential.user!.updatePhotoURL(userDto.avatarUrl);
        final user = UserModel(
            id: credential.user!.uid,
            username: userDto.username,
            avatarUrl: userDto.avatarUrl,
            email: userDto.email);

        return Success(user);
      }
      return Success(null);
    } on FirebaseAuthException catch (e) {
      return Failure(SignUpServiceException(
          label: "$runtimeType-FirebaseAuthException",
          messageErro: e.message ?? "Error ao fazer o cadastro",
          stackTrace: e.stackTrace));
    } on FirebaseException catch (e) {
      return Failure(SignUpServiceException(
          label: "$runtimeType-FirebaseException",
          messageErro: e.message ?? "Error ao fazer o cadastro"));
    } catch (e, s) {
      return Failure(SignUpServiceException(
          label: "$runtimeType", messageErro: e.toString(), stackTrace: s));
    }
  }
}
