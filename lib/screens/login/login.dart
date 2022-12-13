import 'dart:async';

import 'package:auto_trade/core/models/login_request.dart';
import 'package:auto_trade/core/providers/api_provider.dart';
import 'package:auto_trade/core/providers/app_provider.dart';
import 'package:auto_trade/utils/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreenTemp extends ConsumerWidget {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  final cookieManager = WebviewCookieManager();

  LoginScreenTemp({Key? key}) : super(key: key);

  Future<LoginRequest?> _getLoginRequest() async {
    final gotCookies = await cookieManager.getCookies(Env.kiteUrl);
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppNotifier an = ref.watch(appProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: Env.kiteUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onPageFinished: (String url) async {
            try {
              LoginRequest? login = await _getLoginRequest();
              if (login != null && login.token != "") {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop(login);
                }
                an.setLoginRequest(login);
                await ref.read(apiProvider).login();
                an.setLoggedIn(true);
              }
            } catch (e) {
              debugPrint(e.toString());
            }
          },
          gestureNavigationEnabled: true,
          backgroundColor: const Color(0x00000000),
        ),
      ),
    );
  }
}
