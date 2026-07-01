import '../domain/entities/currency.dart';

const List<Currency> kCurrenciesSeed = [
  // Major
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

  // Europe (non-eurozone)
  Currency(code: 'SEK', name: 'Swedish Krona', symbol: 'kr', countryName: 'Sweden'),
  Currency(code: 'NOK', name: 'Norwegian Krone', symbol: 'kr', countryName: 'Norway'),
  Currency(code: 'DKK', name: 'Danish Krone', symbol: 'kr', countryName: 'Denmark'),
  Currency(code: 'PLN', name: 'Polish Zloty', symbol: 'zł', countryName: 'Poland'),
  Currency(code: 'CZK', name: 'Czech Koruna', symbol: 'Kč', countryName: 'Czechia'),
  Currency(code: 'HUF', name: 'Hungarian Forint', symbol: 'Ft', countryName: 'Hungary'),
  Currency(code: 'RON', name: 'Romanian Leu', symbol: 'lei', countryName: 'Romania'),
  Currency(code: 'BGN', name: 'Bulgarian Lev', symbol: 'лв', countryName: 'Bulgaria'),
  Currency(code: 'ISK', name: 'Icelandic Krona', symbol: 'kr', countryName: 'Iceland'),
  Currency(code: 'RSD', name: 'Serbian Dinar', symbol: 'дин.', countryName: 'Serbia'),
  Currency(code: 'UAH', name: 'Ukrainian Hryvnia', symbol: '₴', countryName: 'Ukraine'),
  Currency(code: 'BYN', name: 'Belarusian Ruble', symbol: 'Br', countryName: 'Belarus'),
  Currency(code: 'MDL', name: 'Moldovan Leu', symbol: 'L', countryName: 'Moldova'),
  Currency(code: 'MKD', name: 'Macedonian Denar', symbol: 'ден', countryName: 'North Macedonia'),
  Currency(code: 'ALL', name: 'Albanian Lek', symbol: 'L', countryName: 'Albania'),
  Currency(code: 'BAM', name: 'Bosnia-Herzegovina Mark', symbol: 'KM', countryName: 'Bosnia and Herzegovina'),

  // West Asia / Caucasus / Middle East
  Currency(code: 'TRY', name: 'Turkish Lira', symbol: '₺', countryName: 'Türkiye'),
  Currency(code: 'GEL', name: 'Georgian Lari', symbol: '₾', countryName: 'Georgia'),
  Currency(code: 'AMD', name: 'Armenian Dram', symbol: '֏', countryName: 'Armenia'),
  Currency(code: 'AZN', name: 'Azerbaijani Manat', symbol: '₼', countryName: 'Azerbaijan'),
  Currency(code: 'AED', name: 'UAE Dirham', symbol: 'د.إ', countryName: 'United Arab Emirates'),
  Currency(code: 'SAR', name: 'Saudi Riyal', symbol: '﷼', countryName: 'Saudi Arabia'),
  Currency(code: 'QAR', name: 'Qatari Riyal', symbol: '﷼', countryName: 'Qatar'),
  Currency(code: 'KWD', name: 'Kuwaiti Dinar', symbol: 'د.ك', countryName: 'Kuwait'),
  Currency(code: 'BHD', name: 'Bahraini Dinar', symbol: '.د.ب', countryName: 'Bahrain'),
  Currency(code: 'OMR', name: 'Omani Rial', symbol: '﷼', countryName: 'Oman'),
  Currency(code: 'JOD', name: 'Jordanian Dinar', symbol: 'د.ا', countryName: 'Jordan'),
  Currency(code: 'ILS', name: 'Israeli New Shekel', symbol: '₪', countryName: 'Israel'),
  Currency(code: 'LBP', name: 'Lebanese Pound', symbol: 'ل.ل', countryName: 'Lebanon'),
  Currency(code: 'IQD', name: 'Iraqi Dinar', symbol: 'ع.د', countryName: 'Iraq'),
  Currency(code: 'IRR', name: 'Iranian Rial', symbol: '﷼', countryName: 'Iran'),
  Currency(code: 'YER', name: 'Yemeni Rial', symbol: '﷼', countryName: 'Yemen'),
  Currency(code: 'SYP', name: 'Syrian Pound', symbol: '£', countryName: 'Syria'),
  Currency(code: 'AFN', name: 'Afghan Afghani', symbol: '؋', countryName: 'Afghanistan'),

  // Central Asia
  Currency(code: 'KZT', name: 'Kazakhstani Tenge', symbol: '₸', countryName: 'Kazakhstan'),
  Currency(code: 'UZS', name: 'Uzbekistani Som', symbol: 'soʻm', countryName: 'Uzbekistan'),
  Currency(code: 'KGS', name: 'Kyrgyzstani Som', symbol: 'с', countryName: 'Kyrgyzstan'),
  Currency(code: 'TJS', name: 'Tajikistani Somoni', symbol: 'ЅМ', countryName: 'Tajikistan'),
  Currency(code: 'TMT', name: 'Turkmenistani Manat', symbol: 'm', countryName: 'Turkmenistan'),

  // South Asia
  Currency(code: 'PKR', name: 'Pakistani Rupee', symbol: '₨', countryName: 'Pakistan'),
  Currency(code: 'BDT', name: 'Bangladeshi Taka', symbol: '৳', countryName: 'Bangladesh'),
  Currency(code: 'LKR', name: 'Sri Lankan Rupee', symbol: 'Rs', countryName: 'Sri Lanka'),
  Currency(code: 'NPR', name: 'Nepalese Rupee', symbol: 'रू', countryName: 'Nepal'),
  Currency(code: 'BTN', name: 'Bhutanese Ngultrum', symbol: 'Nu.', countryName: 'Bhutan'),
  Currency(code: 'MVR', name: 'Maldivian Rufiyaa', symbol: 'Rf', countryName: 'Maldives'),

  // East & Southeast Asia
  Currency(code: 'KRW', name: 'South Korean Won', symbol: '₩', countryName: 'South Korea'),
  Currency(code: 'HKD', name: 'Hong Kong Dollar', symbol: r'HK$', countryName: 'Hong Kong'),
  Currency(code: 'TWD', name: 'New Taiwan Dollar', symbol: r'NT$', countryName: 'Taiwan'),
  Currency(code: 'MOP', name: 'Macanese Pataca', symbol: r'MOP$', countryName: 'Macau'),
  Currency(code: 'SGD', name: 'Singapore Dollar', symbol: r'S$', countryName: 'Singapore'),
  Currency(code: 'MYR', name: 'Malaysian Ringgit', symbol: 'RM', countryName: 'Malaysia'),
  Currency(code: 'THB', name: 'Thai Baht', symbol: '฿', countryName: 'Thailand'),
  Currency(code: 'IDR', name: 'Indonesian Rupiah', symbol: 'Rp', countryName: 'Indonesia'),
  Currency(code: 'PHP', name: 'Philippine Peso', symbol: '₱', countryName: 'Philippines'),
  Currency(code: 'VND', name: 'Vietnamese Dong', symbol: '₫', countryName: 'Vietnam'),
  Currency(code: 'MMK', name: 'Myanmar Kyat', symbol: 'K', countryName: 'Myanmar'),
  Currency(code: 'KHR', name: 'Cambodian Riel', symbol: '៛', countryName: 'Cambodia'),
  Currency(code: 'LAK', name: 'Lao Kip', symbol: '₭', countryName: 'Laos'),
  Currency(code: 'BND', name: 'Brunei Dollar', symbol: r'B$', countryName: 'Brunei'),
  Currency(code: 'MNT', name: 'Mongolian Tugrik', symbol: '₮', countryName: 'Mongolia'),

  // Crypto
  Currency(code: 'BTC', name: 'Bitcoin', symbol: '₿', isCrypto: true),
];