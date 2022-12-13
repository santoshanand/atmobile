import 'package:auto_trade/shared/app_scaffold.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(body: Text("Settings"), title: "Settings");
  }
}
