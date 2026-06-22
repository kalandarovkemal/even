import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/entry_category.dart';
import '../common/wallet_option.dart';

class AddItemState extends Equatable {
  const AddItemState({
    required this.category,
    required this.name,
    required this.amount,
    required this.currencyCode,
    required this.wallets,
    required this.fundingWalletId,
  });

  factory AddItemState.initial(String currencyCode) => AddItemState(
        category: EntryCategory.lent,
        name: '',
        amount: '',
        currencyCode: currencyCode,
        wallets: const [],
        fundingWalletId: null,
      );

  final EntryCategory category;
  final String name;
  final String amount;
  final String currencyCode;
  final List<WalletOption> wallets;
  final String? fundingWalletId;

  bool get needsFunding => category != EntryCategory.balance;

  Decimal? get parsedAmount => Decimal.tryParse(amount.trim());

  bool get canSubmit {
    final parsed = parsedAmount;
    return name.trim().isNotEmpty && parsed != null && parsed > Decimal.zero;
  }

  AddItemState copyWith({
    EntryCategory? category,
    String? name,
    String? amount,
    String? currencyCode,
    List<WalletOption>? wallets,
    String? fundingWalletId,
    bool clearFunding = false,
  }) =>
      AddItemState(
        category: category ?? this.category,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        currencyCode: currencyCode ?? this.currencyCode,
        wallets: wallets ?? this.wallets,
        fundingWalletId:
            clearFunding ? null : (fundingWalletId ?? this.fundingWalletId),
      );

  @override
  List<Object?> get props =>
      [category, name, amount, currencyCode, wallets, fundingWalletId];
}
