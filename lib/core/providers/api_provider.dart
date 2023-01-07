import 'package:auto_trade/core/models/home_model.dart';
import 'package:auto_trade/core/models/login_model.dart';
import 'package:auto_trade/core/models/margin_model.dart';
import 'package:auto_trade/core/models/profile_model.dart';
import 'package:auto_trade/core/services/api_service.dart';
import 'package:flutter/material.dart';

class ServiceNotifier with ChangeNotifier {
  bool loginFetching = false;
  bool profileFetching = false;
  bool marginFetching = false;
  bool stoppingTrading = false;
  bool homeDataFetching = false;

  bool loggingOut = false;
  bool loggedIn = true;

  final APIService _api = APIService();

  ProfileModel? profileModel;
  LoginModel? loginModel;
  MarginModel? marginModel;
  HomeModel? homeModel;

  Future<LoginModel?> login() async {
    loginFetching = true;
    loginModel = await _api.login();
    if (loginModel != null) {
      loggedIn = true;
    } else {
      loggedIn = false;
    }
    loginFetching = false;
    notifyListeners();
    return loginModel;
  }

  void profile() async {
    profileFetching = true;
    try {
      profileModel = await _api.profile();
    } catch (e) {
      logout();
    }
    profileFetching = false;
    notifyListeners();
  }

  void homeData() async {
    homeDataFetching = true;
    homeModel = await _api.homeData();
    homeDataFetching = false;
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
    marginFetching = true;
    marginModel = await _api.margins();
    marginFetching = false;
    notifyListeners();
  }

  void _resetProperties() {
    loggedIn = false;
    profileFetching = false;
    loginFetching = false;
    loggingOut = false;
    profileModel = null;
    loginModel = null;
  }
}
