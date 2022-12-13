class StockModel {
  String? instrumentToken;
  String? exchangeToken;
  String? tradingSymbol;
  String? lastPrice;
  String? expiry;
  String? strike;
  String? tickSize;
  int? lotSize;
  String? instrumentType;
  String? segment;
  String? exchange;
  bool? isBanned;
  dynamic candles;

  StockModel(
      {this.instrumentToken,
      this.exchangeToken,
      this.tradingSymbol,
      this.lastPrice,
      this.expiry,
      this.strike,
      this.tickSize,
      this.lotSize,
      this.instrumentType,
      this.segment,
      this.exchange,
      this.isBanned,
      this.candles});

  StockModel.fromJson(Map<String, dynamic> json) {
    instrumentToken = json['instrument_token'];
    exchangeToken = json['exchange_token'];
    tradingSymbol = json['trading_symbol'];
    lastPrice = json['last_price'];
    expiry = json['expiry'];
    strike = json['strike'];
    tickSize = json['tick_size'];
    lotSize = json['lot_size'];
    instrumentType = json['instrument_type'];
    segment = json['segment'];
    exchange = json['exchange'];
    isBanned = json['is_banned'];
    candles = json['candles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['instrument_token'] = instrumentToken;
    data['exchange_token'] = exchangeToken;
    data['trading_symbol'] = tradingSymbol;
    data['last_price'] = lastPrice;
    data['expiry'] = expiry;
    data['strike'] = strike;
    data['tick_size'] = tickSize;
    data['lot_size'] = lotSize;
    data['instrument_type'] = instrumentType;
    data['segment'] = segment;
    data['exchange'] = exchange;
    data['is_banned'] = isBanned;
    data['candles'] = candles;
    return data;
  }
}
