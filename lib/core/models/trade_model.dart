class TradeModel {
  int? id;
  String? instrumentToken;
  String? exchangeToken;
  String? tradingSymbol;
  String? lastPrice;
  int? lotSize;
  String? instrumentType;
  String? segment;
  String? exchange;
  dynamic candles;
  String? type;
  String? dateTime;
  int? strikePrice;
  String? zerodhaSymbol;
  String? createdAt;

  TradeModel(
      {this.id,
      this.instrumentToken,
      this.exchangeToken,
      this.tradingSymbol,
      this.lastPrice,
      this.lotSize,
      this.instrumentType,
      this.segment,
      this.exchange,
      this.candles,
      this.type,
      this.dateTime,
      this.strikePrice,
      this.zerodhaSymbol,
      this.createdAt});

  TradeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instrumentToken = json['instrument_token'];
    exchangeToken = json['exchange_token'];
    tradingSymbol = json['trading_symbol'];
    lastPrice = json['last_price'];
    lotSize = json['lot_size'];
    instrumentType = json['instrument_type'];
    segment = json['segment'];
    exchange = json['exchange'];
    candles = json['candles'];
    type = json['type'];
    dateTime = json['date_time'];
    strikePrice = json['strike_price'];
    zerodhaSymbol = json['zerodha_symbol'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['instrument_token'] = instrumentToken;
    data['exchange_token'] = exchangeToken;
    data['trading_symbol'] = tradingSymbol;
    data['last_price'] = lastPrice;
    data['lot_size'] = lotSize;
    data['instrument_type'] = instrumentType;
    data['segment'] = segment;
    data['exchange'] = exchange;
    data['candles'] = candles;
    data['type'] = type;
    data['date_time'] = dateTime;
    data['strike_price'] = strikePrice;
    data['zerodha_symbol'] = zerodhaSymbol;
    data['created_at'] = createdAt;
    return data;
  }
}
