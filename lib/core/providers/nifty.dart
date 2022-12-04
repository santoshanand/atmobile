import 'package:auto_trade/core/providers/nse.dart';
import 'package:flutter/material.dart';

class NiftyProvider with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    NSEDataProvider().httpCookies;
    notifyListeners();
  }
}
