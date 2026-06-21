import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/money_formatter.dart';
import '../../domain/entities/entry_category.dart';
import '../../domain/entities/ledger_entry.dart';
import '../../domain/entities/transfer_destination.dart';
import '../../domain/repositories/currency_repository.dart';
import '../../domain/repositories/ledger_repository.dart';
import '../../domain/usecases/currency_converter.dart';
import '../../domain/usecases/rates_service.dart';
import '../../domain/usecases/transfer_service.dart';
import 'edit_item_state.dart';

class EditItemCubit extends Cubit<EditItemState> {
  EditItemCubit({
    required this.entryId,
    required LedgerRepository ledger,
    required RatesService ratesService,
    required TransferService transferService,
    required CurrencyRepository currencies,
  })  : _ledger = ledger,
        _ratesService = ratesService,
        _transfer = transferService,
        _currencies = currencies,
        super(const EditItemLoading());

  final String entryId;
  final LedgerRepository _ledger;
  final RatesService _ratesService;
  final TransferService _transfer;
  final CurrencyRepository _currencies;

  StreamSubscription<List<LedgerEntry>>? _walletsSub;

  LedgerEntry? _source;
  List<LedgerEntry> _wallets = const [];
  bool _notFound = false;

  String _amount = '';
  AdjustMode _mode = AdjustMode.subtract;
  TransferDestination _destination = TransferDestination.moveToBalance;
  String? _targetWalletId;
  bool _saving = false;

  void start() {
    _walletsSub = _ledger.watchByCategory(EntryCategory.balance).listen((wallets) {
      _wallets = wallets;
      _ensureDefaultTarget();
      _emit();
    });
    unawaited(_loadSource());
  }

  Future<void> _loadSource() async {
    final entry = await _ledger.findById(entryId);
    if (isClosed) {
      return;
    }
    if (entry == null) {
      _notFound = true;
    } else {
      _source = entry;
    }
    _emit();
  }

  void setAmount(String amount) {
    _amount = amount;
    _emit();
  }

  void setMode(AdjustMode mode) {
    _mode = mode;
    if (mode == AdjustMode.add &&
        _destination == TransferDestination.forgiven) {
      _destination = TransferDestination.moveToBalance;
    }
    _emit();
  }

  void setDestination(TransferDestination destination) {
    _destination = destination;
    _emit();
  }

  void setTargetWallet(String walletId) {
    _targetWalletId = walletId;
    _emit();
  }

  Future<bool> save() async {
    final source = _source;
    final current = state;
    if (source == null || current is! EditItemLoaded || !current.canSave) {
      return false;
    }
    _saving = true;
    _emit();

    final snapshot = await _ratesService.ensureRates(source.money.currencyCode);
    final converter = CurrencyConverter(
      displayCurrency: source.money.currencyCode,
      unitsPerDisplay: snapshot.unitsPerDisplay,
    );

    await _transfer.apply(
      TransferRequest(
        source: source,
        amount: current.parsedAmount!,
        mode: _mode,
        destination: _destination,
        targetWalletId: _destination == TransferDestination.moveToBalance
            ? _targetWalletId
            : null,
        converter: converter,
      ),
      now: DateTime.now(),
    );
    return true;
  }

  void _ensureDefaultTarget() {
    final options = _walletOptions();
    if (_targetWalletId == null && options.isNotEmpty) {
      _targetWalletId = options.first.id;
    }
  }

  List<WalletOption> _walletOptions() => _wallets
      .where((w) => w.id != entryId)
      .map((w) => WalletOption(id: w.id, name: w.name))
      .toList();

  void _emit() {
    if (isClosed) {
      return;
    }
    if (_notFound) {
      emit(const EditItemNotFound());
      return;
    }
    final source = _source;
    if (source == null) {
      return;
    }
    final currency = _currencies.byCode(source.money.currencyCode);
    final amountText = currency == null
        ? MoneyFormatter.format(source.money.amount,
            symbol: '${source.money.currencyCode} ')
        : MoneyFormatter.forCurrency(source.money.amount, currency);

    emit(
      EditItemLoaded(
        source: source,
        sourceAmountText: amountText,
        symbol: currency?.symbol ?? '${source.money.currencyCode} ',
        amount: _amount,
        mode: _mode,
        destination: _destination,
        wallets: _walletOptions(),
        targetWalletId: _targetWalletId,
        saving: _saving,
      ),
    );
  }

  @override
  Future<void> close() {
    _walletsSub?.cancel();
    return super.close();
  }
}
