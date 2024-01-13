import 'dart:io';
import 'package:currency_converter/core/init/cache_manager.dart';
import 'package:currency_converter/core/services/http_currency_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt
    ..registerLazySingleton<HttpCurrencyService>(() => HttpCurrencyService(client: HttpClient(), apiKey: dotenv.env['APIKEY']!))
    ..registerLazySingleton<CacheCurrencyService>(CacheCurrencyService.new);
}
