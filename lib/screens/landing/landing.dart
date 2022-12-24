import 'package:auto_trade/core/models/login_response.dart';
import 'package:auto_trade/core/providers/app_provider.dart';
import 'package:auto_trade/screens/account/account_screen.dart';
import 'package:auto_trade/screens/home/home.dart';
import 'package:auto_trade/shared/fab_bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

class TabItem {
  Widget screen;
  String title;
  TabItem({
    required this.screen,
    required this.title,
  });
}

class LandingScreen extends ConsumerStatefulWidget {
  final ProfileModel? res;
  const LandingScreen(this.res, {Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  static final List<TabItem> _tabs = <TabItem>[
    TabItem(screen: const HomeScreen(), title: 'Home'),
    TabItem(screen: const AccountScreen(), title: 'Login'),
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(appProvider.notifier).setProfile(widget.res);
    });
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {},
        tooltip: 'AI',
        child: const Icon(
          Icons.album_outlined,
          color: Colors.green,
          size: 32,
        ),
        elevation: 6.0,
      ),
      body: SafeArea(child: _tabs[_selectedIndex].screen),
      bottomNavigationBar: FABBottomAppBar(
        onTabSelected: _onItemTapped,
        items: [
          FABBottomAppBarItem(
            iconData: Ionicons.home_outline,
            text: 'Home',
          ),
          FABBottomAppBarItem(
            iconData: Ionicons.person_outline,
            text: 'Account',
          ),
        ],
        backgroundColor: Colors.white,
        centerItemText: '',
        notchedShape: const CircularNotchedRectangle(),
        color: Colors.black54,
        selectedColor: Colors.blue,
      ),
    );
  }
}
