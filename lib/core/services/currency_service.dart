import 'package:currency_converter/core/init/cache_manager.dart';
import 'package:currency_converter/core/init/locator.dart';
import 'package:currency_converter/ui/rates_convert/model/converter.dart';
import 'package:currency_converter/ui/rates_search/model/rates.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class CurrencyService {
  static const String END_POINT = "https://api.exchangerate.host/";
  static const String LATEST_POINT = "latest?base=";

  Future<Rates> getCurrencyRates(String base) async {
    String filename = "currency_$base";

    var dir = await getTemporaryDirectory();

    CacheCurrencyService cacheCurrencyService =
        getIt.get<CacheCurrencyService>();

    cacheCurrencyService.initManager(
        fileName: filename, fileExtension: ".json", dir: dir);

    if (cacheCurrencyService.file.existsSync()) {
      print("Loaded from CACHE");
      var response = cacheCurrencyService.readFile();
      return ratesFromJson(response);
    } else {
      print("Loaded from API");
      var response = await http.get(END_POINT + LATEST_POINT + base);
      var body = response.body;

      cacheCurrencyService.writeFile(body: body);
      return (ratesFromJson(body));
    }
  }

  Future<Converter> getConverterResult(String from, String to) async {
    var response = await http.get(END_POINT + "convert?from=$from&to=$to");
    var body = response.body;
    return converterFromJson(body);
  }
}
