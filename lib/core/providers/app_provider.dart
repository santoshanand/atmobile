import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppNotifier extends ChangeNotifier {
  bool loggedIn = false;

  void setLoggedIn(bool value) {
    loggedIn = value;
    notifyListeners();
  }
}

final appProvider = ChangeNotifierProvider.autoDispose<AppNotifier>((ref) {
  return AppNotifier();
});
