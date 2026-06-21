import 'package:drift/drift.dart';

import '../../domain/repositories/settings_repository.dart';
import '../db/app_database.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._db);

  final AppDatabase _db;

  static const String _displayCurrencyKey = 'display_currency';
  static const String _languageKey = 'language_code';
  static const String _defaultCurrency = 'USD';

  @override
  Stream<String> watchDisplayCurrency() {
    final query = _db.select(_db.appSettingRows)
      ..where((t) => t.key.equals(_displayCurrencyKey));
    return query
        .watchSingleOrNull()
        .map((row) => row?.value ?? _defaultCurrency);
  }

  @override
  Future<String> displayCurrency() async {
    final row = await (_db.select(_db.appSettingRows)
          ..where((t) => t.key.equals(_displayCurrencyKey)))
        .getSingleOrNull();
    return row?.value ?? _defaultCurrency;
  }

  @override
  Future<void> setDisplayCurrency(String code) {
    return _db.into(_db.appSettingRows).insertOnConflictUpdate(
          AppSettingRowsCompanion(
            key: const Value(_displayCurrencyKey),
            value: Value(code),
          ),
        );
  }

  @override
  Stream<String?> watchLanguageCode() {
    final query = _db.select(_db.appSettingRows)
      ..where((t) => t.key.equals(_languageKey));
    return query.watchSingleOrNull().map((row) => row?.value);
  }

  @override
  Future<String?> languageCode() async {
    final row = await (_db.select(_db.appSettingRows)
          ..where((t) => t.key.equals(_languageKey)))
        .getSingleOrNull();
    return row?.value;
  }

  @override
  Future<void> setLanguageCode(String code) {
    return _db.into(_db.appSettingRows).insertOnConflictUpdate(
          AppSettingRowsCompanion(
            key: const Value(_languageKey),
            value: Value(code),
          ),
        );
  }
}
