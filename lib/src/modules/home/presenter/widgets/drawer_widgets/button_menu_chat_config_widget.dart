import 'package:flutter/material.dart';

class ButtonMenuChatConfigWidget extends StatefulWidget {
  const ButtonMenuChatConfigWidget({super.key});

  @override
  State<ButtonMenuChatConfigWidget> createState() =>
      _ButtonMenuChatConfigWidgetState();
}

class _ButtonMenuChatConfigWidgetState
    extends State<ButtonMenuChatConfigWidget> {
  final menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {}, icon: const Icon(Icons.more_vert_outlined));
  }
}
