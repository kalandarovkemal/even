import 'package:decimal/decimal.dart';

import '../entities/money.dart';

class CurrencyConverter {
  const CurrencyConverter({
    required this.displayCurrency,
    required this.unitsPerDisplay,
    this.scale = 8,
  });

  final String displayCurrency;
  final Map<String, Decimal> unitsPerDisplay;
  final int scale;

  bool canConvert(String code) =>
      code == displayCurrency || unitsPerDisplay.containsKey(code);

  Decimal toDisplay(Money money) {
    if (money.currencyCode == displayCurrency) {
      return money.amount;
    }
    final rate = unitsPerDisplay[money.currencyCode];
    if (rate == null || rate == Decimal.zero) {
      return Decimal.zero;
    }
    return (money.amount / rate).toDecimal(scaleOnInfinitePrecision: scale);
  }

  Decimal fromDisplay(Decimal displayAmount, String code) {
    if (code == displayCurrency) {
      return displayAmount;
    }
    final rate = unitsPerDisplay[code];
    if (rate == null) {
      return Decimal.zero;
    }
    return (displayAmount * rate).round(scale: scale);
  }

  Money convert(Money money, String toCode) => Money(
        amount: fromDisplay(toDisplay(money), toCode),
        currencyCode: toCode,
      );
}
