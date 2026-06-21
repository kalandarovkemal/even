import 'package:decimal/decimal.dart';
import 'package:even/domain/entities/money.dart';
import 'package:even/domain/usecases/currency_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencyConverter', () {
    final converter = CurrencyConverter(
      displayCurrency: 'USD',
      unitsPerDisplay: {
        'EUR': Decimal.parse('0.9'),
        'BTC': Decimal.parse('0.00002'),
      },
    );

    test('returns same amount for display currency', () {
      final result = converter.toDisplay(Money.parse('100', 'USD'));
      expect(result, Decimal.parse('100'));
    });

    test('converts foreign currency to display', () {
      final result = converter.toDisplay(Money.parse('90', 'EUR'));
      expect(result, Decimal.parse('100'));
    });

    test('converts crypto to display', () {
      final result = converter.toDisplay(Money.parse('1', 'BTC'));
      expect(result, Decimal.parse('50000'));
    });

    test('returns zero for unknown currency', () {
      final result = converter.toDisplay(Money.parse('10', 'JPY'));
      expect(result, Decimal.zero);
    });

    test('round-trips through wallet conversion', () {
      final moved = converter.convert(Money.parse('50000', 'USD'), 'BTC');
      expect(moved.currencyCode, 'BTC');
      expect(moved.amount, Decimal.parse('1'));
    });
  });
}
