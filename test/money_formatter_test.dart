import 'package:decimal/decimal.dart';
import 'package:even/core/utils/money_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

String fmt(String amount) =>
    MoneyFormatter.format(Decimal.parse(amount), symbol: r'$');

void main() {
  group('MoneyFormatter compact', () {
    test('below 10k is shown normally', () {
      expect(fmt('9650'), r'$9,650');
      expect(fmt('1234'), r'$1,234');
      expect(fmt('0'), r'$0');
      expect(fmt('1200.50'), r'$1,200.50');
    });

    test('10k and above use compact suffixes', () {
      expect(fmt('10000'), r'$10K');
      expect(fmt('12000'), r'$12K');
      expect(fmt('31400'), r'$31.4K');
      expect(fmt('1500000'), r'$1.5M');
      expect(fmt('2300000000'), r'$2.3B');
      expect(fmt('4000000000000'), r'$4T');
    });

    test('trailing .0 is trimmed', () {
      expect(fmt('25000'), r'$25K');
    });
  });
}
