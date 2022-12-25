class LoginResponse {
  final bool success;
  final LoginModel data;

  LoginResponse({
    required this.success,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      data: LoginModel.fromJson(json['data']),
    );
  }
}

class LoginModel {
  String userId;
  String userName;
  String email;
  String phone;
  String broker;
  List<BankAccountModel> bankAccounts;
  String pan;
  String userShortname;
  String avatarUrl;

  LoginModel({
    required this.userId,
    required this.userName,
    required this.email,
    required this.phone,
    required this.broker,
    required this.bankAccounts,
    required this.pan,
    required this.userShortname,
    required this.avatarUrl,
  });
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        userId: json['user_id'],
        userName: json['user_name'],
        email: json['email'],
        phone: json['phone'],
        broker: json['broker'],
        bankAccounts: fromJsonList(json['bank_accounts']),
        pan: json['pan'],
        userShortname: json['user_shortname'],
        avatarUrl: json['avatar_url']);
  }

  static List<BankAccountModel> fromJsonList(List json) {
    return json.map((e) => BankAccountModel.fromJson(e)).toList();
  }
}

class BankAccountModel {
  String name;
  String branch;
  String account;

  BankAccountModel({
    required this.name,
    required this.branch,
    required this.account,
  });
  factory BankAccountModel.fromJson(Map<String, dynamic> json) {
    return BankAccountModel(name: json['name'], branch: json['branch'], account: json['account']);
  }
}
