import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/entry_category.dart';

class AddItemState extends Equatable {
  const AddItemState({
    required this.category,
    required this.name,
    required this.amount,
    required this.currencyCode,
  });

  factory AddItemState.initial(String currencyCode) => AddItemState(
        category: EntryCategory.lent,
        name: '',
        amount: '',
        currencyCode: currencyCode,
      );

  final EntryCategory category;
  final String name;
  final String amount;
  final String currencyCode;

  Decimal? get parsedAmount {
    final value = Decimal.tryParse(amount.trim());
    return value;
  }

  bool get canSubmit {
    final parsed = parsedAmount;
    return name.trim().isNotEmpty && parsed != null && parsed > Decimal.zero;
  }

  AddItemState copyWith({
    EntryCategory? category,
    String? name,
    String? amount,
    String? currencyCode,
  }) =>
      AddItemState(
        category: category ?? this.category,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        currencyCode: currencyCode ?? this.currencyCode,
      );

  @override
  List<Object?> get props => [category, name, amount, currencyCode];
}
