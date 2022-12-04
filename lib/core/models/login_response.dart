class LoginResponse {
  final bool success;
  final Profile data;

  LoginResponse({
    required this.success,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      data: Profile.fromJson(json['data']),
    );
  }
}

class Profile {
  String userId;
  String userName;
  String email;
  String phone;
  String broker;
  List<BankAccount> bankAccounts;
  String pan;
  String userShortname;
  String avatarUrl;

  Profile({
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
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
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

  static List<BankAccount> fromJsonList(List json) {
    return json.map((e) => BankAccount.fromJson(e)).toList();
  }
}

class BankAccount {
  String name;
  String branch;
  String account;

  BankAccount({
    required this.name,
    required this.branch,
    required this.account,
  });
  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
        name: json['name'], branch: json['branch'], account: json['account']);
  }
}
