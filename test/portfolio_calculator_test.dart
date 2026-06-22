import 'package:decimal/decimal.dart';
import 'package:even/domain/entities/entry_category.dart';
import 'package:even/domain/entities/ledger_entry.dart';
import 'package:even/domain/entities/money.dart';
import 'package:even/domain/usecases/currency_converter.dart';
import 'package:even/domain/usecases/portfolio_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

LedgerEntry _entry(String id, EntryCategory category, String amount) {
  final now = DateTime(2026);
  return LedgerEntry(
    id: id,
    category: category,
    name: id,
    money: Money.parse(amount, 'USD'),
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  test('total is net worth: balance + lent - debt', () {
    const calculator = PortfolioCalculator();
    final converter = CurrencyConverter(
      displayCurrency: 'USD',
      unitsPerDisplay: const {},
    );

    final summary = calculator.build(
      entries: [
        _entry('lent1', EntryCategory.lent, '100'),
        _entry('debt1', EntryCategory.debt, '50'),
        _entry('cash', EntryCategory.balance, '200'),
      ],
      converter: converter,
      ratesStale: false,
    );

    expect(summary.group(EntryCategory.lent)!.subtotal, Decimal.parse('100'));
    expect(summary.group(EntryCategory.debt)!.subtotal, Decimal.parse('50'));
    expect(summary.group(EntryCategory.balance)!.subtotal, Decimal.parse('200'));
    expect(summary.total, Decimal.parse('250'));
  });

  test('informational lent (not funded) is excluded from total', () {
    const calculator = PortfolioCalculator();
    final converter = CurrencyConverter(
      displayCurrency: 'USD',
      unitsPerDisplay: const {},
    );
    final now = DateTime(2026);

    final informationalLent = LedgerEntry(
      id: 'l1',
      category: EntryCategory.lent,
      name: 'Old loan',
      money: Money.parse('200', 'USD'),
      includedInTotal: false,
      createdAt: now,
      updatedAt: now,
    );

    final summary = calculator.build(
      entries: [
        informationalLent,
        _entry('cash', EntryCategory.balance, '1000'),
      ],
      converter: converter,
      ratesStale: false,
    );

    expect(summary.group(EntryCategory.lent)!.subtotal, Decimal.parse('200'));
    expect(summary.total, Decimal.parse('1000'));
  });

  test('total goes negative when debt exceeds assets', () {
    const calculator = PortfolioCalculator();
    final converter = CurrencyConverter(
      displayCurrency: 'USD',
      unitsPerDisplay: const {},
    );

    final summary = calculator.build(
      entries: [
        _entry('lent1', EntryCategory.lent, '10'),
        _entry('debt1', EntryCategory.debt, '20'),
      ],
      converter: converter,
      ratesStale: false,
    );

    expect(summary.total, Decimal.parse('-10'));
  });
}
