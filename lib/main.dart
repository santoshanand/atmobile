import 'package:auto_trade/app/app.dart';
import 'package:auto_trade/core/providers/api_provider.dart';
import 'package:auto_trade/utils/env.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: Env.fileName);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ServiceNotifier>(
          create: (_) => ServiceNotifier(),
        ),
      ],
      child: const ConnectionNotifier(
        child: AutoTrade(),
      ),
    ),
  );
}
