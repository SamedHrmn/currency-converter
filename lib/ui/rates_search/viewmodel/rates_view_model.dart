import 'package:flutter/material.dart';

import '../../../core/init/locator.dart';
import '../../../core/services/currency_service.dart';
import '../model/rates.dart';

enum RatesState { LoadingState, LoadedState, ErrorState }

class RatesViewModel extends ChangeNotifier {
  final CurrencyService _service = getIt.get<CurrencyService>();
  Rates _rate;
  RatesState _state;

  Rates get rate => _rate;

  RatesState get state => _state;

  RatesViewModel() {
    getLatestCurrencyRates('EUR');
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
      print('Exception : ' + e.toString());
    }
    return _rate;
  }
}
