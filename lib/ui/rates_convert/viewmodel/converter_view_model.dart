import '../../../core/init/locator.dart';
import '../../../core/services/currency_service.dart';
import '../model/converter.dart';
import 'package:flutter/material.dart';

enum ConverterState { LoadingState, LoadedState, ErrorState }

class ConverterViewModel extends ChangeNotifier {
  final CurrencyService _service = getIt.get<CurrencyService>();
  Converter _converter;
  ConverterState _state;

  Converter get conventer => _converter;

  ConverterState get state => _state;

  set state(ConverterState state) {
    _state = state;
    notifyListeners();
  }

  Future<Converter> getConverterResult(String from, String to) async {
    try {
      state = ConverterState.LoadingState;
      _converter = await _service.getConverterResult(from, to);

      state = ConverterState.LoadedState;
    } catch (e) {
      state = ConverterState.ErrorState;
      print('Exception : ' + e.toString());
    }
    return _converter;
  }
}
