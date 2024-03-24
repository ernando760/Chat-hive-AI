import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/email_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/password_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/user_model.dart';

const userDtoMock = UserDto(
    username: "fulano",
    email: EmailDto(email: "fulano@fulano.com"),
    password: PasswordDto(password: "fulano123"));

const userModelMock =
    UserModel(username: "fulano", email: EmailDto(email: "fulano@fulano.com"));
