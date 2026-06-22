import 'package:equatable/equatable.dart';

import 'entry_category.dart';
import 'money.dart';

class LedgerEntry extends Equatable {
  const LedgerEntry({
    required this.id,
    required this.category,
    required this.name,
    required this.money,
    required this.createdAt,
    required this.updatedAt,
    this.note,
    this.includedInTotal = true,
  });

  final String id;
  final EntryCategory category;
  final String name;
  final Money money;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool includedInTotal;

  LedgerEntry copyWith({
    String? name,
    Money? money,
    String? note,
    bool? includedInTotal,
    DateTime? updatedAt,
  }) =>
      LedgerEntry(
        id: id,
        category: category,
        name: name ?? this.name,
        money: money ?? this.money,
        note: note ?? this.note,
        includedInTotal: includedInTotal ?? this.includedInTotal,
        createdAt: createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  List<Object?> get props =>
      [id, category, name, money, note, includedInTotal, updatedAt];
}
