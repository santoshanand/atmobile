import 'package:auto_trade/core/models/login_request.dart';
import 'package:auto_trade/core/models/login_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppNotifier extends ChangeNotifier {
  int tabIndex = 0;
  bool loggedIn = false;
  LoginRequest? loginRequest;
  ProfileModel? profile;

  void setTabIndex(int index) {
    tabIndex = index;
    notifyListeners();
  }

  void setLoggedIn(bool value) {
    loggedIn = value;
    notifyListeners();
  }

  void setLoginRequest(LoginRequest? value) {
    loginRequest = value;
    notifyListeners();
  }

  void setProfile(ProfileModel? value) {
    profile = value;
    notifyListeners();
  }
}

final appProvider = ChangeNotifierProvider<AppNotifier>((ref) {
  return AppNotifier();
});
