// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class PasswordDto extends Equatable {
  final String password;

  const PasswordDto({required this.password});

  String? isValidPassword() {
    if (password.isEmpty) {
      return "A senha está vazia.";
    }
    return null;
  }

  PasswordDto copyWith({
    String? password,
  }) {
    return PasswordDto(
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
    };
  }

  factory PasswordDto.fromMap(Map<String, dynamic> map) {
    return PasswordDto(
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PasswordDto.fromJson(String source) =>
      PasswordDto.fromMap(json.decode(source) as Map<String, dynamic>);
  @override
  List<Object> get props => [password, isValidPassword];
}
