import 'package:auto_trade/app/app.dart';
import 'package:auto_trade/core/services/api_service.dart';
import 'package:auto_trade/utils/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await dotenv.load(fileName: Env.fileName);
  var loginRes = await APIService().login();
  runApp(
    ProviderScope(
      child: AutoTrade(
        res: loginRes,
      ),
    ),
  );
}
