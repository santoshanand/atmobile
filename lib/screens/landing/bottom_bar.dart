import 'package:auto_trade/providers/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

BottomNavigationBar bottomNavigationBar(BuildContext context) {
  final commonProvider = Provider.of<CommonProvider>(context, listen: true);
  void _onItemTapped(int index) {
    commonProvider.setBottomSelectedIndex(index);
  }

  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'Stocks',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.online_prediction_rounded),
        label: 'Scanner',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.lock),
        label: 'Account',
      ),
    ],
    currentIndex: commonProvider.bottomBarSelectedIndex,
    showUnselectedLabels: true,
    selectedItemColor: Colors.black,
    unselectedIconTheme: const IconThemeData(
      color: Colors.black45,
    ),
    unselectedItemColor: Colors.black45,
    elevation: 0,
    onTap: _onItemTapped,
  );
}
