import 'package:flutter/material.dart';

import '../../ui/rates_convert/viewmodel/converter_view_model.dart';

class ButtonConvert extends StatelessWidget {
  const ButtonConvert({
    Key? key,
    required this.selectedItemFrom,
    required this.selectedItemTo,
    required this.converterViewModel,
    required this.bgColor,
    required this.icon,
    required this.labelText,
    required this.borderColor,
  }) : super(key: key);

  final String selectedItemFrom;
  final String selectedItemTo;
  final ConverterViewModel converterViewModel;
  final Color bgColor;
  final Icon icon;
  final Text labelText;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {
          converterViewModel.getConverterResult(selectedItemFrom, selectedItemTo);
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0), side: BorderSide(color: borderColor)),
          backgroundColor: bgColor,
        ),
        icon: icon,
        label: labelText);
  }
}
