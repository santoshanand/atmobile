import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get fileName => kReleaseMode ? ".env.prod" : ".env.dev";
  static String get apiUrl =>
      dotenv.env['API_URL'] ?? 'http://localhost:8080/api/v1';
  static String get kiteUrl =>
      dotenv.env['ZERODHA_DASHBOARD'] ?? "https://kite.zerodha.com/dashboard";
}
