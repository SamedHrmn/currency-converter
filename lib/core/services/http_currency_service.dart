import 'dart:convert';
import 'dart:io';

import 'package:currency_converter/core/init/cache_manager.dart';
import 'package:currency_converter/core/init/locator.dart';
import 'package:currency_converter/features/rates_convert/model/convert_model.dart';
import 'package:currency_converter/features/rates_search/model/rates_model.dart';
import 'package:path_provider/path_provider.dart';

abstract class ICurrencyService {
  Future<RatesModel?> getCurrencyRates(String baseUrl);
  Future<ConvertModel?> getConverterResult(String from, String to);
}

class HttpCurrencyService implements ICurrencyService {
  static const String END_POINT = 'https://api.exchangerate.host/';
  static const String LATEST_POINT = 'latest?base=';

  final HttpClient client;

  HttpCurrencyService(this.client);

  @override
  Future<RatesModel> getCurrencyRates(String baseUrl) async {
    final filename = 'currency_$baseUrl';

    final dir = await getTemporaryDirectory();

    final cacheCurrencyService = getIt.get<CacheCurrencyService>()..initManager(fileName: filename, fileExtension: '.json', dir: dir);

    if (cacheCurrencyService.file != null && cacheCurrencyService.file!.existsSync()) {
      cacheCurrencyService.cacheClear(DateTime.now(), baseUrl);

      final response = cacheCurrencyService.readFile();
      if (response == null) throw Exception();
      return RatesModel.fromJson(json.decode(response) as Map<String, dynamic>);
    } else {
      final request = await client.getUrl(Uri.parse(END_POINT + LATEST_POINT + baseUrl));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      client.close();

      cacheCurrencyService.writeFile(body: responseBody);
      return RatesModel.fromJson(json.decode(responseBody) as Map<String, dynamic>);
    }
  }

  @override
  Future<ConvertModel?> getConverterResult(String from, String to) async {
    try {
      final request = await client.getUrl(Uri.parse('${END_POINT}convert?from=$from&to=$to'));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      return ConvertModel.fromJson(json.decode(responseBody) as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }
}
