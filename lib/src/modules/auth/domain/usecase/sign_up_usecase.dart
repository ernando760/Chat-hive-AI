import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_up_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/email_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/password_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/sign_up_repository.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';

class SignUpUsecase {
  final SignUpRepository repository;

  SignUpUsecase(this.repository);

  Future<Either<UserModel, SignUpException>> call(UserDto userDto) async {
    if (!_isValidEmail(userDto.email)) {
      return Failure<UserModel, SignUpUsecaseException>(SignUpUsecaseException(
          label: "$runtimeType", messageErro: userDto.email.email));
    } else if (!_isValidPassword(userDto.password)) {
      return Failure<UserModel, SignUpUsecaseException>(SignUpUsecaseException(
          label: "$runtimeType", messageErro: userDto.password.password));
    }
    return await repository.call(userDto);
  }

  bool _isValidEmail(EmailDto email) => email.isValidEmail() == null;
  bool _isValidPassword(PasswordDto password) =>
      password.isValidPassword() == null;
}
