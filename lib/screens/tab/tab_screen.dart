import 'package:auto_trade/core/providers/app_provider.dart';
import 'package:auto_trade/screens/home/home.dart';
import 'package:auto_trade/screens/account/login_screen.dart';
import 'package:auto_trade/screens/stock/stock_screen.dart';
import 'package:auto_trade/screens/trade/trade_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabScreen extends ConsumerWidget {
  const TabScreen({Key? key}) : super(key: key);
  static const List<Widget> _screens = <Widget>[HomeScreen(), TradeScreen(), StockScreen(), LoginScreen()];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int index = ref.watch(appProvider).tabIndex;

    void _onItemTapped(int value) {
      ref.read(appProvider.notifier).setTabIndex(value);
    }

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: const Text("AutoTrade"),
      //   elevation: 0,
      // ),
      body: _screens[index],
      bottomNavigationBar: _bottomBar(index, _onItemTapped),
    );
  }

  BottomNavigationBar _bottomBar(int index, void Function(int value) _onItemTapped) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up),
          label: 'Trades',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.view_list_outlined),
          label: 'Stocks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lock),
          label: 'Login',
        ),
      ],
      currentIndex: index,
      selectedItemColor: Colors.red[500],
      unselectedItemColor: Colors.grey[600],
      showUnselectedLabels: true,
      onTap: _onItemTapped,
    );
  }
}
