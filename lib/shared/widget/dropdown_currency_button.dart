import 'package:currency_converter/core/enums/currency_enum.dart';
import 'package:currency_converter/shared/widget/app_text.dart';
import 'package:flutter/material.dart';

class DropdownCurrencyButton extends StatefulWidget {
  const DropdownCurrencyButton({
    required this.currencyBase,
    this.initialValue,
    super.key,
    this.onItemSelected,
    this.mainAxisAlignment,
  });

  final List<CurrencyEnum> currencyBase;
  final MainAxisAlignment? mainAxisAlignment;
  final void Function(CurrencyEnum? onItem)? onItemSelected;
  final CurrencyEnum? initialValue;

  @override
  State<DropdownCurrencyButton> createState() => _DropdownCurrencyButtonState();
}

class _DropdownCurrencyButtonState extends State<DropdownCurrencyButton> {
  CurrencyEnum? selectedValue;

  void updateSelectedValue(CurrencyEnum? v) {
    setState(() {
      selectedValue = v;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue ?? CurrencyEnum.EUR;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<CurrencyEnum>(
          dropdownColor: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          items: widget.currencyBase.map((currency) {
            return DropdownMenuItem<CurrencyEnum>(
              value: currency,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 45,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/flags/${currency.name}.png'), fit: BoxFit.contain)),
                        ),
                        AppText(text: currency.name)
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (item) {
            widget.onItemSelected?.call(item);
            updateSelectedValue(item);
          },
          value: selectedValue,
        ),
      ),
    );
  }
}
