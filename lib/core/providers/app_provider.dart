import 'package:auto_trade/core/models/login_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppNotifier extends ChangeNotifier {
  bool loggedIn = false;
  ProfileModel? profile;
  void setLoggedIn(bool value) {
    loggedIn = value;
    notifyListeners();
  }

  void setProfile(ProfileModel? value) {
    profile = value;
    notifyListeners();
  }
}

final appProvider = ChangeNotifierProvider.autoDispose<AppNotifier>((ref) {
  return AppNotifier();
});
