import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/ledger_entry.dart';
import '../../domain/entities/transfer_destination.dart';

class WalletOption extends Equatable {
  const WalletOption({required this.id, required this.name});

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}

sealed class EditItemState extends Equatable {
  const EditItemState();

  @override
  List<Object?> get props => [];
}

class EditItemLoading extends EditItemState {
  const EditItemLoading();
}

class EditItemNotFound extends EditItemState {
  const EditItemNotFound();
}

class EditItemLoaded extends EditItemState {
  const EditItemLoaded({
    required this.source,
    required this.sourceAmountText,
    required this.symbol,
    required this.amount,
    required this.mode,
    required this.destination,
    required this.wallets,
    required this.targetWalletId,
    required this.saving,
  });

  final LedgerEntry source;
  final String sourceAmountText;
  final String symbol;
  final String amount;
  final AdjustMode mode;
  final TransferDestination destination;
  final List<WalletOption> wallets;
  final String? targetWalletId;
  final bool saving;

  Decimal? get parsedAmount => Decimal.tryParse(amount.trim());

  bool get canSave {
    final parsed = parsedAmount;
    if (parsed == null || parsed <= Decimal.zero || saving) {
      return false;
    }
    if (destination == TransferDestination.moveToBalance) {
      return wallets.isEmpty || targetWalletId != null;
    }
    return true;
  }

  EditItemLoaded copyWith({
    String? amount,
    AdjustMode? mode,
    TransferDestination? destination,
    List<WalletOption>? wallets,
    String? targetWalletId,
    bool? saving,
  }) =>
      EditItemLoaded(
        source: source,
        sourceAmountText: sourceAmountText,
        symbol: symbol,
        amount: amount ?? this.amount,
        mode: mode ?? this.mode,
        destination: destination ?? this.destination,
        wallets: wallets ?? this.wallets,
        targetWalletId: targetWalletId ?? this.targetWalletId,
        saving: saving ?? this.saving,
      );

  @override
  List<Object?> get props => [
        source,
        amount,
        mode,
        destination,
        wallets,
        targetWalletId,
        saving,
      ];
}
