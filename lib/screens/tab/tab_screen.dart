import 'package:auto_trade/core/models/login_response.dart';
import 'package:auto_trade/core/providers/api_provider.dart';
import 'package:auto_trade/core/providers/app_provider.dart';
import 'package:auto_trade/screens/account/account_or_login.dart';
import 'package:auto_trade/screens/home/home.dart';
import 'package:auto_trade/screens/stock/stock_screen.dart';
import 'package:auto_trade/screens/trade/trade_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabScreen extends ConsumerWidget {
  static const List<Widget> _screens = <Widget>[HomeScreen(), TradeScreen(), StockScreen(), AccountOrLoginScreen()];

  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int _index = ref.watch(appProvider).tabIndex;
    bool _loggedIn = ref.watch(appProvider).loggedIn;

    void _onItemTapped(int value) {
      ref.read(appProvider.notifier).setTabIndex(value);
    }

    ref.listen(loginProvider, (Object? previous, Object? next) {
      var profile = next as AsyncData<ProfileModel?>;
      if (profile.value != null) {
        ref.read(appProvider.notifier).setLoggedIn(true);
        ref.read(appProvider.notifier).setProfile(profile.value);
      }
    });
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Trades',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.view_list_outlined),
            label: 'Stocks',
          ),
          BottomNavigationBarItem(
            icon: _loggedIn ? const Icon(Icons.person) : const Icon(Icons.lock),
            label: _loggedIn ? 'Account' : 'Login',
          ),
        ],
        currentIndex: _index,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}
