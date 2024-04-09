import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/email_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/password_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/user_dto.dart';

class FormValidator {
  FormValidator._();

  static UserDto _user = const UserDto(
      username: "",
      email: EmailDto(email: ""),
      password: PasswordDto(password: ""));

  static String? validateUsername(String? username) {
    _user = _user.copyWith(username: username);
    if (_user.username.isEmpty) {
      return "O campo usúario está vazio";
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email != null) {
      _user = _user.copyWith(email: EmailDto(email: email));
      return _user.email.isValidEmail();
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password != null) {
      _user = _user.copyWith(password: PasswordDto(password: password));
      return _user.password.isValidPassword();
    }
    return null;
  }
}
