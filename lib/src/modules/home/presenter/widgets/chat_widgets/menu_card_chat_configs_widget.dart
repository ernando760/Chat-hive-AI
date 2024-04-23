import 'package:flutter/material.dart';

class MenuCardChatConfigsWidget extends StatefulWidget {
  const MenuCardChatConfigsWidget(
      {super.key,
      required this.menuController,
      required this.alignmentOffset,
      required this.child,
      required this.items,
      this.shape});
  final MenuController menuController;
  final Offset alignmentOffset;
  final Widget child;
  final List<Widget> items;
  final MaterialStateProperty<OutlinedBorder?>? shape;
  @override
  State<MenuCardChatConfigsWidget> createState() =>
      _MenuCardChatConfigsWidgetState();
}

class _MenuCardChatConfigsWidgetState extends State<MenuCardChatConfigsWidget> {
  final focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
        style: MenuStyle(
            shape: widget.shape ??
                const MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))))),
        controller: widget.menuController,
        alignmentOffset: widget.alignmentOffset,
        childFocusNode: focus,
        menuChildren: widget.items,
        child: widget.child);
  }
}
