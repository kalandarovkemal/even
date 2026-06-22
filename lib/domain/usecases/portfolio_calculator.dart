import 'package:decimal/decimal.dart';

import '../entities/entry_category.dart';
import '../entities/ledger_entry.dart';
import '../entities/portfolio_summary.dart';
import 'currency_converter.dart';

class PortfolioCalculator {
  const PortfolioCalculator();

  PortfolioSummary build({
    required List<LedgerEntry> entries,
    required CurrencyConverter converter,
    required bool ratesStale,
  }) {
    final groups = <EntryCategory, CategoryGroup>{};
    for (final category in EntryCategory.values) {
      final items = entries.where((e) => e.category == category).toList();
      final subtotal = items.fold(
        Decimal.zero,
        (sum, e) => sum + converter.toDisplay(e.money),
      );
      groups[category] = CategoryGroup(
        category: category,
        entries: items,
        subtotal: subtotal,
      );
    }

    final lent = _countedSum(entries, EntryCategory.lent, converter);
    final balance = groups[EntryCategory.balance]!.subtotal;
    final debt = _countedSum(entries, EntryCategory.debt, converter);
    final total = lent + balance - debt;

    return PortfolioSummary(
      displayCurrency: converter.displayCurrency,
      groups: groups,
      total: total,
      ratesStale: ratesStale,
    );
  }

  Decimal _countedSum(
    List<LedgerEntry> entries,
    EntryCategory category,
    CurrencyConverter converter,
  ) =>
      entries
          .where((e) => e.category == category && e.includedInTotal)
          .fold(Decimal.zero, (sum, e) => sum + converter.toDisplay(e.money));
}
