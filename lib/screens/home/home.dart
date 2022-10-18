import 'package:auto_trade/utils/env.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Text(Env.apiUrl),
      ),
    );
  }
}
