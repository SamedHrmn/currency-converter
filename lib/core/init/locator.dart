import 'package:get_it/get_it.dart';

import '../services/currency_service.dart';
import 'cache_manager.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<CurrencyService>(() => CurrencyService());
  getIt.registerLazySingleton<CacheCurrencyService>(() => CacheCurrencyService());
}
