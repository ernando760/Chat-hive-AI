// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class EmailDto extends Equatable {
  final String email;
  const EmailDto({
    required this.email,
  });

  String? isValidEmail() {
    if (email.isEmpty) {
      return "O email está vazio";
    } else if (!email.contains(RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"))) {
      return "O email está invalido";
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
    };
  }

  factory EmailDto.fromMap(Map<String, dynamic> map) {
    return EmailDto(
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmailDto.fromJson(String source) =>
      EmailDto.fromMap(json.decode(source) as Map<String, dynamic>);

  EmailDto copyWith({
    String? email,
  }) {
    return EmailDto(
      email: email ?? this.email,
    );
  }

  @override
  List<Object> get props => [email, isValidEmail];
}
