import 'package:auto_trade/core/providers/nse.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // test('NSE data provider test', () async {
  //   final nseData = NSEDataProvider();

  //   final cookies = await nseData.httpCookies;
  //   expect(cookies?.length, greaterThanOrEqualTo(1));
  // });

  test('NSE market status test', () async {
    final nseData = NSEDataProvider();
    final res = await nseData.marketStatus();
    expect(res, isNotNull);
  });

  test('NSE Option Chain test', () async {
    final nseData = NSEDataProvider();
    final res = await nseData.optionChain('');
    expect(res, isNotNull);
  });
}
