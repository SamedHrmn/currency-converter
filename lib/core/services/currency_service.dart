import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../ui/rates_convert/model/converter.dart';
import '../../ui/rates_search/model/rates.dart';
import '../init/cache_manager.dart';
import '../init/locator.dart';

class CurrencyService {
  static const String END_POINT = 'https://api.exchangerate.host/';
  static const String LATEST_POINT = 'latest?base=';

  Future<Rates> getCurrencyRates(String base) async {
    var filename = 'currency_$base';

    var dir = await getTemporaryDirectory();

    var cacheCurrencyService = getIt.get<CacheCurrencyService>();

    cacheCurrencyService.initManager(fileName: filename, fileExtension: '.json', dir: dir);

    if (cacheCurrencyService.file.existsSync()) {
      cacheCurrencyService.cacheClear(DateTime.now(), base);

      var response = cacheCurrencyService.readFile();
      return ratesFromJson(response);
    } else {
      var response = await http.get(END_POINT + LATEST_POINT + base);
      var body = response.body;

      cacheCurrencyService.writeFile(body: body);
      return (ratesFromJson(body));
    }
  }

  Future<Converter> getConverterResult(String from, String to) async {
    var response = await http.get(END_POINT + 'convert?from=$from&to=$to');
    var body = response.body;
    return converterFromJson(body);
  }
}
