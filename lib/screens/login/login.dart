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
        toolbarOpacity: .5,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              initialUrl: Env.kiteUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onPageFinished: (String url) async {
                LoginRequest? login = await _getLoginRequest();
                if (login != null) {
                  an.setLoginRequest(login);
                  an.setLoggedIn(true);
                  ref.read(apiProvider).login();
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop(login);
                  }
                }
              },
              gestureNavigationEnabled: true,
              backgroundColor: const Color(0x00000000),
            ),
          ],
        ),
      ),
    );
  }
}
