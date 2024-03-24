// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:chat_hive_ai/src/modules/auth/domain/model/dto/email_dto.dart';

class UserModel extends Equatable {
  final String? id;
  final String? avatarUrl;
  final String username;
  final EmailDto email;

  const UserModel(
      {this.id, this.avatarUrl, required this.username, required this.email});

  @override
  List<Object?> get props => [id, avatarUrl, username, email];

  @override
  String toString() =>
      "UserModel(id:$id,username:$username,avatarUrl:$avatarUrl,email:${email.email})";
}
