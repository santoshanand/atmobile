import 'package:auto_trade/core/models/market_status.dart';
import 'package:auto_trade/core/services/nse_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nseProvider = Provider<NSEService>((ref) => NSEService());

final marketStatusProvider = FutureProvider<List<MarketStatusModel>>((_ref) {
  return _ref.watch(nseProvider).marketStatus();
});
