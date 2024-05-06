import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_up_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/services/sign_up_service.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

final $SignUpServiceProvider =
    Provider<SignUpService>(create: (context) => FirebaseSignUpServiceImpl());

class FirebaseSignUpServiceImpl implements SignUpService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<Either<UserEntity?, SignUpServiceException>> call(
      UserDto userDto) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final isExist = await _isEmailExist(userDto.email.email);
      if (isExist) {
        return Failure(SignUpServiceException(
            label: "$runtimeType",
            messageErro: "O email ou senha está invalida"));
      }
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
          email: userDto.email.email, password: userDto.password.password);

      if (credential.user != null) {
        await _firebaseFirestore
            .collection("emails")
            .doc()
            .set({"email": userDto.email.email});
        await credential.user!.updateDisplayName(userDto.username);
        await credential.user!.updatePhotoURL(userDto.avatarUrl);
        final user = UserEntity(
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
