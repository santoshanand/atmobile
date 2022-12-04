import 'package:auto_trade/core/models/login_response.dart';
import 'package:auto_trade/utils/env.dart';

import '../models/login_request.dart';
import 'package:dio/dio.dart';

class AutoTradeService {
  String endpoint = Env.apiUrl;

  Future<LoginResponse?> login(LoginRequest login) async {
    String loginUrl = '$endpoint/login';
    var data = {'token': login.token, 'user_id': login.userId};
    try {
      Response res = await Dio().post(loginUrl, data: data);
      if (res.statusCode != 200) {
        return null;
      }
      LoginResponse loginRes = LoginResponse.fromJson(res.data);
      return loginRes;
    } catch (e) {
      return null;
    }
  }
}
