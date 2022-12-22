class MarketStatusModel {
  String market;
  String marketStatus;
  String tradeDate;
  String index;
  dynamic last;
  dynamic variation;
  dynamic percentChange;
  String marketStatusMessage;

  MarketStatusModel({
    required this.market,
    required this.marketStatus,
    required this.tradeDate,
    required this.index,
    required this.last,
    required this.variation,
    required this.percentChange,
    required this.marketStatusMessage,
  });

  static MarketStatusModel fromJson(Map<String, dynamic> data) {
    return MarketStatusModel(
      market: data['market'],
      marketStatus: data['marketStatus'],
      tradeDate: data['tradeDate'],
      index: data['index'],
      last: data['last'],
      variation: data['variation'],
      percentChange: data['percentChange'],
      marketStatusMessage: data['marketStatusMessage'],
    );
  }
}
