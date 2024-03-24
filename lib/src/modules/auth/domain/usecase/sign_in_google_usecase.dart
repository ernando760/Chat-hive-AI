import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_in_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/email_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/password_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/sign_in_google_repository.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

class SignInGoogleUsecase {
  final SignInGoogleRepository repository;

  SignInGoogleUsecase(this.repository);

  Future<Either<UserModel, SignInException>> call(UserDto userDto) async {
    if (!_isValidEmail(userDto.email)) {
      return Failure<UserModel, SignInGoogleUsecaseException>(
          SignInGoogleUsecaseException(
              label: "$runtimeType",
              messageErro: userDto.email.isValidEmail() ??
                  "Error ao fazer o login no google"));
    } else if (!_isValidPassword(userDto.password)) {
      return Failure<UserModel, SignInGoogleUsecaseException>(
          SignInGoogleUsecaseException(
              label: "$runtimeType",
              messageErro: userDto.password.isValidPassword() ??
                  "Error ao fazer o login no google"));
    }

    return await repository.call(userDto);
  }

  bool _isValidEmail(EmailDto email) => email.isValidEmail() == null;
  bool _isValidPassword(PasswordDto password) =>
      password.isValidPassword() == null;
}
