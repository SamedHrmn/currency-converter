import 'package:currency_converter/core/init/locator.dart';
import 'package:currency_converter/ui/rates_search/model/rates.dart';
import 'package:currency_converter/core/services/currency_service.dart';
import 'package:flutter/material.dart';

enum RatesState { LoadingState, LoadedState, ErrorState }

class RatesViewModel extends ChangeNotifier {
  CurrencyService _service = getIt.get<CurrencyService>();
  Rates _rate;
  RatesState _state;

  Rates get rate => _rate;

  RatesState get state => _state;

  RatesViewModel() {
    getLatestCurrencyRates("EUR");
  }

  set state(RatesState state) {
    _state = state;
    notifyListeners();
  }

  Future<Rates> getLatestCurrencyRates(String base) async {
    try {
      state = RatesState.LoadingState;
      _rate = await _service.getCurrencyRates(base);

      state = RatesState.LoadedState;
    } catch (e) {
      state = RatesState.ErrorState;
      print("Exception : " + e.toString());
    }
    return _rate;
  }
}
