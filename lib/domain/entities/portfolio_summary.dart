import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

import 'entry_category.dart';
import 'ledger_entry.dart';

class CategoryGroup extends Equatable {
  const CategoryGroup({
    required this.category,
    required this.entries,
    required this.subtotal,
  });

  final EntryCategory category;
  final List<LedgerEntry> entries;
  final Decimal subtotal;

  @override
  List<Object?> get props => [category, entries, subtotal];
}

class PortfolioSummary extends Equatable {
  const PortfolioSummary({
    required this.displayCurrency,
    required this.groups,
    required this.total,
    required this.ratesStale,
  });

  final String displayCurrency;
  final Map<EntryCategory, CategoryGroup> groups;
  final Decimal total;
  final bool ratesStale;

  CategoryGroup? group(EntryCategory category) => groups[category];

  @override
  List<Object?> get props => [displayCurrency, groups, total, ratesStale];
}
