import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppNotifier extends ChangeNotifier {
  int tabIndex = 0;
  void setTabIndex(int index) {
    tabIndex = index;
    notifyListeners();
  }
}

final appProvider = ChangeNotifierProvider<AppNotifier>((ref) {
  return AppNotifier();
});
