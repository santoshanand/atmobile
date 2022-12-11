import 'package:auto_trade/core/providers/app_provider.dart';
import 'package:auto_trade/screens/account/account_screen.dart';
import 'package:auto_trade/screens/account/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountOrLoginScreen extends ConsumerWidget {
  const AccountOrLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool _loggedIn = ref.watch(appProvider).loggedIn;

    return _loggedIn ? const AccountScreen() : const LoginScreen();
  }
}
