import 'package:flutter/material.dart';

enum TypeLoading {
  loadingFull,
  loadingSendMessage,
}

mixin LoadingNotifierMixin on ChangeNotifier {
  bool _isAppLoading = false;
  bool _isLoadingSendMessage = false;

  bool get isApploading => _isAppLoading;
  bool get isLoadingSendMessage => _isLoadingSendMessage;

  void setAppLoading(bool isLoading) {
    _isAppLoading = isLoading;
    notifyListeners();
  }

  void setLoadingSendMessage(bool newIsLoadingSendMessage) {
    _isLoadingSendMessage = newIsLoadingSendMessage;
    notifyListeners();
  }
}
