import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/email_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/errors/is_user_logged_exception.dart';

import 'package:chat_hive_ai/src/modules/auth/domain/services/is_user_logged_service.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

final $IsUserLoggedServiceProvider = Provider<IsUserLoggedService>(
    create: (context) => FirebaseIsUserLoggedServiceImpl());

class FirebaseIsUserLoggedServiceImpl implements IsUserLoggedService {
  @override
  Future<Either<UserEntity?, IsUserLoggedServicesException>> call() async {
    try {
      final firebaseAuth = FirebaseAuth.instance;

      final isLogged = firebaseAuth.currentUser != null;
      if (isLogged) {
        final user = UserEntity(
            id: firebaseAuth.currentUser!.uid,
            username: firebaseAuth.currentUser!.displayName!,
            email: EmailDto(email: firebaseAuth.currentUser!.email!));
        return Success(user);
      }
      return Success(null);
    } on FirebaseAuthException catch (e) {
      return Failure(IsUserLoggedServicesException(
          label: "$runtimeType-FirebaseAuthException",
          messageErro:
              e.message ?? "Error ao verificar se o usuario está logado",
          stackTrace: e.stackTrace));
    } on FirebaseException catch (e) {
      return Failure(IsUserLoggedServicesException(
          label: "$runtimeType-FirebaseException",
          messageErro:
              e.message ?? "Error ao verificar se o usuario está logado",
          stackTrace: e.stackTrace));
    } catch (e, s) {
      return Failure(IsUserLoggedServicesException(
          label: "$runtimeType", messageErro: e.toString(), stackTrace: s));
    }
  }
}
