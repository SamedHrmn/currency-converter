import 'package:currency_converter/core/components/dropdown_currency_button.dart';
import 'package:currency_converter/core/enums/currency_enum.dart';
import 'package:currency_converter/features/rates_search/viewmodel/rates_view_model.dart';
import 'package:flutter/material.dart';

class SearchDialog extends StatefulWidget {
  final RatesViewModel viewModel;

  final CurrencyEnum initialItem;

  const SearchDialog(this.viewModel, {required this.initialItem, super.key});

  @override
  _SearchDialogState createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  CurrencyEnum selectedItem = CurrencyEnum.EUR;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initialItem;
  }

  void dropDownItemCallBack(CurrencyEnum? val) {
    if (val == null) return;
    setState(() {
      selectedItem = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 75),
      title: const Text('Select a currency base'),
      titlePadding: const EdgeInsets.all(20),
      content: DropdownCurrencyButton(
        currencyBase: widget.viewModel.currencyBase,
        onItemSelected: dropDownItemCallBack,
        initialValue: selectedItem,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      actions: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Colors.purple)),
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            widget.viewModel.getLatestCurrencyRates(selectedItem.name);
            Navigator.pop(context);
          },
          icon: const Icon(Icons.search),
          label: const Text('Search'),
        )
      ],
    );
  }
}
