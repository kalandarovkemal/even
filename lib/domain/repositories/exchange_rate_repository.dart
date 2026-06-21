import '../entities/exchange_rate.dart';

abstract interface class ExchangeRateRepository {
  Future<Map<String, ExchangeRate>> ratesFor(String base);

  Future<void> refresh(String base, List<String> targets);

  Future<DateTime?> lastFetchedAt(String base);
}
