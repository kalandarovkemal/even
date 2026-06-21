import 'package:drift/drift.dart';

import 'connection.dart';

part 'app_database.g.dart';

@DataClassName('LedgerEntryRow')
class LedgerEntries extends Table {
  TextColumn get id => text()();
  TextColumn get category => text()();
  TextColumn get name => text()();
  TextColumn get amount => text()();
  TextColumn get currencyCode => text()();
  TextColumn get note => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class ExchangeRateRows extends Table {
  TextColumn get base => text()();
  TextColumn get target => text()();
  TextColumn get rate => text()();
  IntColumn get fetchedAt => integer()();

  @override
  Set<Column> get primaryKey => {base, target};
}

class AppSettingRows extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

class RecentCurrencyRows extends Table {
  TextColumn get code => text()();
  IntColumn get usedAt => integer()();

  @override
  Set<Column> get primaryKey => {code};
}

@DriftDatabase(
  tables: [LedgerEntries, ExchangeRateRows, AppSettingRows, RecentCurrencyRows],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}
