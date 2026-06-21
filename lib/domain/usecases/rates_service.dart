import 'package:decimal/decimal.dart';

import '../repositories/currency_repository.dart';
import '../repositories/exchange_rate_repository.dart';

class RatesSnapshot {
  const RatesSnapshot({required this.unitsPerDisplay, required this.stale});

  final Map<String, Decimal> unitsPerDisplay;
  final bool stale;
}

class RatesService {
  RatesService({
    required ExchangeRateRepository rateRepository,
    required CurrencyRepository currencyRepository,
    this.ttl = const Duration(hours: 1),
  })  : _rates = rateRepository,
        _currencies = currencyRepository;

  final ExchangeRateRepository _rates;
  final CurrencyRepository _currencies;
  final Duration ttl;

  Future<RatesSnapshot> ensureRates(String displayCurrency) async {
    final targets = _currencies
        .all()
        .map((c) => c.code)
        .where((code) => code != displayCurrency)
        .toList();

    final lastFetched = await _rates.lastFetchedAt(displayCurrency);
    final isStale = lastFetched == null ||
        DateTime.now().difference(lastFetched) > ttl;

    if (isStale) {
      try {
        await _rates.refresh(displayCurrency, targets);
      } catch (_) {
        // keep last cached rates on failure; reported via stale flag
      }
    }

    final cached = await _rates.ratesFor(displayCurrency);
    final units = {
      for (final entry in cached.entries) entry.key: entry.value.rate,
    };
    final freshAfter = await _rates.lastFetchedAt(displayCurrency);
    final stale = freshAfter == null ||
        DateTime.now().difference(freshAfter) > ttl;

    return RatesSnapshot(unitsPerDisplay: units, stale: stale);
  }
}
