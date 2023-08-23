import 'package:currency_converter/core/enums/currency_enum.dart';
import 'package:currency_converter/features/rates_convert/viewmodel/converter_view_model.dart';
import 'package:flutter/material.dart';

class ButtonConvert extends StatelessWidget {
  const ButtonConvert({
    required this.selectedItemFrom,
    required this.selectedItemTo,
    required this.converterViewModel,
    required this.bgColor,
    required this.icon,
    required this.labelText,
    required this.borderColor,
    super.key,
  });

  final CurrencyEnum selectedItemFrom;
  final CurrencyEnum selectedItemTo;
  final ConverterViewModel converterViewModel;
  final Color bgColor;
  final Icon icon;
  final Text labelText;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        converterViewModel.getConverterResult(selectedItemFrom.name, selectedItemTo.name);
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: borderColor)),
        backgroundColor: bgColor,
      ),
      icon: icon,
      label: labelText,
    );
  }
}
