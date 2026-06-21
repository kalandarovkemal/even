import 'package:decimal/decimal.dart';

import '../entities/ledger_entry.dart';
import '../entities/money.dart';
import '../entities/transfer_destination.dart';
import '../repositories/ledger_repository.dart';
import 'currency_converter.dart';

class TransferRequest {
  const TransferRequest({
    required this.source,
    required this.amount,
    required this.mode,
    required this.destination,
    this.targetWalletId,
    this.converter,
  });

  final LedgerEntry source;
  final Decimal amount;
  final AdjustMode mode;
  final TransferDestination destination;
  final String? targetWalletId;
  final CurrencyConverter? converter;
}

class TransferService {
  const TransferService(this._ledger);

  final LedgerRepository _ledger;

  Future<void> apply(TransferRequest request, {required DateTime now}) async {
    final source = request.source;
    final delta = request.mode == AdjustMode.subtract
        ? -request.amount
        : request.amount;
    final updatedSource = source.copyWith(
      money: source.money.copyWith(amount: source.money.amount + delta),
      updatedAt: now,
    );
    await _ledger.upsert(updatedSource);

    if (request.destination != TransferDestination.moveToBalance) {
      return;
    }
    final walletId = request.targetWalletId;
    if (walletId == null) {
      return;
    }
    final wallet = await _ledger.findById(walletId);
    if (wallet == null) {
      return;
    }

    final walletAmount = request.mode == AdjustMode.subtract
        ? request.amount
        : -request.amount;
    final moved = Money(
      amount: walletAmount,
      currencyCode: source.money.currencyCode,
    );
    final credit = _toWalletCurrency(moved, wallet, request.converter);
    final updatedWallet = wallet.copyWith(
      money: wallet.money.copyWith(amount: wallet.money.amount + credit.amount),
      updatedAt: now,
    );
    await _ledger.upsert(updatedWallet);
  }

  Money _toWalletCurrency(Money moved, LedgerEntry wallet, CurrencyConverter? converter) {
    if (moved.currencyCode == wallet.money.currencyCode) {
      return moved;
    }
    if (converter != null) {
      return converter.convert(moved, wallet.money.currencyCode);
    }
    return Money(amount: moved.amount, currencyCode: wallet.money.currencyCode);
  }
}
