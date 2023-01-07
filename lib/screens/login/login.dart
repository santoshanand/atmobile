import 'dart:async';

import 'package:auto_trade/core/models/login_request.dart';
import 'package:auto_trade/core/providers/api_provider.dart';
import 'package:auto_trade/screens/offline/offline.dart';
import 'package:auto_trade/shared/loader.dart';
import 'package:auto_trade/utils/env.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreenWithLoader extends StatefulWidget {
  const LoginScreenWithLoader({Key? key}) : super(key: key);

  @override
  State<LoginScreenWithLoader> createState() => _LoginScreenWithLoaderState();
}

class _LoginScreenWithLoaderState extends State<LoginScreenWithLoader> {
  final cookieManager = WebviewCookieManager();

  bool pageLoadingDone = false;

  @override
  Widget build(BuildContext context) {
    // AppNotifier an = ref.watch(appProvider);
    final Completer<WebViewController> _controller = Completer<WebViewController>();

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

    return Scaffold(
      body: SafeArea(
        child: ConnectionNotifierToggler(
          onConnectionStatusChanged: (connected) {
            if (connected == null) return;
          },
          loading: const Loader(),
          disconnected: const OfflineScreen(),
          connected: WebView(
            initialUrl: Env.kiteUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onPageStarted: (url) {},
            onPageFinished: (String url) async {
              var loginReq = await _getLoginRequest();
              if (loginReq != null) {
                try {
                  context.read<ServiceNotifier>().login();
                } catch (e) {debugPrint("ex: "+ e.toString());}
              }
            },
            zoomEnabled: false,
            gestureNavigationEnabled: true,
          ),
        ),
      ),
    );
  }
}
