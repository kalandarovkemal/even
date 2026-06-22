import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/money_formatter.dart';
import '../../domain/entities/entry_category.dart';
import '../../domain/entities/ledger_entry.dart';
import '../../domain/entities/portfolio_summary.dart';
import '../../domain/repositories/currency_repository.dart';
import '../../domain/repositories/ledger_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/usecases/currency_converter.dart';
import '../../domain/usecases/portfolio_calculator.dart';
import '../../domain/usecases/rates_service.dart';
import 'dashboard_state.dart';
import 'dashboard_view_data.dart';

const int _previewRows = 3;

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required LedgerRepository ledger,
    required SettingsRepository settings,
    required RatesService ratesService,
    required PortfolioCalculator calculator,
    required CurrencyRepository currencies,
  })  : _ledger = ledger,
        _settings = settings,
        _ratesService = ratesService,
        _calculator = calculator,
        _currencies = currencies,
        super(const DashboardLoading());

  final LedgerRepository _ledger;
  final SettingsRepository _settings;
  final RatesService _ratesService;
  final PortfolioCalculator _calculator;
  final CurrencyRepository _currencies;

  StreamSubscription<List<LedgerEntry>>? _entriesSub;
  StreamSubscription<String>? _currencySub;

  List<LedgerEntry>? _entries;
  String? _displayCurrency;

  void start() {
    _entriesSub = _ledger.watchAll().listen((entries) {
      _entries = entries;
      unawaited(_recompute());
    });
    _currencySub = _settings.watchDisplayCurrency().listen((code) {
      _displayCurrency = code;
      unawaited(_recompute());
    });
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
      final summary = _calculator.build(
        entries: entries,
        converter: converter,
        ratesStale: snapshot.stale,
      );
      emit(DashboardLoaded(_mapToView(summary)));
    } catch (e) {
      if (!isClosed) {
        emit(DashboardFailure(e.toString()));
      }
    }
  }

  DashboardViewData _mapToView(PortfolioSummary summary) {
    final displaySymbol = _symbolOf(summary.displayCurrency);
    final sections = [
      EntryCategory.lent,
      EntryCategory.debt,
      EntryCategory.balance,
    ].map((category) => _mapSection(summary, category, displaySymbol)).toList();

    return DashboardViewData(
      totalText: MoneyFormatter.format(summary.total, symbol: displaySymbol),
      totalNegative: summary.total < Decimal.zero,
      displayCode: summary.displayCurrency,
      sections: sections,
      ratesStale: summary.ratesStale,
    );
  }

  SectionVm _mapSection(
    PortfolioSummary summary,
    EntryCategory category,
    String displaySymbol,
  ) {
    final group = summary.group(category)!;
    final isLiability = category == EntryCategory.debt;
    final rows = group.entries
        .take(_previewRows)
        .map(
          (e) => LedgerRowVm(
            id: e.id,
            name: e.name,
            note: e.note,
            amountText: _formatEntry(
              isLiability ? -e.money.amount : e.money.amount,
              e.money.currencyCode,
            ),
            negative: isLiability,
            informational: !e.includedInTotal,
          ),
        )
        .toList();
    return SectionVm(
      category: category,
      rows: rows,
      subtotalText: MoneyFormatter.format(
        isLiability ? -group.subtotal : group.subtotal,
        symbol: displaySymbol,
      ),
      totalCount: group.entries.length,
      negative: isLiability,
    );
  }

  String _formatEntry(Decimal amount, String code) {
    final currency = _currencies.byCode(code);
    if (currency == null) {
      return MoneyFormatter.format(amount, symbol: '$code ');
    }
    return MoneyFormatter.forCurrency(amount, currency);
  }

  String _symbolOf(String code) => _currencies.byCode(code)?.symbol ?? '$code ';

  @override
  Future<void> close() {
    _entriesSub?.cancel();
    _currencySub?.cancel();
    return super.close();
  }
}
