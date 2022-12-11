import 'dart:async';

import 'package:auto_trade/core/models/login_request.dart';
import 'package:auto_trade/core/providers/common.dart';
import 'package:auto_trade/utils/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebLogin extends ConsumerWidget {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  final cookieManager = WebviewCookieManager();

  WebLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cp = ref.watch(commonProvider);
    // var lp = ref.read(loginProvider.notifier);
    // if (cp.isEmpty) {
    //   cookieManager.clearCookies();
    // }

    return WebView(
      initialUrl: Env.kiteUrl,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      // onProgress: (int progress) {
      //   debugPrint('WebView is loading (progress : $progress%)');
      // },
      // onPageStarted: (String url) {
      //   debugPrint('Page started loading: $url');
      // },
      onPageFinished: (String url) async {
        // debugPrint('Page finished loading: $url');
        final gotCookies = await cookieManager.getCookies(Env.kiteUrl);
        LoginRequest login = LoginRequest(token: "", userId: "");

        for (var item in gotCookies) {
          // debugPrint(item.name + " " + item.value);
          if (item.name == "enctoken") {
            login.token = item.value;
          }

          if (item.name == "user_id") {
            login.userId = item.value;
          }
        }

        if (login.token != "" && login.userId != "") {
          var res = await cp.login(login, cookieManager);
          if (res == null) {
            cp.logOut();
          }
        }
      },
      gestureNavigationEnabled: true,
      backgroundColor: const Color(0x00000000),
    );
  }
}
