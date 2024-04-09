import 'package:chat_hive_ai_core/chat_hive_ai_core.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget(
      {super.key,
      this.width,
      this.height,
      this.fit = BoxFit.contain,
      this.colorFilter});
  final double? width;
  final double? height;

  final BoxFit fit;
  final ColorFilter? colorFilter;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: SvgPicture.asset(
        context.isDark
            ? "assets/images/logos/logo_chat_hive_ai_white.svg"
            : "assets/images/logos/logo_chat_hive_ai_black.svg",
        fit: fit,
        colorFilter: colorFilter,
      ),
    );
  }
}
