import 'package:auto_trade/shared/auto_trade_logo.dart';
import 'package:flutter/material.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(""),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                "Coudn't connect to internet.",
              ),
              const Text("Please check your network settings."),
              const SizedBox(
                height: 12,
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text("Refresh"),
              )
            ],
          ),
          const AutoTradeLogo(),
        ],
      ),
    );
  }
}
