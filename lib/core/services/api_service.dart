import 'package:auto_trade/core/models/home_model.dart';
import 'package:auto_trade/core/models/login_model.dart';
import 'package:auto_trade/core/models/margin_model.dart';
import 'package:auto_trade/core/models/profile_model.dart';
import 'package:auto_trade/core/models/stock_model.dart';
import 'package:auto_trade/core/models/trade_model.dart';
import 'package:auto_trade/utils/env.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

import '../models/login_request.dart';
import 'package:dio/dio.dart';

class APIService {
  final String _endpoint = Env.apiUrl;
  final String _kiteUrl = Env.kiteUrl;
  final _cookieManager = WebviewCookieManager();

  final String _loginUrl = "/login";
  final String _profileUrl = "/profile";
  final String _stocksUrl = '/stocks';
  final String _tradesUrl = '/trades';
  final String _stopUrl = '/stop';
  final String _marginUrl = '/margins';
  final String _fullUrl = '/full';

  Dio get _dio {
    return Dio(
      BaseOptions(
        connectTimeout: 30 * 1000,
        receiveTimeout: 15 * 1000,
        baseUrl: _endpoint,
      ),
    );
  }

  Future<MarginModel?> margins() async {
    LoginRequest? loginReq = await _getLoginRequest();
    if (loginReq == null) {
      return null;
    }
    try {
      Response res = await _dio.post(_marginUrl, data: {'token': loginReq.token, 'user_id': loginReq.userId});
      if (res.statusCode != 200) {
        logout();
        return null;
      }
      MarginResponse apiRes = MarginResponse.fromJson(res.data);
      return apiRes.data;
    } catch (e) {
      return null;
    }
  }

  Future<LoginModel?> login() async {
    LoginRequest? loginReq = await _getLoginRequest();
    if (loginReq == null) {
      return null;
    }
    try {
      Response res = await _dio.post(_loginUrl, data: {'token': loginReq.token, 'user_id': loginReq.userId});
      if (res.statusCode != 200) {
        logout();
        return null;
      }
      LoginResponse apiRes = LoginResponse.fromJson(res.data);
      return apiRes.data;
    } catch (e) {
      return null;
    }
  }


  Future<ProfileModel> profile() async {
    LoginRequest? loginReq = await _getLoginRequest();
    if (loginReq == null) {
      return Future.error('profile request is null');
    }
    try {
      Response res = await _dio.post(_profileUrl, data: {'token': loginReq.token, 'user_id': loginReq.userId});
      if (res.statusCode != 200) {
        logout();
        return Future.error(res.data);
      }
      ProfileResponse apiRes = ProfileResponse.fromJson(res.data);
      return apiRes.data;
    } catch (e) {
      return Future.error('exception: $e');
    }
  }

  Future<List<StockModel>> getStocks() async {
    try {
      Response res = await _dio.get(_stocksUrl);
      if (res.statusCode != 200) {
        return Future.error(res.data);
      }
      final parsed = res.data.cast<Map<String, dynamic>>();
      return parsed.map<StockModel>((json) => StockModel.fromJson(json)).toList();
    } catch (e) {
      return Future.error('exception: $e');
    }
  }

  Future<List<TradeModel>> getTrades() async {
    try {
      Map<String, dynamic> queryParameters = <String, dynamic>{};
      DateTime today = DateTime.now();
      String dateStr = "${today.year}-${today.month}-${today.day}";
      queryParameters['date'] = dateStr;
      Response res = await _dio.get(_tradesUrl, queryParameters: queryParameters);
      if (res.statusCode != 200) {
        return Future.error(res.data);
      }
      final parsed = res.data.cast<Map<String, dynamic>>();
      return parsed.map<TradeModel>((json) => TradeModel.fromJson(json)).toList();
    } catch (e) {
      return Future.error('exception: $e');
    }
  }


  Future<HomeModel?> homeData() async {
    LoginRequest? loginReq = await _getLoginRequest();
    if (loginReq == null) {
      return null;
    }
    try {
      Response res = await _dio.post(_fullUrl, data: {'token': loginReq.token, 'user_id': loginReq.userId});
      if (res.statusCode != 200) {
        logout();
        return null;
      }
      HomeModel apiRes = HomeModel.fromJson(res.data);
      return apiRes;
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    // await stopTrading(true);
    await _cookieManager.clearCookies();
  }

  Future<void> stopTrading(bool value) async {
    LoginRequest? loginReq = await _getLoginRequest();
    if (loginReq == null) {
      return Future.error('stop trading request is null');
    }
    try {
      Response res = await _dio.post(_stopUrl, data: {'token': loginReq.token, 'user_id': loginReq.userId, 'stop': value});
      if (res.statusCode != 200) {
        return Future.error(res.data);
      }
    } catch (e) {
      return Future.error('exception: $e');
    }
  }

  Future<LoginRequest?> _getLoginRequest() async {
    final gotCookies = await _cookieManager.getCookies(_kiteUrl);
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
