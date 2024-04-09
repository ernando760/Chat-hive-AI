import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/email_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/password_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/dto/user_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';

const userDtoMock = UserDto(
    username: "fulano",
    email: EmailDto(email: "fulano@fulano.com"),
    password: PasswordDto(password: "fulano123"));

const userModelMock =
    UserEntity(username: "fulano", email: EmailDto(email: "fulano@fulano.com"));
