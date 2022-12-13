import 'package:auto_trade/core/models/login_request.dart';
import 'package:auto_trade/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _openZerodhaDialog() async {
      await Navigator.of(context).push(
        MaterialPageRoute<LoginRequest?>(
          builder: (BuildContext context) {
            return LoginScreenTemp();
          },
          fullscreenDialog: true,
        ),
      );
    }

    _openFyersDialog() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("In progress..."),
        ),
      );
    }

    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: OutlinedButton(
                onPressed: _openZerodhaDialog,
                child: const Text('Login With Zerodha'),
              ),
            ),
            SizedBox(
              width: 200,
              child: OutlinedButton(
                onPressed: _openFyersDialog,
                child: const Text('Login With Fyers'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
