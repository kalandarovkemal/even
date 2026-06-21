import 'package:decimal/decimal.dart';
import 'package:drift/drift.dart';

import '../../domain/entities/exchange_rate.dart';
import '../../domain/repositories/exchange_rate_repository.dart';
import '../db/app_database.dart';
import '../remote/fx_api_client.dart';

class ExchangeRateRepositoryImpl implements ExchangeRateRepository {
  ExchangeRateRepositoryImpl(this._db, this._api);

  final AppDatabase _db;
  final FxApiClient _api;

  @override
  Future<Map<String, ExchangeRate>> ratesFor(String base) async {
    final rows = await (_db.select(_db.exchangeRateRows)
          ..where((t) => t.base.equals(base)))
        .get();
    return {
      for (final row in rows)
        row.target: ExchangeRate(
          base: row.base,
          target: row.target,
          rate: Decimal.parse(row.rate),
          fetchedAt: DateTime.fromMillisecondsSinceEpoch(row.fetchedAt),
        ),
    };
  }

  @override
  Future<void> refresh(String base, List<String> targets) async {
    final units = await _api.fetchUnitsPerBase(base: base, targets: targets);
    final now = DateTime.now().millisecondsSinceEpoch;
    await _db.batch((batch) {
      batch.insertAllOnConflictUpdate(
        _db.exchangeRateRows,
        units.entries.map(
          (e) => ExchangeRateRowsCompanion(
            base: Value(base),
            target: Value(e.key),
            rate: Value(e.value.toString()),
            fetchedAt: Value(now),
          ),
        ),
      );
    });
  }

  @override
  Future<DateTime?> lastFetchedAt(String base) async {
    final row = await (_db.select(_db.exchangeRateRows)
          ..where((t) => t.base.equals(base))
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.fetchedAt,
                  mode: OrderingMode.desc,
                ),
          ])
          ..limit(1))
        .getSingleOrNull();
    return row == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(row.fetchedAt);
  }
}
