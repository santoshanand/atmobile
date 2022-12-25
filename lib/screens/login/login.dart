import 'dart:async';

import 'package:auto_trade/core/models/login_request.dart';
import 'package:auto_trade/core/providers/api_provider.dart';
import 'package:auto_trade/core/providers/app_provider.dart';
import 'package:auto_trade/shared/loader.dart';
import 'package:auto_trade/utils/env.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreenWithLoader extends ConsumerStatefulWidget {
  const LoginScreenWithLoader({Key? key}) : super(key: key);

  @override
  _LoginScreenWithLoaderState createState() => _LoginScreenWithLoaderState();
}

class _LoginScreenWithLoaderState extends ConsumerState<LoginScreenWithLoader> {
  final cookieManager = WebviewCookieManager();
  bool pageLoadDone = false;
  bool loading = false;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppNotifier an = ref.watch(appProvider);
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
          connected: pageLoadDone && an.loggedIn
              ? const Loader()
              : WebView(
                  initialUrl: Env.kiteUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                  onPageStarted: (url) {},
                  onPageFinished: (String url) async {
                    setState(() {
                      pageLoadDone = true;
                    });
                    var loginReq = await _getLoginRequest();
                    if (loginReq != null && !an.loggedIn) {
                      var res = await ref.read(apiProvider).login();
                      if (res == null) {
                        await ref.read(apiProvider).logout();
                        an.setLoggedIn(false);
                      } else {
                        an.setLoggedIn(true);
                      }
                    }
                  },
                  zoomEnabled: false,
                  gestureNavigationEnabled: true,
                ),
          disconnected: const _NoInternet(),
        ),
      ),
    );
  }
}

class _NoInternet extends StatelessWidget {
  const _NoInternet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            "Coudn't connect to internet.",
          ),
          const Text("Please check your network settings."),
          const SizedBox(
            height: 12,
          ),
          OutlinedButton(
            onPressed: () {},
            child: const Text("Refresh"),
          )
        ],
      ),
    );
  }
}
