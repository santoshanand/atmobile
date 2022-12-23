import 'package:auto_trade/core/providers/app_provider.dart';
import 'package:auto_trade/screens/login/login.dart';
import 'package:auto_trade/shared/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginWebView extends ConsumerStatefulWidget {
  const LoginWebView({Key? key}) : super(key: key);

  @override
  _LoginWebViewState createState() => _LoginWebViewState();
}

class _LoginWebViewState extends ConsumerState<LoginWebView> {
  @override
  Widget build(BuildContext context) {
    var _isLoggedIn = ref.watch(appProvider).loggedIn;

    return _isLoggedIn ? const Loader() : const LoginScreenWithLoader();
  }
}
