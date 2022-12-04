import 'package:auto_trade/core/providers/common.dart';
import 'package:auto_trade/screens/home/home.dart';
import 'package:auto_trade/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Landing extends ConsumerWidget {
  final String title;
  const Landing({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.watch(commonProvider).isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          return const HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
