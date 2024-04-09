import 'dart:developer';

import 'package:flutter/material.dart';

class TextFormStateNotifier extends MaterialStatesController {
  TextFormStateNotifier() : super({});
  double textFormHeight = 45;
  void onListenErrorState(Set<MaterialState> states) {
    if (states.contains(MaterialState.error)) {
      if (textFormHeight == 45) {
        textFormHeight += 20;
        log("$textFormHeight", name: "height");
        notifyListeners();
      }
    }
  }
}
