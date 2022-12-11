import 'package:auto_trade/core/models/login_response.dart';
import 'package:auto_trade/core/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiProvider = Provider<APIService>((ref) => APIService());

final loginProvider = FutureProvider<ProfileModel?>((_ref) {
  return _ref.watch(apiProvider).login();
});

final profileProvider = FutureProvider<ProfileModel?>((_ref) {
  return _ref.watch(apiProvider).profile();
});
