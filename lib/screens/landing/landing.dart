import 'package:auto_trade/providers/common.dart';
import 'package:auto_trade/screens/account/account.dart';
import 'package:auto_trade/screens/home/home.dart';
import 'package:auto_trade/screens/landing/bottom_bar.dart';
import 'package:auto_trade/screens/scanner/scanner.dart';
import 'package:auto_trade/screens/stock/stock.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Landing extends StatelessWidget {
  final String title;
  const Landing({Key? key, required this.title}) : super(key: key);

  static const List<Widget> screens = <Widget>[
    HomePage(),
    StocksPage(),
    ScannerPage(),
    AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens
          .elementAt(context.watch<CommonProvider>().bottomBarSelectedIndex),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(title),
        elevation: 0,
      ),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }
}
