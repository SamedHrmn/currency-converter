import 'package:currency_converter/ui/rates_convert/viewmodel/converter_view_model.dart';
import 'package:flutter/material.dart';

class ButtonConvert extends StatelessWidget {
  const ButtonConvert({
    Key key,
    @required this.selectedItemFrom,
    @required this.selectedItemTo,
    @required this.converterViewModel,
    @required this.bgColor,
    @required this.icon,
    @required this.labelText,
    @required this.borderColor,
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
    return RaisedButton.icon(
        color: bgColor,
        onPressed: () {
          converterViewModel.getConverterResult(
              selectedItemFrom, selectedItemTo);
        },
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(12.0),
            side: BorderSide(color: borderColor)),
        icon: icon,
        label: labelText);
  }
}
