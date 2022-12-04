import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends StateNotifier<String> {
  late SharedPreferences prefs;
  final key = "login";
  Future _init() async {
    prefs = await SharedPreferences.getInstance();
    var savedValue = prefs.getString(key);
    state = savedValue ?? '';
    if (savedValue != null && savedValue.isNotEmpty) {
      var prevDate = DateTime.parse(savedValue);
      var nowDate = DateTime.now();

      Duration diff = nowDate.difference(prevDate);
      if (diff.inDays > 0) {
        state = '';
      } else {
        state = savedValue;
      }
    }
  }

  LoginNotifier() : super('') {
    _init();
  }

  void setDate(String value) async {
    state = value;
    prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, String>(
  (ref) => LoginNotifier(),
);
