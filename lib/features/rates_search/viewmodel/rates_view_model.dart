import 'package:currency_converter/core/enums/currency_enum.dart';
import 'package:currency_converter/core/init/locator.dart';
import 'package:currency_converter/core/services/http_currency_service.dart';
import 'package:currency_converter/features/rates_search/model/rates_model.dart';
import 'package:flutter/material.dart';

enum RatesState { IdleState, LoadingState, LoadedState, ErrorState }

class RatesViewModel extends ChangeNotifier {
  final HttpCurrencyService _service = getIt.get<HttpCurrencyService>();
  RatesModel _rate = RatesModel();
  RatesState _state = RatesState.IdleState;
  List<CurrencyEnum> currencyBase = [];
  CurrencyEnum? lastCurrencyBaseForRates;

  RatesModel get rate => _rate;

  RatesState get state => _state;

  RatesViewModel() {
    getLatestCurrencyRates('TRY');
  }

  set state(RatesState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> getLatestCurrencyRates(String baseCurrency) async {
    try {
      state = RatesState.LoadingState;
      _rate = await _service.getCurrencyRates(baseCurrency);
      if (_rate.rates == null) {
        state = RatesState.ErrorState;
        return;
      }
      currencyBase = [];

      _rate.rates!.forEach((key, value) => currencyBase.add(CurrencyEnum.values.byName(key)));
      currencyBase = currencyBase.toSet().toList();
      lastCurrencyBaseForRates = CurrencyEnum.values.byName(baseCurrency);
      state = RatesState.LoadedState;
    } catch (e) {
      state = RatesState.ErrorState;
    }
  }
}
