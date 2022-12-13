import 'package:auto_trade/shared/app_scaffold.dart';
import 'package:flutter/material.dart';

class FundScreen extends StatelessWidget {
  const FundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(body: Text("Fund"), title: "Funds");
  }
}
