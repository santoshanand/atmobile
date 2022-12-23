import 'package:auto_trade/core/providers/app_provider.dart';
import 'package:auto_trade/core/services/api_service.dart';
import 'package:auto_trade/screens/account/account_or_login.dart';
import 'package:auto_trade/screens/home/home.dart';
import 'package:auto_trade/shared/fab_bottom_app_bar.dart';
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

class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  static final List<TabItem> _tabs = <TabItem>[
    TabItem(screen: const HomeScreen(), title: 'Home'),
    // TabItem(screen: const TradeScreen(), title: 'Trades'),
    // TabItem(screen: const StockScreen(), title: 'Market'),
    TabItem(screen: const AccountOrLoginScreen(), title: 'Login'),
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    APIService().login().then((value) {
      setState(
        () {
          ref.read(appProvider).setLoggedIn(value != null ? true : false);
        },
      );
    }).onError((error, stackTrace) {
      setState(() {
        ref.read(appProvider).setLoggedIn(false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var _isLoggedIn = ref.watch(appProvider).loggedIn;
    // ref.watch(appProvider.notifier).setLoggedIn(TabScreen.login);

    void _onItemTapped(int value) {
      setState(() {
        _selectedIndex = value;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(
          Icons.album_outlined,
          color: Colors.green,
          size: 32,
        ),
        elevation: 6.0,
      ),
      // title: (_index == 3 && _loggedIn) ? "Account" : _tabs[_index].title,
      body: SafeArea(child: _tabs[_selectedIndex].screen),
      bottomNavigationBar: FABBottomAppBar(
        onTabSelected: _onItemTapped,
        items: [
          FABBottomAppBarItem(
            iconData: Icons.home_outlined,
            text: 'Home',
          ),
          // FABBottomAppBarItem(iconData: Icons.trending_up_outlined, text: 'Trades'),
          // FABBottomAppBarItem(iconData: Icons.view_list_outlined, text: 'Market'),
          FABBottomAppBarItem(
            iconData: _isLoggedIn ? Icons.person_outline : Icons.lock_outline,
            text: _isLoggedIn ? 'Account' : 'Login',
          ),
        ],
        backgroundColor: Colors.white,
        centerItemText: '',
        notchedShape: const CircularNotchedRectangle(),
        color: Colors.black54,
        selectedColor: Colors.black,
      ),
    );
  }
}
