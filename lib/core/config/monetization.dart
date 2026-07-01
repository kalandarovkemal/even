abstract final class Monetization {
  static const String lifetimeProductId = 'even_lifetime';

  static const int freeEntryLimit = 5;

  static const String fallbackPrice = r'$20';

  static const Set<String> freeCurrencyCodes = {'USD', 'EUR'};

  static const String freeLanguageCode = 'en';

  static bool isCurrencyFree(String code) => freeCurrencyCodes.contains(code);

  static bool isLanguageFree(String code) => code == freeLanguageCode;
}
