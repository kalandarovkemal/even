abstract interface class SettingsRepository {
  Stream<String> watchDisplayCurrency();

  Future<String> displayCurrency();

  Future<void> setDisplayCurrency(String code);

  Stream<String?> watchLanguageCode();

  Future<String?> languageCode();

  Future<void> setLanguageCode(String code);

  Stream<bool> watchUnlocked();

  Future<bool> isUnlocked();

  Future<void> setUnlocked(bool value);
}
