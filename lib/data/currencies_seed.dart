import '../domain/entities/currency.dart';

const List<Currency> kCurrenciesSeed = [
  Currency(code: 'USD', name: 'US Dollar', symbol: r'$', countryName: 'United States'),
  Currency(code: 'EUR', name: 'Euro', symbol: '€', countryName: 'European Union'),
  Currency(code: 'GBP', name: 'British Pound', symbol: '£', countryName: 'United Kingdom'),
  Currency(code: 'JPY', name: 'Japanese Yen', symbol: '¥', countryName: 'Japan'),
  Currency(code: 'CHF', name: 'Swiss Franc', symbol: '₣', countryName: 'Switzerland'),
  Currency(code: 'AUD', name: 'Australian Dollar', symbol: r'A$', countryName: 'Australia'),
  Currency(code: 'CAD', name: 'Canadian Dollar', symbol: r'CA$', countryName: 'Canada'),
  Currency(code: 'CNY', name: 'Chinese Yuan', symbol: '¥', countryName: 'China'),
  Currency(code: 'INR', name: 'Indian Rupee', symbol: '₹', countryName: 'India'),
  Currency(code: 'RUB', name: 'Russian Ruble', symbol: '₽', countryName: 'Russia'),
  Currency(code: 'BTC', name: 'Bitcoin', symbol: '₿', isCrypto: true),
];
