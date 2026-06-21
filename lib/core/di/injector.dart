import 'package:get_it/get_it.dart';

import '../../data/db/app_database.dart';
import '../../data/remote/fx_api_client.dart';
import '../../data/repositories/currency_repository_impl.dart';
import '../../data/repositories/exchange_rate_repository_impl.dart';
import '../../data/repositories/ledger_repository_impl.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../domain/repositories/currency_repository.dart';
import '../../domain/repositories/exchange_rate_repository.dart';
import '../../domain/repositories/ledger_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/usecases/portfolio_calculator.dart';
import '../../domain/usecases/rates_service.dart';
import '../../domain/usecases/transfer_service.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  final db = AppDatabase();
  sl.registerSingleton<AppDatabase>(db);
  sl.registerLazySingleton<FxApiClient>(FxApiClient.new);

  sl.registerLazySingleton<LedgerRepository>(() => LedgerRepositoryImpl(sl()));
  sl.registerLazySingleton<ExchangeRateRepository>(
    () => ExchangeRateRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl()),
  );

  final currencyRepository = CurrencyRepositoryImpl(db);
  await currencyRepository.init();
  sl.registerSingleton<CurrencyRepository>(currencyRepository);

  sl.registerLazySingleton<RatesService>(
    () => RatesService(rateRepository: sl(), currencyRepository: sl()),
  );
  sl.registerLazySingleton<TransferService>(() => TransferService(sl()));
  sl.registerLazySingleton<PortfolioCalculator>(PortfolioCalculator.new);
}
