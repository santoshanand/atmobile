import 'package:auto_trade/core/providers/api_provider.dart';
import 'package:auto_trade/core/theme/app_theme.dart';
import 'package:auto_trade/screens/landing/landing.dart';
import 'package:auto_trade/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AutoTrade extends StatelessWidget {
  const AutoTrade({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   systemNavigationBarColor: Colors.black,
    //   systemNavigationBarIconBrightness: Brightness.dark,
    //   statusBarColor: Color(0xffeeeeee), // status bar color
    // ));
    return MaterialApp(
      title: 'Options Buy',
      theme: applicationTheme,
      debugShowCheckedModeBanner: false,
      home: Consumer<ServiceNotifier>(
        builder: (context, dt, child) {
          return dt.loggedIn ? const LandingScreen() : const LoginScreenWithLoader();
        },
      ),
    );
  }
}
