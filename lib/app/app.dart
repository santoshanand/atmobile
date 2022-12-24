import 'package:auto_trade/core/models/login_response.dart';
import 'package:auto_trade/core/providers/app_provider.dart';
import 'package:auto_trade/core/theme/app_theme.dart';
import 'package:auto_trade/screens/landing/landing.dart';
import 'package:auto_trade/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutoTrade extends ConsumerStatefulWidget {
  final ProfileModel? res;
  const AutoTrade({Key? key, this.res}) : super(key: key);
  @override
  _AutoTradeState createState() => _AutoTradeState();
}

class _AutoTradeState extends ConsumerState<AutoTrade> {
  bool loggedIn = false;
  @override
  void initState() {
    super.initState();
    if (widget.res != null) {
      setState(() {
        loggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    loggedIn = ref.watch(appProvider).loggedIn;
    return MaterialApp(
      title: 'Auto Trade',
      theme: applicationTheme,
      debugShowCheckedModeBanner: false,
      home: loggedIn ? LandingScreen(widget.res) : const LoginScreenWithLoader(),
    );
  }
}
