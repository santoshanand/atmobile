import 'package:auto_trade/app/app.dart';
import 'package:auto_trade/providers/common.dart';
import 'package:auto_trade/providers/nifty.dart';
import 'package:auto_trade/utils/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: Env.fileName);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NiftyProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CommonProvider(),
        ),
      ],
      child: const AutoTrade(),
    ),
  );
}
