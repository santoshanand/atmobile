import 'package:flutter/material.dart';

class CommonProvider with ChangeNotifier {
  int _bottomBarSelectedIndex = 0;
  int get bottomBarSelectedIndex => _bottomBarSelectedIndex;
  void setBottomSelectedIndex(int index) {
    _bottomBarSelectedIndex = index;
    notifyListeners();
  }
}
