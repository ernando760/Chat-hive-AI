import 'package:flutter/material.dart';

class VisibilityPasswordNotifier extends ValueNotifier<bool> {
  VisibilityPasswordNotifier() : super(false);

  void toggleVisibility() {
    value = !value;
  }
}
