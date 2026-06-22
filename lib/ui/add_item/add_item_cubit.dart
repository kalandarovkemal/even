import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/entry_category.dart';
import '../../domain/entities/ledger_entry.dart';
import '../../domain/repositories/ledger_repository.dart';
import '../../domain/usecases/add_entry_service.dart';
import '../../domain/usecases/currency_converter.dart';
import '../../domain/usecases/rates_service.dart';
import '../common/wallet_option.dart';
import 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  AddItemCubit({
    required LedgerRepository ledger,
    required AddEntryService addEntryService,
    required RatesService ratesService,
    required String initialCurrency,
    Uuid? uuid,
  })  : _ledger = ledger,
        _addEntry = addEntryService,
        _ratesService = ratesService,
        _uuid = uuid ?? const Uuid(),
        super(AddItemState.initial(initialCurrency));

  final LedgerRepository _ledger;
  final AddEntryService _addEntry;
  final RatesService _ratesService;
  final Uuid _uuid;

  StreamSubscription<List<LedgerEntry>>? _walletsSub;
  bool _fundingTouched = false;

  void start() {
    _walletsSub =
        _ledger.watchByCategory(EntryCategory.balance).listen((wallets) {
      final options =
          wallets.map((w) => WalletOption(id: w.id, name: w.name)).toList();
      final funding = _fundingTouched
          ? state.fundingWalletId
          : (options.isNotEmpty ? options.first.id : null);
      emit(state.copyWith(
        wallets: options,
        fundingWalletId: funding,
        clearFunding: funding == null,
      ));
    });
  }

  void setCategory(EntryCategory category) =>
      emit(state.copyWith(category: category));

  void setName(String name) => emit(state.copyWith(name: name));

  void setAmount(String amount) => emit(state.copyWith(amount: amount));

  void setCurrency(String code) => emit(state.copyWith(currencyCode: code));

  void setFundingWallet(String? walletId) {
    _fundingTouched = true;
    emit(state.copyWith(
      fundingWalletId: walletId,
      clearFunding: walletId == null,
    ));
  }

  Future<bool> submit() async {
    if (!state.canSubmit) {
      return false;
    }
    final fundingId = state.needsFunding ? state.fundingWalletId : null;

    CurrencyConverter? converter;
    if (fundingId != null) {
      final snapshot = await _ratesService.ensureRates(state.currencyCode);
      converter = CurrencyConverter(
        displayCurrency: state.currencyCode,
        unitsPerDisplay: snapshot.unitsPerDisplay,
      );
    }

    await _addEntry.create(
      AddEntryRequest(
        id: _uuid.v4(),
        category: state.category,
        name: state.name.trim(),
        amount: state.parsedAmount!,
        currencyCode: state.currencyCode,
        fundingWalletId: fundingId,
        converter: converter,
      ),
      now: DateTime.now(),
    );
    return true;
  }

  @override
  Future<void> close() {
    _walletsSub?.cancel();
    return super.close();
  }
}
