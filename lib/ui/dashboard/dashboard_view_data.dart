import 'package:equatable/equatable.dart';

import '../../domain/entities/entry_category.dart';

class LedgerRowVm extends Equatable {
  const LedgerRowVm({
    required this.id,
    required this.name,
    required this.amountText,
    this.note,
    this.negative = false,
  });

  final String id;
  final String name;
  final String amountText;
  final String? note;
  final bool negative;

  @override
  List<Object?> get props => [id, name, amountText, note, negative];
}

class SectionVm extends Equatable {
  const SectionVm({
    required this.category,
    required this.rows,
    required this.subtotalText,
    required this.totalCount,
    this.negative = false,
  });

  final EntryCategory category;
  final List<LedgerRowVm> rows;
  final String subtotalText;
  final int totalCount;
  final bool negative;

  bool get hasMore => totalCount > rows.length;
  bool get isEmpty => totalCount == 0;

  @override
  List<Object?> get props =>
      [category, rows, subtotalText, totalCount, negative];
}

class DashboardViewData extends Equatable {
  const DashboardViewData({
    required this.totalText,
    required this.totalNegative,
    required this.displayCode,
    required this.sections,
    required this.ratesStale,
  });

  final String totalText;
  final bool totalNegative;
  final String displayCode;
  final List<SectionVm> sections;
  final bool ratesStale;

  @override
  List<Object?> get props =>
      [totalText, totalNegative, displayCode, sections, ratesStale];
}
