import 'package:currency_converter/core/enums/currency_enum.dart';
import 'package:flutter/material.dart';

class DropdownCurrencyButton extends StatefulWidget {
  const DropdownCurrencyButton({
    required this.currencyBase,
    required this.initialValue,
    super.key,
    this.onItemSelected,
    this.mainAxisAlignment,
  });

  final List<CurrencyEnum> currencyBase;
  final MainAxisAlignment? mainAxisAlignment;
  final void Function(CurrencyEnum? onItem)? onItemSelected;
  final CurrencyEnum initialValue;

  @override
  State<DropdownCurrencyButton> createState() => _DropdownCurrencyButtonState();
}

class _DropdownCurrencyButtonState extends State<DropdownCurrencyButton> {
  CurrencyEnum? selectedValue;

  void updateSelectedValue(CurrencyEnum v) {
    setState(() {
      selectedValue = v;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<CurrencyEnum>(
        dropdownColor: Colors.grey[200],
        items: widget.currencyBase.map((currency) {
          return DropdownMenuItem<CurrencyEnum>(
            value: currency,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/flags/${currency.name}.png'), fit: BoxFit.contain)),
                ),
                Text(currency.name)
              ],
            ),
          );
        }).toList(),
        onChanged: (item) {
          widget.onItemSelected?.call(item);
        },
        value: selectedValue,
      ),
    );
  }
}
