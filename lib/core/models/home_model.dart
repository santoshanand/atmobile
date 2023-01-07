class BankAccount {
  String? name;
  String? branch;
  String? account;

  BankAccount({this.name, this.branch, this.account});

  BankAccount.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    branch = json['branch'];
    account = json['account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['branch'] = branch;
    data['account'] = account;
    return data;
  }
}

class Fund {
  num? total;
  num? pnl;

  Fund({this.total, this.pnl});

  Fund.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pnl = json['pnl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['pnl'] = pnl;
    return data;
  }
}

class Profile {
  String? userid;
  String? username;
  String? email;
  String? phone;
  String? broker;
  List<BankAccount?>? bankAccounts;
  String? pan;
  String? userShortname;
  String? avatarUrl;

  Profile({this.userid, this.username, this.email, this.phone, this.broker, this.bankAccounts, this.pan, this.userShortname, this.avatarUrl});

  Profile.fromJson(Map<String, dynamic> json) {
    userid = json['user_id'];
    username = json['user_name'];
    email = json['email'];
    phone = json['phone'];
    broker = json['broker'];
    if (json['bank_accounts'] != null) {
      bankAccounts = <BankAccount>[];
      json['bank_accounts'].forEach((v) {
        bankAccounts!.add(BankAccount.fromJson(v));
      });
    }
    pan = json['pan'];
    userShortname = json['user_shortname'];
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userid;
    data['user_name'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['broker'] = broker;
    data['bank_accounts'] = bankAccounts != null ? bankAccounts!.map((v) => v?.toJson()).toList() : null;
    data['pan'] = pan;
    data['user_shortname'] = userShortname;
    data['avatar_url'] = avatarUrl;
    return data;
  }
}

class Position {
  String? tradingsymbol;
  String? exchange;
  int? instrumenttoken;
  String? product;
  int? quantity;
  int? overnightquantity;
  int? multiplier;
  num? averageprice;
  num? closeprice;
  num? lastprice;
  num? value;
  num? pnl;
  num? m2m;
  num? unrealised;
  num? realised;
  int? buyquantity;
  num? buyprice;
  num? buyvalue;
  num? buym2m;
  int? sellquantity;
  num? sellprice;
  num? sellvalue;
  num? sellm2m;
  int? daybuyquantity;
  num? daybuyprice;
  num? daybuyvalue;
  int? daysellquantity;
  num? daysellprice;
  num? daysellvalue;

  Position(
      {this.tradingsymbol,
      this.exchange,
      this.instrumenttoken,
      this.product,
      this.quantity,
      this.overnightquantity,
      this.multiplier,
      this.averageprice,
      this.closeprice,
      this.lastprice,
      this.value,
      this.pnl,
      this.m2m,
      this.unrealised,
      this.realised,
      this.buyquantity,
      this.buyprice,
      this.buyvalue,
      this.buym2m,
      this.sellquantity,
      this.sellprice,
      this.sellvalue,
      this.sellm2m,
      this.daybuyquantity,
      this.daybuyprice,
      this.daybuyvalue,
      this.daysellquantity,
      this.daysellprice,
      this.daysellvalue});

  Position.fromJson(Map<String, dynamic> json) {
    tradingsymbol = json['tradingsymbol'];
    exchange = json['exchange'];
    instrumenttoken = json['instrument_token'];
    product = json['product'];
    quantity = json['quantity'];
    overnightquantity = json['overnight_quantity'];
    multiplier = json['multiplier'];
    averageprice = json['average_price'];
    closeprice = json['close_price'];
    lastprice = json['last_price'];
    value = json['value'];
    pnl = json['pnl'];
    m2m = json['m2m'];
    unrealised = json['unrealised'];
    realised = json['realised'];
    buyquantity = json['buy_quantity'];
    buyprice = json['buy_price'];
    buyvalue = json['buy_value'];
    buym2m = json['buy_m2m'];
    sellquantity = json['sell_quantity'];
    sellprice = json['sell_price'];
    sellvalue = json['sell_value'];
    sellm2m = json['sell_m2m'];
    daybuyquantity = json['day_buy_quantity'];
    daybuyprice = json['day_buy_price'];
    daybuyvalue = json['day_buy_value'];
    daysellquantity = json['day_sell_quantity'];
    daysellprice = json['day_sell_price'];
    daysellvalue = json['day_sell_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tradingsymbol'] = tradingsymbol;
    data['exchange'] = exchange;
    data['instrument_token'] = instrumenttoken;
    data['product'] = product;
    data['quantity'] = quantity;
    data['overnight_quantity'] = overnightquantity;
    data['multiplier'] = multiplier;
    data['average_price'] = averageprice;
    data['close_price'] = closeprice;
    data['last_price'] = lastprice;
    data['value'] = value;
    data['pnl'] = pnl;
    data['m2m'] = m2m;
    data['unrealised'] = unrealised;
    data['realised'] = realised;
    data['buy_quantity'] = buyquantity;
    data['buy_price'] = buyprice;
    data['buy_value'] = buyvalue;
    data['buy_m2m'] = buym2m;
    data['sell_quantity'] = sellquantity;
    data['sell_price'] = sellprice;
    data['sell_value'] = sellvalue;
    data['sell_m2m'] = sellm2m;
    data['day_buy_quantity'] = daybuyquantity;
    data['day_buy_price'] = daybuyprice;
    data['day_buy_value'] = daybuyvalue;
    data['day_sell_quantity'] = daysellquantity;
    data['day_sell_price'] = daysellprice;
    data['day_sell_value'] = daysellvalue;
    return data;
  }
}

class HomeModel {
  Profile? profile;
  Fund? fund;
  List<Position?>? positions;

  HomeModel({this.profile, this.fund});

  HomeModel.fromJson(Map<String, dynamic> json) {
    profile = json['profile'] != null ? Profile?.fromJson(json['profile']) : null;
    fund = json['fund'] != null ? Fund?.fromJson(json['fund']) : null;
    if (json['positions'] != null) {
      positions = <Position>[];
      json['positions'].forEach((v) {
        positions!.add(Position.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile'] = profile!.toJson();
    data['fund'] = fund!.toJson();
    data['positions'] = positions != null ? positions!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}
