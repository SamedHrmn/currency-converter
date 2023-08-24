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
    super.key,
  });

  final CurrencyEnum selectedItemFrom;
  final CurrencyEnum selectedItemTo;
  final ConverterViewModel converterViewModel;
  final Color bgColor;
  final IconData icon;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        converterViewModel.getConverterResult(selectedItemFrom.name, selectedItemTo.name);
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: bgColor,
      ),
      icon: Icon(
        icon,
        color: Colors.black,
      ),
      label: Text(
        labelText,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
