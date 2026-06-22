import 'package:decimal/decimal.dart';
import 'package:drift/drift.dart';

import '../../domain/entities/entry_category.dart';
import '../../domain/entities/ledger_entry.dart';
import '../../domain/entities/money.dart';
import '../../domain/repositories/ledger_repository.dart';
import '../db/app_database.dart';

class LedgerRepositoryImpl implements LedgerRepository {
  LedgerRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Stream<List<LedgerEntry>> watchAll() {
    final query = _db.select(_db.ledgerEntries)
      ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]);
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  @override
  Stream<List<LedgerEntry>> watchByCategory(EntryCategory category) {
    final query = _db.select(_db.ledgerEntries)
      ..where((t) => t.category.equals(category.name))
      ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]);
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  @override
  Future<LedgerEntry?> findById(String id) async {
    final row = await (_db.select(_db.ledgerEntries)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  @override
  Future<void> upsert(LedgerEntry entry) {
    return _db.into(_db.ledgerEntries).insertOnConflictUpdate(
          LedgerEntriesCompanion(
            id: Value(entry.id),
            category: Value(entry.category.name),
            name: Value(entry.name),
            amount: Value(entry.money.amount.toString()),
            currencyCode: Value(entry.money.currencyCode),
            note: Value(entry.note),
            includedInTotal: Value(entry.includedInTotal),
            createdAt: Value(entry.createdAt.millisecondsSinceEpoch),
            updatedAt: Value(entry.updatedAt.millisecondsSinceEpoch),
          ),
        );
  }

  @override
  Future<void> delete(String id) {
    return (_db.delete(_db.ledgerEntries)..where((t) => t.id.equals(id))).go();
  }

  LedgerEntry _toDomain(LedgerEntryRow row) => LedgerEntry(
        id: row.id,
        category: EntryCategory.fromName(row.category),
        name: row.name,
        money: Money(
          amount: Decimal.parse(row.amount),
          currencyCode: row.currencyCode,
        ),
        note: row.note,
        includedInTotal: row.includedInTotal,
        createdAt: DateTime.fromMillisecondsSinceEpoch(row.createdAt),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(row.updatedAt),
      );
}
