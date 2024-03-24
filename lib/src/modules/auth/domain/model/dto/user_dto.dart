// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/email_dto.dart';
import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/password_dto.dart';

class UserDto extends Equatable {
  final String username;
  final String? avatarUrl;
  final EmailDto email;
  final PasswordDto password;

  const UserDto(
      {required this.username,
      this.avatarUrl,
      required this.email,
      required this.password});

  UserDto copyWith({
    String? username,
    String? avatarUrl,
    EmailDto? email,
    PasswordDto? password,
  }) {
    return UserDto(
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'avatarUrl': avatarUrl,
      'email': email.toMap(),
      'password': password.toMap(),
    };
  }

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      username: map['username'] as String,
      avatarUrl: map['avatarUrl'] != null ? map['avatarUrl'] as String : null,
      email: EmailDto.fromMap(map['email'] as Map<String, dynamic>),
      password: PasswordDto.fromMap(map['password'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDto.fromJson(String source) =>
      UserDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [username, avatarUrl, email, password];
  @override
  String toString() =>
      "UserModel(username:$username,avatarUrl:$avatarUrl,email:${email.email},password:${password.password})";
}
