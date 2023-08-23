import 'package:currency_converter/core/init/locator.dart';
import 'package:currency_converter/core/services/http_currency_service.dart';
import 'package:currency_converter/features/rates_convert/model/convert_model.dart';
import 'package:flutter/material.dart';

enum ConverterState { IdleState, LoadingState, LoadedState, ErrorState }

class ConverterViewModel extends ChangeNotifier {
  final HttpCurrencyService _service = getIt.get<HttpCurrencyService>();
  ConvertModel? _convertModel = ConvertModel();
  ConverterState _state = ConverterState.IdleState;

  ConvertModel? get convertModel => _convertModel;

  ConverterState get state => _state;

  set state(ConverterState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> getConverterResult(String from, String to) async {
    try {
      state = ConverterState.LoadingState;
      _convertModel = await _service.getConverterResult(from, to);

      state = ConverterState.LoadedState;
    } catch (e) {
      state = ConverterState.ErrorState;
    }
  }
}
