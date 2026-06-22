import 'package:decimal/decimal.dart';
import 'package:even/domain/entities/entry_category.dart';
import 'package:even/domain/entities/ledger_entry.dart';
import 'package:even/domain/entities/money.dart';
import 'package:even/domain/repositories/ledger_repository.dart';
import 'package:even/domain/usecases/add_entry_service.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeLedger implements LedgerRepository {
  final Map<String, LedgerEntry> store = {};

  @override
  Future<LedgerEntry?> findById(String id) async => store[id];

  @override
  Future<int> count() async => store.length;

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

void main() {
  late _FakeLedger ledger;
  late AddEntryService service;
  final now = DateTime(2026, 6, 21);

  setUp(() {
    ledger = _FakeLedger();
    service = AddEntryService(ledger);
    ledger.store['cash'] = LedgerEntry(
      id: 'cash',
      category: EntryCategory.balance,
      name: 'Cash',
      money: Money.parse('1000', 'USD'),
      createdAt: now,
      updatedAt: now,
    );
  });

  test('lent funded from wallet: wallet down, entry counts in total', () async {
    await service.create(
      AddEntryRequest(
        id: 'l1',
        category: EntryCategory.lent,
        name: 'Egor',
        amount: Decimal.parse('200'),
        currencyCode: 'USD',
        fundingWalletId: 'cash',
      ),
      now: now,
    );

    expect(ledger.store['cash']!.money.amount, Decimal.parse('800'));
    expect(ledger.store['l1']!.includedInTotal, isTrue);
  });

  test('lent not funded: wallet untouched, entry informational', () async {
    await service.create(
      AddEntryRequest(
        id: 'l2',
        category: EntryCategory.lent,
        name: 'Old loan',
        amount: Decimal.parse('200'),
        currencyCode: 'USD',
        fundingWalletId: null,
      ),
      now: now,
    );

    expect(ledger.store['cash']!.money.amount, Decimal.parse('1000'));
    expect(ledger.store['l2']!.includedInTotal, isFalse);
  });

  test('debt funded to wallet: wallet up, entry counts', () async {
    await service.create(
      AddEntryRequest(
        id: 'd1',
        category: EntryCategory.debt,
        name: 'Bank',
        amount: Decimal.parse('200'),
        currencyCode: 'USD',
        fundingWalletId: 'cash',
      ),
      now: now,
    );

    expect(ledger.store['cash']!.money.amount, Decimal.parse('1200'));
    expect(ledger.store['d1']!.includedInTotal, isTrue);
  });
}
