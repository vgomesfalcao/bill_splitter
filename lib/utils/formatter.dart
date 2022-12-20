import 'package:intl/intl.dart';

class Formatter {
  final NumberFormat formatter = NumberFormat("#,##0.00", "pt_BR");

  String formatCurrencyNumber(
      {required double number, bool currencyIcon = true}) {
    String formattedNumber = formatter.format(number);
    return currencyIcon ? 'R\$ $formattedNumber' : formattedNumber;
  }
}
