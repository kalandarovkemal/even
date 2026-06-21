import '../entities/currency.dart';

abstract interface class CurrencyRepository {
  List<Currency> all();

  Currency? byCode(String code);

  List<Currency> search(String query);

  List<Currency> recent();

  Future<void> markUsed(String code);
}
