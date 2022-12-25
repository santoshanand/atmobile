class Available {
  double? adhocmargin;
  double? cash;
  double? openingbalance;
  double? livebalance;
  double? collateral;
  double? intradaypayin;

  Available({this.adhocmargin, this.cash, this.openingbalance, this.livebalance, this.collateral, this.intradaypayin});

  Available.fromJson(Map<String, dynamic> json) {
    adhocmargin = json['adhoc_margin'] / 1;
    cash = json['cash'] / 1;
    openingbalance = json['opening_balance'] / 1;
    livebalance = json['live_balance'] / 1;
    collateral = json['collateral'] / 1;
    intradaypayin = json['intraday_payin'] / 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adhoc_margin'] = adhocmargin;
    data['cash'] = cash;
    data['opening_balance'] = openingbalance;
    data['live_balance'] = livebalance;
    data['collateral'] = collateral;
    data['intraday_payin'] = intradaypayin;
    return data;
  }
}

class Commodity {
  bool? enabled;
  double? net;
  Available? available;
  Utilised? utilised;

  Commodity({this.enabled, this.net, this.available, this.utilised});

  Commodity.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    net = json['net'] / 1;
    available = json['available'] != null ? Available?.fromJson(json['available']) : null;
    utilised = json['utilised'] != null ? Utilised?.fromJson(json['utilised']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enabled'] = enabled;
    data['net'] = net;
    data['available'] = available!.toJson();
    data['utilised'] = utilised!.toJson();
    return data;
  }
}

class MarginModel {
  Equity? equity;
  Commodity? commodity;

  MarginModel({this.equity, this.commodity});

  MarginModel.fromJson(Map<String, dynamic> json) {
    equity = json['equity'] != null ? Equity?.fromJson(json['equity']) : null;
    commodity = json['commodity'] != null ? Commodity?.fromJson(json['commodity']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['equity'] = equity!.toJson();
    data['commodity'] = commodity!.toJson();
    return data;
  }
}

class Equity {
  bool? enabled;
  double? net;
  Available? available;
  Utilised? utilised;

  Equity({this.enabled, this.net, this.available, this.utilised});

  Equity.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    net = json['net'] / 1;
    available = json['available'] != null ? Available?.fromJson(json['available']) : null;
    utilised = json['utilised'] != null ? Utilised?.fromJson(json['utilised']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enabled'] = enabled;
    data['net'] = net;
    data['available'] = available!.toJson();
    data['utilised'] = utilised!.toJson();
    return data;
  }
}

class MarginResponse {
  bool? success;
  MarginModel? data;

  MarginResponse({this.success, this.data});

  MarginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? MarginModel?.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = data;
    return data;
  }
}

class Utilised {
  double? debits;
  double? delivery;
  double? exposure;
  double? holdingsales;
  double? liquidcollateral;
  double? m2mrealised;
  double? m2munrealised;
  double? optionpremium;
  double? payout;
  double? span;
  double? stockcollateral;
  double? turnover;

  Utilised(
      {this.debits,
      this.delivery,
      this.exposure,
      this.holdingsales,
      this.liquidcollateral,
      this.m2mrealised,
      this.m2munrealised,
      this.optionpremium,
      this.payout,
      this.span,
      this.stockcollateral,
      this.turnover});

  Utilised.fromJson(Map<String, dynamic> json) {
    debits = json['debits'] / 1;
    delivery = json['delivery'] / 1;
    exposure = json['exposure'] / 1;
    holdingsales = json['holding_sales'] / 1;
    liquidcollateral = json['liquid_collateral'] / 1;
    m2mrealised = json['m2m_realised'] / 1;
    m2munrealised = json['m2m_unrealised'] / 1;
    optionpremium = json['option_premium'] / 1;
    payout = json['payout'] / 1;
    span = json['span'] / 1;
    stockcollateral = json['stock_collateral'] / 1;
    turnover = json['turnover'] / 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['debits'] = debits;
    data['delivery'] = delivery;
    data['exposure'] = exposure;
    data['holding_sales'] = holdingsales;
    data['liquid_collateral'] = liquidcollateral;
    data['m2m_realised'] = m2mrealised;
    data['m2m_unrealised'] = m2munrealised;
    data['option_premium'] = optionpremium;
    data['payout'] = payout;
    data['span'] = span;
    data['stock_collateral'] = stockcollateral;
    data['turnover'] = turnover;
    return data;
  }
}
