import '../entities/entry_category.dart';
import '../entities/ledger_entry.dart';

abstract interface class LedgerRepository {
  Stream<List<LedgerEntry>> watchAll();

  Stream<List<LedgerEntry>> watchByCategory(EntryCategory category);

  Future<LedgerEntry?> findById(String id);

  Future<void> upsert(LedgerEntry entry);

  Future<void> delete(String id);
}
