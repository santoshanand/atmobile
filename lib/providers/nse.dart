import 'dart:convert';
import 'dart:io';

import 'package:auto_trade/models/market_status.dart';

class NSEDataProvider {
  final marketStatusUrl = '/api/marketStatus';
  var optionUrl = '/api/option-chain-equities';

  final _baseURL = 'www.nseindia.com';
  var _cookieUsedCount = 0;
  final _cookieMaxAge = 60; // should be in seconds
  var _cookieExpiry = 0;
  var _cookieStr = "";
  final _agent =
      'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36';
  // Await the http get response, then decode the json-formatted response.

  Future<List<Cookie>?> get httpCookies async {
    var _client = HttpClient();
    var _currentTime = DateTime.now().millisecond;
    var _expiryTime = DateTime.now().millisecond + (_cookieMaxAge * 1000);
    _cookieExpiry = _expiryTime;

    if (_cookieStr == "" ||
        _cookieUsedCount > 10 ||
        _cookieExpiry <= _currentTime) {
      var _url = Uri.https(_baseURL, "");
      final request = await _client.getUrl(_url);
      request.headers.set(HttpHeaders.acceptLanguageHeader, 'en-US,en;q=0.9');
      request.headers
          .set(HttpHeaders.acceptEncodingHeader, 'gzip, deflate, br');
      request.headers.set(HttpHeaders.connectionHeader, 'keep-alive');
      request.headers.set(HttpHeaders.userAgentHeader, _agent);
      final response = await request.close();

      _cookieStr = 'has cookies';
      _cookieUsedCount = 0;
      _cookieExpiry = _expiryTime;
      return response.cookies;
    }
    _cookieUsedCount++;
    return null;
  }

  Future<dynamic> _getData(String url, {Map<String, dynamic>? query}) async {
    var _client = HttpClient();
    var _url = Uri.https(_baseURL, url, query);
    final cookies = await httpCookies;
    final request = await _client.getUrl(_url);
    request.headers.set(HttpHeaders.acceptLanguageHeader, 'en-US,en;q=0.9');
    request.headers.set(HttpHeaders.acceptEncodingHeader, 'gzip, deflate, br');
    request.headers.set(HttpHeaders.connectionHeader, 'keep-alive');
    request.headers.set(HttpHeaders.userAgentHeader, _agent);

    // var ss = cookies?.map((e) => '${e.name}=${e.value}');
    if (cookies != null) {
      for (var cookie in cookies) {
        // request.headers.set(HttpHeaders.cookieHeader, cookie.value);
        request.cookies.add(cookie);
      }
    }

    final response = await request.close();
    if (response.statusCode != 200) {
      return null;
    }
    final jsonString = await response.transform(utf8.decoder).join();
    var res = jsonDecode(jsonString);
    return res;
  }

  Future<List<MarketState>> marketStatus() async {
    var res = await _getData(marketStatusUrl);
    res = res?['marketState'];
    final marketList =
        res?.map<MarketState>((json) => MarketState.fromJson(json)).toList();
    return marketList;
  }

  Future<dynamic> optionChain(String? symbol) async {
    if (symbol == null || symbol == "") {
      symbol = 'NIFTY';
    }
    Map<String, String> qParams = {
      'symbol': symbol,
    };

    if (symbol.contains('NIFTY')) {
      optionUrl = optionUrl.replaceAll('equities', 'indices');
    }
    var res = await _getData(optionUrl, query: qParams);
    return res;
  }
}
