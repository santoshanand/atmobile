import 'package:auto_trade/screens/landing/landing.dart';
import 'package:auto_trade/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AutoTrade extends StatelessWidget {
  const AutoTrade({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: applicationTheme,
      debugShowCheckedModeBanner: false,
      home: const Landing(title: 'Auto Trade'),
    );
  }
}
