import 'package:decimal/decimal.dart';
import 'package:even/domain/entities/entry_category.dart';
import 'package:even/domain/entities/ledger_entry.dart';
import 'package:even/domain/entities/money.dart';
import 'package:even/domain/entities/transfer_destination.dart';
import 'package:even/domain/repositories/ledger_repository.dart';
import 'package:even/domain/usecases/transfer_service.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeLedger implements LedgerRepository {
  final Map<String, LedgerEntry> store = {};

  @override
  Future<LedgerEntry?> findById(String id) async => store[id];

  @override
  Future<void> upsert(LedgerEntry entry) async => store[entry.id] = entry;

  @override
  Future<void> delete(String id) async => store.remove(id);

  @override
  Stream<List<LedgerEntry>> watchAll() => const Stream.empty();

  @override
  Stream<List<LedgerEntry>> watchByCategory(EntryCategory category) =>
      const Stream.empty();
}

LedgerEntry _entry(String id, EntryCategory category, String amount) {
  final now = DateTime(2026);
  return LedgerEntry(
    id: id,
    category: category,
    name: id,
    money: Money.parse(amount, 'USD'),
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  late _FakeLedger ledger;
  late TransferService service;
  final now = DateTime(2026, 6, 21);

  setUp(() {
    ledger = _FakeLedger();
    service = TransferService(ledger);
    ledger.store['egor'] = _entry('egor', EntryCategory.debt, '1000');
    ledger.store['cash'] = _entry('cash', EntryCategory.balance, '500');
  });

  test('subtract + move to balance: source down, wallet up', () async {
    await service.apply(
      TransferRequest(
        source: ledger.store['egor']!,
        amount: Decimal.parse('300'),
        mode: AdjustMode.subtract,
        destination: TransferDestination.moveToBalance,
        targetWalletId: 'cash',
      ),
      now: now,
    );

    expect(ledger.store['egor']!.money.amount, Decimal.parse('700'));
    expect(ledger.store['cash']!.money.amount, Decimal.parse('800'));
  });

  test('add + move from balance: source up, wallet down', () async {
    await service.apply(
      TransferRequest(
        source: ledger.store['egor']!,
        amount: Decimal.parse('200'),
        mode: AdjustMode.add,
        destination: TransferDestination.moveToBalance,
        targetWalletId: 'cash',
      ),
      now: now,
    );

    expect(ledger.store['egor']!.money.amount, Decimal.parse('1200'));
    expect(ledger.store['cash']!.money.amount, Decimal.parse('300'));
  });

  test('forgiven: only source changes', () async {
    await service.apply(
      TransferRequest(
        source: ledger.store['egor']!,
        amount: Decimal.parse('400'),
        mode: AdjustMode.subtract,
        destination: TransferDestination.forgiven,
      ),
      now: now,
    );

    expect(ledger.store['egor']!.money.amount, Decimal.parse('600'));
    expect(ledger.store['cash']!.money.amount, Decimal.parse('500'));
  });
}
