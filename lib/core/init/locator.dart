import 'dart:io';

import 'package:get_it/get_it.dart';

import '../services/http_currency_service.dart';
import 'cache_manager.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<HttpCurrencyService>(() => HttpCurrencyService(HttpClient()));
  getIt.registerLazySingleton<CacheCurrencyService>(() => CacheCurrencyService());
}
