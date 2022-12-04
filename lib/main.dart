import 'package:auto_trade/app/app.dart';
import 'package:auto_trade/utils/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await dotenv.load(fileName: Env.fileName);
  runApp(
    const ProviderScope(
      child: AutoTrade(),
    ),
  );
}
