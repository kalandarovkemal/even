import 'package:drift/drift.dart';

import '../../domain/entities/currency.dart';
import '../../domain/repositories/currency_repository.dart';
import '../currencies_seed.dart';
import '../db/app_database.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  CurrencyRepositoryImpl(this._db);

  final AppDatabase _db;
  final Map<String, Currency> _byCode = {
    for (final c in kCurrenciesSeed) c.code: c,
  };
  List<String> _recentCodes = const [];

  Future<void> init() async {
    final rows = await (_db.select(_db.recentCurrencyRows)
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.usedAt,
                  mode: OrderingMode.desc,
                ),
          ])
          ..limit(4))
        .get();
    _recentCodes = rows.map((r) => r.code).toList();
  }

  @override
  List<Currency> all() => kCurrenciesSeed;

  @override
  Currency? byCode(String code) => _byCode[code];

  @override
  List<Currency> search(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      return kCurrenciesSeed;
    }
    return kCurrenciesSeed
        .where((c) =>
            c.code.toLowerCase().contains(q) ||
            c.name.toLowerCase().contains(q) ||
            (c.countryName?.toLowerCase().contains(q) ?? false))
        .toList();
  }

  @override
  List<Currency> recent() => _recentCodes
      .map((code) => _byCode[code])
      .whereType<Currency>()
      .toList();

  @override
  Future<void> markUsed(String code) async {
    await _db.into(_db.recentCurrencyRows).insertOnConflictUpdate(
          RecentCurrencyRowsCompanion(
            code: Value(code),
            usedAt: Value(DateTime.now().millisecondsSinceEpoch),
          ),
        );
    await init();
  }
}
