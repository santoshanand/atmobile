import 'package:auto_trade/core/models/login_response.dart';
import 'package:auto_trade/core/providers/api_provider.dart';
import 'package:auto_trade/core/providers/app_provider.dart';
import 'package:auto_trade/screens/account/account_or_login.dart';
import 'package:auto_trade/screens/home/home.dart';
import 'package:auto_trade/screens/stock/stock_screen.dart';
import 'package:auto_trade/screens/trade/trade_screen.dart';
import 'package:auto_trade/shared/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabItem {
  Widget screen;
  String title;
  TabItem({
    required this.screen,
    required this.title,
  });
}

class TabScreen extends ConsumerWidget {
  static final List<TabItem> _tabs = <TabItem>[
    TabItem(screen: const HomeScreen(), title: 'Home'),
    TabItem(screen: const TradeScreen(), title: 'Trades'),
    TabItem(screen: const StockScreen(), title: 'Stocks'),
    TabItem(screen: const AccountOrLoginScreen(), title: 'Login'),
  ];

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

    List<BottomNavigationBarItem> _getBottomTabs(bool _loggedIn) {
      return <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.trending_up_outlined),
          label: 'Trades',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.view_list_outlined),
          label: 'Stocks',
        ),
        BottomNavigationBarItem(
          icon: _loggedIn ? const Icon(Icons.person_outline) : const Icon(Icons.lock_outline),
          label: _loggedIn ? 'Account' : 'Login',
        ),
      ];
    }

    return AppScaffold(
      title: (_index == 3 && _loggedIn) ? "Account" : _tabs[_index].title,
      body: _tabs[_index].screen,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        items: _getBottomTabs(_loggedIn),
      ),
    );
  }
}
