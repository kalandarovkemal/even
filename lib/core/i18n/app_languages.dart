class AppLanguage {
  const AppLanguage({required this.code, required this.endonym});

  final String code;
  final String endonym;
}

const List<AppLanguage> kSupportedLanguages = [
  AppLanguage(code: 'en', endonym: 'English'),
  AppLanguage(code: 'ru', endonym: 'Русский'),
  AppLanguage(code: 'es', endonym: 'Español'),
  AppLanguage(code: 'ja', endonym: '日本語'),
  AppLanguage(code: 'zh', endonym: '中文'),
  AppLanguage(code: 'tr', endonym: 'Türkçe'),
  AppLanguage(code: 'fr', endonym: 'Français'),
  AppLanguage(code: 'de', endonym: 'Deutsch'),
];
