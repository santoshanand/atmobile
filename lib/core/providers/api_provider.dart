import 'package:auto_trade/core/models/login_model.dart';
import 'package:auto_trade/core/models/margin_model.dart';
import 'package:auto_trade/core/models/profile_model.dart';
import 'package:auto_trade/core/services/api_service.dart';
import 'package:flutter/material.dart';

class ServiceNotifier with ChangeNotifier {
  bool loginFeching = false;
  bool profileFeching = false;
  bool marginFeching = false;
  bool stoppingTrading = false;

  bool loggingOut = false;
  bool loggedIn = false;

  final APIService _api = APIService();

  ProfileModel? profileModel;
  LoginModel? loginModel;
  MarginModel? marginModel;

  ServiceNotifier(LoginModel? loginModel) {
    loginModel = loginModel;
    if (loginModel != null) {
      loggedIn = true;
    }
  }
  void login() async {
    loginFeching = true;
    loginModel = await _api.login();
    if (loginModel != null) {
      loggedIn = true;
    }
    loginFeching = false;
    notifyListeners();
  }

  void profile() async {
    profileFeching = true;
    profileModel = await _api.profile();
    if (profileModel == null) {
      logout();
    }
    profileFeching = false;
    notifyListeners();
  }

  void logout() async {
    loggingOut = true;
    await _api.logout();
    _resetProperties();
    loggingOut = false;
    notifyListeners();
  }

  void stopTrading(bool value) async {
    stoppingTrading = true;
    await _api.stopTrading(value);
    stoppingTrading = false;
    notifyListeners();
  }

  void margin() async {
    marginFeching = true;
    marginModel = await _api.margins();
    marginFeching = false;
    notifyListeners();
  }

  void _resetProperties() {
    loggedIn = false;
    profileFeching = false;
    loginFeching = false;
    loggingOut = false;
    profileModel = null;
    loginModel = null;
  }
}
