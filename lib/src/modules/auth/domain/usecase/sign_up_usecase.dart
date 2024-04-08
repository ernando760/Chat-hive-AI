import 'package:chat_hive_ai/src/modules/auth/domain/errors/sign_up_exception.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/email_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/password_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/repositories/sign_up_repository.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:provider/provider.dart';

final $SignUpUsecaseProvider = Provider(
    create: (context) => SignUpUsecase(context.read<SignUpRepository>()));

class SignUpUsecase {
  final SignUpRepository _repository;

  SignUpUsecase(this._repository);

  Future<Either<UserEntity?, SignUpException>> call(UserDto userDto) async {
    if (!_isValidEmail(userDto.email)) {
      return Failure<UserEntity, SignUpUsecaseException>(SignUpUsecaseException(
          label: "$runtimeType", messageErro: userDto.email.email));
    } else if (!_isValidPassword(userDto.password)) {
      return Failure<UserEntity, SignUpUsecaseException>(SignUpUsecaseException(
          label: "$runtimeType", messageErro: userDto.password.password));
    }
    return await _repository.call(userDto);
  }

  bool _isValidEmail(EmailDto email) => email.isValidEmail() == null;
  bool _isValidPassword(PasswordDto password) =>
      password.isValidPassword() == null;
}
