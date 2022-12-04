import 'package:auto_trade/screens/landing/landing.dart';
import 'package:auto_trade/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AutoTrade extends StatelessWidget {
  const AutoTrade({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Trade',
      theme: applicationTheme,
      debugShowCheckedModeBanner: false,
      home: const Landing(title: 'Auto Trade'),
    );
  }
}
