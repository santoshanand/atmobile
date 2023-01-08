import 'package:auto_trade/core/providers/api_provider.dart';
import 'package:auto_trade/screens/account/account.dart';
import 'package:auto_trade/screens/home/home_screen.dart';
import 'package:auto_trade/screens/trade/trade_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class TabItem {
  Widget screen;
  String title;

  TabItem({
    required this.screen,
    required this.title,
  });
}

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  static final List<TabItem> _tabs = <TabItem>[
    TabItem(screen: const HomeScreen(), title: 'Home'),
    TabItem(screen: const TradeScreen(), title: 'Trades'),
    TabItem(screen: const AccountScreen(), title: 'Account'),
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ServiceNotifier>().login().then((value) {
      context.read<ServiceNotifier>().homeData();
    });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // });
  }

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int value) {
      setState(() {
        _selectedIndex = value;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: _tabs[_selectedIndex].screen),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.arrow_swap),
            label: 'Trades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.user),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
