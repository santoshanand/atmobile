import 'package:auto_trade/core/models/login_response.dart';
import 'package:auto_trade/utils/env.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

import '../models/login_request.dart';
import 'package:dio/dio.dart';

class APIService {
  final String _endpoint = Env.apiUrl;
  final _cookieManager = WebviewCookieManager();

  Future<ProfileModel?> login() async {
    String loginUrl = '$_endpoint/login';
    LoginRequest? loginReq = await _getLoginRequest();

    if (loginReq == null) {
      return null;
    }

    try {
      Response res = await Dio().post(loginUrl, data: {'token': loginReq.token, 'user_id': loginReq.userId});
      if (res.statusCode != 200) {
        _clearCookies();
        return null;
      }
      APIResponse apiRes = APIResponse.fromJson(res.data);
      return apiRes.data;
    } catch (e) {
      return null;
    }
  }

  Future<ProfileModel?> profile() async {
    String loginUrl = '$_endpoint/profile';
    LoginRequest? loginReq = await _getLoginRequest();

    if (loginReq == null) {
      return null;
    }

    try {
      Response res = await Dio().post(loginUrl, data: {'token': loginReq.token, 'user_id': loginReq.userId});
      if (res.statusCode != 200) {
        _clearCookies();
        return null;
      }
      APIResponse apiRes = APIResponse.fromJson(res.data);
      return apiRes.data;
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    await _clearCookies();
  }

  Future<void> _clearCookies() async {
    await _cookieManager.clearCookies();
  }

  Future<LoginRequest?> _getLoginRequest() async {
    final gotCookies = await _cookieManager.getCookies(Env.kiteUrl);
    LoginRequest loginReq = LoginRequest(token: "", userId: "");
    for (var item in gotCookies) {
      if (item.name == "enctoken") {
        loginReq.token = item.value;
      }
      if (item.name == "user_id") {
        loginReq.userId = item.value;
      }
    }
    if (loginReq.token == "" || loginReq.userId == "") {
      return null;
    }
    return loginReq;
  }
}
