import 'package:decimal/decimal.dart';

import '../entities/entry_category.dart';
import '../entities/ledger_entry.dart';
import '../entities/money.dart';
import '../repositories/ledger_repository.dart';
import 'currency_converter.dart';

class AddEntryRequest {
  const AddEntryRequest({
    required this.id,
    required this.category,
    required this.name,
    required this.amount,
    required this.currencyCode,
    this.fundingWalletId,
    this.converter,
  });

  final String id;
  final EntryCategory category;
  final String name;
  final Decimal amount;
  final String currencyCode;
  final String? fundingWalletId;
  final CurrencyConverter? converter;
}

class AddEntryService {
  const AddEntryService(this._ledger);

  final LedgerRepository _ledger;

  Future<void> create(AddEntryRequest request, {required DateTime now}) async {
    final funded = request.fundingWalletId != null &&
        request.category != EntryCategory.balance;

    final entry = LedgerEntry(
      id: request.id,
      category: request.category,
      name: request.name,
      money: Money(amount: request.amount, currencyCode: request.currencyCode),
      includedInTotal: request.category == EntryCategory.balance || funded,
      createdAt: now,
      updatedAt: now,
    );
    await _ledger.upsert(entry);

    if (!funded) {
      return;
    }
    final wallet = await _ledger.findById(request.fundingWalletId!);
    if (wallet == null) {
      return;
    }

    final sign =
        request.category == EntryCategory.lent ? -Decimal.one : Decimal.one;
    final moved = Money(
      amount: request.amount * sign,
      currencyCode: request.currencyCode,
    );
    final delta = _toWalletCurrency(moved, wallet.money.currencyCode, request.converter);
    final updatedWallet = wallet.copyWith(
      money: wallet.money.copyWith(amount: wallet.money.amount + delta.amount),
      updatedAt: now,
    );
    await _ledger.upsert(updatedWallet);
  }

  Money _toWalletCurrency(Money moved, String walletCode, CurrencyConverter? converter) {
    if (moved.currencyCode == walletCode) {
      return moved;
    }
    if (converter != null) {
      return converter.convert(moved, walletCode);
    }
    return Money(amount: moved.amount, currencyCode: walletCode);
  }
}
