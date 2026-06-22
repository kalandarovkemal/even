import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/money_formatter.dart';
import '../../domain/entities/entry_category.dart';
import '../../domain/entities/ledger_entry.dart';
import '../../domain/repositories/currency_repository.dart';
import '../../domain/repositories/ledger_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/usecases/currency_converter.dart';
import '../../domain/usecases/rates_service.dart';
import '../dashboard/dashboard_view_data.dart';
import 'category_detail_state.dart';
import 'category_sort.dart';

class CategoryDetailCubit extends Cubit<CategoryDetailState> {
  CategoryDetailCubit({
    required this.category,
    required LedgerRepository ledger,
    required SettingsRepository settings,
    required RatesService ratesService,
    required CurrencyRepository currencies,
  })  : _ledger = ledger,
        _settings = settings,
        _ratesService = ratesService,
        _currencies = currencies,
        super(const CategoryDetailLoading());

  final EntryCategory category;
  final LedgerRepository _ledger;
  final SettingsRepository _settings;
  final RatesService _ratesService;
  final CurrencyRepository _currencies;

  StreamSubscription<List<LedgerEntry>>? _entriesSub;
  StreamSubscription<String>? _currencySub;

  List<LedgerEntry>? _entries;
  String? _displayCurrency;
  CategorySort _sort = CategorySort.amountDesc;

  void start() {
    _entriesSub = _ledger.watchByCategory(category).listen((entries) {
      _entries = entries;
      unawaited(_recompute());
    });
    _currencySub = _settings.watchDisplayCurrency().listen((code) {
      _displayCurrency = code;
      unawaited(_recompute());
    });
  }

  void setSort(CategorySort sort) {
    _sort = sort;
    unawaited(_recompute());
  }

  Future<void> _recompute() async {
    final entries = _entries;
    final display = _displayCurrency;
    if (entries == null || display == null) {
      return;
    }
    try {
      final snapshot = await _ratesService.ensureRates(display);
      if (isClosed) {
        return;
      }
      final converter = CurrencyConverter(
        displayCurrency: display,
        unitsPerDisplay: snapshot.unitsPerDisplay,
      );

      final sorted = [...entries];
      sorted.sort((a, b) => _compare(a, b, converter));

      final total = entries.fold(
        Decimal.zero,
        (sum, e) => sum + converter.toDisplay(e.money),
      );
      final displaySymbol = _currencies.byCode(display)?.symbol ?? '$display ';

      final isLiability = category == EntryCategory.debt;
      emit(
        CategoryDetailLoaded(
          headerTotal: MoneyFormatter.format(
            isLiability ? -total : total,
            symbol: displaySymbol,
          ),
          headerNegative: isLiability && total > Decimal.zero,
          rows: sorted.map(_toRow).toList(),
          sort: _sort,
        ),
      );
    } catch (e) {
      if (!isClosed) {
        emit(CategoryDetailFailure(e.toString()));
      }
    }
  }

  int _compare(LedgerEntry a, LedgerEntry b, CurrencyConverter converter) {
    return switch (_sort) {
      CategorySort.amountDesc =>
        converter.toDisplay(b.money).compareTo(converter.toDisplay(a.money)),
      CategorySort.amountAsc =>
        converter.toDisplay(a.money).compareTo(converter.toDisplay(b.money)),
      CategorySort.nameAsc =>
        a.name.toLowerCase().compareTo(b.name.toLowerCase()),
    };
  }

  LedgerRowVm _toRow(LedgerEntry entry) {
    final isLiability = category == EntryCategory.debt;
    final amount = isLiability ? -entry.money.amount : entry.money.amount;
    final currency = _currencies.byCode(entry.money.currencyCode);
    final amountText = currency == null
        ? MoneyFormatter.format(amount, symbol: '${entry.money.currencyCode} ')
        : MoneyFormatter.forCurrency(amount, currency);
    return LedgerRowVm(
      id: entry.id,
      name: entry.name,
      note: entry.note,
      amountText: amountText,
      negative: isLiability,
      informational: !entry.includedInTotal,
    );
  }

  @override
  Future<void> close() {
    _entriesSub?.cancel();
    _currencySub?.cancel();
    return super.close();
  }
}
