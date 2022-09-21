import 'package:intl/intl.dart';

class Formatter {
  final NumberFormat formatter = NumberFormat("#,##0.00", "pt_BR");
  final bool currencyIcon;

  Formatter({this.currencyIcon = true});

  String formatCurrencyNumber(double number) {
    String formattedNumber = formatter.format(number);
    return currencyIcon ? 'R\$ $formattedNumber' : formattedNumber;
  }
}
