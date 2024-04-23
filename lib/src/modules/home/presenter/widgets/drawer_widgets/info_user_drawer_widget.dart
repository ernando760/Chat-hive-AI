import 'package:chat_hive_ai/src/modules/auth/domain/entities/user_model.dart';
import 'package:chat_hive_ai/src/modules/auth/presenter/provider/barrel/auth_provider_barrel.dart';
import 'package:chat_hive_ai/src/modules/home/presenter/notifiers/chat_notifier.dart';
import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';

class InfoUserDrawerWidget extends StatelessWidget {
  const InfoUserDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user =
        context.select<ChatNotifier, UserEntity?>((value) => value.user);
    if (user != null) {
      return Row(
        children: [
          CircleAvatar(
            backgroundColor: user.avatarUrl == null ? Colors.amber : null,
            backgroundImage:
                user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
            child: user.avatarUrl == null
                ? Text("${user.username[0]}${user.username[1]}".toUpperCase())
                : null,
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.username, style: context.caption12Medium),
              Text(
                user.email.email,
                style: context.caption8Regular..color?.withOpacity(.4),
              ),
            ],
          ),
        ],
      );
    }
    return Container();
  }
}
