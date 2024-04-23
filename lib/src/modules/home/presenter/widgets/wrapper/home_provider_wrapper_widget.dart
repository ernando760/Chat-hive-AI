import 'package:chat_hive_ai/src/modules/home/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeProviderWrapperWidget extends StatelessWidget {
  const HomeProviderWrapperWidget({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: HomeProvider.providers, child: child);
  }
}
