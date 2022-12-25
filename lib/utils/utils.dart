import 'package:intl/intl.dart';

class Utils {
  static String formatCurrency(double value) {
    return NumberFormat.currency(locale: 'en_IN', decimalDigits: 2, name: '₹').format(value);
  }
}
