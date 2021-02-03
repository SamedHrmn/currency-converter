import 'package:currency_converter/core/init/cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:currency_converter/core/services/currency_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<CurrencyService>(() => CurrencyService());
  getIt.registerLazySingleton<CacheCurrencyService>(
      () => CacheCurrencyService());
}
