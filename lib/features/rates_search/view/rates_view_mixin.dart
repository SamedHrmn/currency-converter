import 'package:currency_converter/features/rates_search/view/rates_view.dart';
import 'package:currency_converter/features/rates_search/viewmodel/rates_view_model.dart';
import 'package:flutter/material.dart';

mixin RatesViewMixin on State<RatesPage> {
  String? searchText;
  Map<String, double> searchRates = {};
  late final AnimationController animController;

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  void updateList() {
    animController
      ..reset()
      ..forward();
  }

  void updateSearchOperation(RatesViewModel viewModel, String? p0) {
    setState(() {
      searchText = p0;
      searchRates = {};
      viewModel.rate.rates!.forEach((key, value) {
        if (searchText != null && (searchText?.isNotEmpty ?? false)) {
          if (key.contains(searchText!.toUpperCase())) {
            searchRates[key] = value;
          }
        }
      });

      updateList();
    });
  }
}
