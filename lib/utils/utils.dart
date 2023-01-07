import 'package:intl/intl.dart';

class Utils {
  static String formatCurrency(num value) {
    return NumberFormat.currency(locale: 'en_IN', decimalDigits: 2, name: '₹').format(value);
  }

  static String formatWithoutCurrencySymbol(num value) {
    return NumberFormat.currency(locale: 'en_IN', decimalDigits: 2, name: '').format(value);
  }
}
