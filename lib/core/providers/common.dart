import 'package:auto_trade/core/models/login_request.dart';
import 'package:auto_trade/core/models/login_response.dart';
import 'package:auto_trade/core/services/auto_trade.dart';
import 'package:auto_trade/utils/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

class CommonNotifier with ChangeNotifier {
  Profile? _profile;
  WebviewCookieManager? _cookies;

  Future<bool> isLoggedIn() async {
    final cookies = await _cookies?.getCookies(Env.kiteUrl);
    if (cookies == null) {
      return false;
    }
    for (var item in cookies) {
      if (item.name == "enctoken") {
        return true;
      }
    }
    return false;
  }

  Profile? getProfile() {
    return _profile;
  }

  Future<LoginResponse?> login(
      LoginRequest login, WebviewCookieManager value) async {
    _cookies = value;
    notifyListeners();

    var res = await AutoTradeService().login(login);
    _profile = res?.data;
    notifyListeners();

    return res;
  }

  void logOut() {
    _cookies?.clearCookies();
    notifyListeners();
  }
}

final commonProvider = ChangeNotifierProvider<CommonNotifier>((ref) {
  return CommonNotifier();
});
