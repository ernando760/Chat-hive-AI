import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_in_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/services/sign_in_service.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

final $SignInServiceProvider =
    Provider<SignInService>(create: (context) => FirebaseSignInServiceImpl());

class FirebaseSignInServiceImpl implements SignInService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<Either<UserEntity?, SignInServiceException>> call(
      UserDto userDto) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final isExist = await _isEmailExist(userDto.email.email);
      if (!isExist) {
        return Failure(SignInServiceException(
            label: "$runtimeType",
            messageErro: "O email ou senha está invalida"));
      }
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: userDto.email.email, password: userDto.password.password);
      if (credential.user != null) {
        final user = UserEntity(
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

  Future<bool> _isEmailExist(String email) async {
    final coll = _firebaseFirestore.collection("emails");
    final query = await coll.get();
    final docs = query.docs;

    final emailsMap = docs.map((e) => e.data()).toList();

    if (emailsMap.isEmpty) {
      return false;
    }

    return emailsMap.any((element) => element["email"] == email);
  }
}
