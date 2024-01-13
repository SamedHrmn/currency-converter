import 'package:currency_converter/core/enums/currency_enum.dart';
import 'package:currency_converter/features/rates_convert/view/converter_view.dart';
import 'package:currency_converter/features/rates_search/viewmodel/rates_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin ConverterViewMixin on State<ConverterPage> {
  CurrencyEnum selectedItemFrom = CurrencyEnum.EUR;
  CurrencyEnum selectedItemTo = CurrencyEnum.TRY;
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RatesViewModel>().getLatestCurrencyRates('TRY');
    });
  }

  void dropDownLeftItemCallBack(CurrencyEnum? val) {
    if (val == null) return;
    setState(() {
      selectedItemFrom = val;
    });
  }

  void dropDownRightItemCallBack(CurrencyEnum? val) {
    if (val == null) return;
    setState(() {
      selectedItemTo = val;
    });
  }
}
