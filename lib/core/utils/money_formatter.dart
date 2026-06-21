import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/currency.dart';

abstract final class MoneyFormatter {
  static final Decimal _compactThreshold = Decimal.fromInt(10000);

  static const List<(double, String)> _compactUnits = [
    (1e15, 'Q'),
    (1e12, 'T'),
    (1e9, 'B'),
    (1e6, 'M'),
    (1e3, 'K'),
  ];

  static String format(
    Decimal amount, {
    required String symbol,
    bool isCrypto = false,
  }) {
    final negative = amount < Decimal.zero;
    final abs = negative ? -amount : amount;
    final body = _formatAbs(abs, isCrypto: isCrypto);
    return negative ? '−$symbol$body' : '$symbol$body';
  }

  static String _formatAbs(Decimal abs, {required bool isCrypto}) {
    if (abs >= _compactThreshold) {
      return _compact(abs.toDouble());
    }
    final hasFraction = abs != abs.truncate();
    final digits = hasFraction ? (isCrypto ? 8 : 2) : 0;
    final pattern = NumberFormat.decimalPatternDigits(decimalDigits: digits);
    return pattern.format(abs.toDouble());
  }

  static String forCurrency(Decimal amount, Currency currency) =>
      format(amount, symbol: currency.symbol, isCrypto: currency.isCrypto);

  static String _compact(double value) {
    for (final (threshold, suffix) in _compactUnits) {
      if (value.abs() >= threshold) {
        final scaled = value / threshold;
        final text = scaled.toStringAsFixed(1);
        final trimmed = text.endsWith('.0')
            ? text.substring(0, text.length - 2)
            : text;
        return '$trimmed$suffix';
      }
    }
    return value.toStringAsFixed(0);
  }
}
