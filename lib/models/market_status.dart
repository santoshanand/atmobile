class MarketState {
  String market;
  String marketStatus;
  String tradeDate;
  String index;
  dynamic last;
  dynamic variation;
  dynamic percentChange;
  String marketStatusMessage;

  MarketState({
    required this.market,
    required this.marketStatus,
    required this.tradeDate,
    required this.index,
    required this.last,
    required this.variation,
    required this.percentChange,
    required this.marketStatusMessage,
  });

  static MarketState fromJson(Map<String, dynamic> data) {
    return MarketState(
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
