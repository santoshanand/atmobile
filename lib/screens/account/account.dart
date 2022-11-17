import 'dart:async';

import 'package:auto_trade/providers/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Completer<WebViewController> _controller =
        Completer<WebViewController>();
    final cookieManager = WebviewCookieManager();
    const _url = 'https://kite.zerodha.com/dashboard';
    return Container(
      color: Colors.amber,
      width: double.infinity,
      height: double.infinity,
      child: Consumer<CommonProvider>(
        builder: (context, cp, child) {
          if (!cp.loggedIn) {
            return WebView(
              initialUrl: _url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onProgress: (int progress) {
                debugPrint('WebView is loading (progress : $progress%)');
              },
              onPageStarted: (String url) {
                debugPrint('Page started loading: $url');
              },
              onPageFinished: (String url) async {
                debugPrint('Page finished loading: $url');
                final gotCookies = await cookieManager.getCookies(_url);
                for (var item in gotCookies) {
                  debugPrint(item.name + " " + item.value);
                  if (item.name == "enctoken") {
                    cp.setIsLoggedIn(true);
                  }
                }
              },
              gestureNavigationEnabled: true,
              backgroundColor: const Color(0x00000000),
            );
          }
          return Text('Is loggedin: ${cp.loggedIn}');
        },
      ),
    );
  }
}
