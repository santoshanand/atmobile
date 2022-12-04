import 'package:auto_trade/core/providers/common.dart';
import 'package:auto_trade/screens/landing/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var profile = ref.watch(commonProvider).getProfile();
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("AutoTrade"),
        elevation: 0,
      ),
      body: SafeArea(
        child: Text(profile != null ? profile.userShortname : "No name"),
      ),
    );
  }
}
