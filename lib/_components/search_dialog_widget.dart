import 'package:flutter/material.dart';

import '../core/components/dropdown_currency_button.dart';
import '../ui/rates_search/viewmodel/rates_view_model.dart';

class SearchDialog extends StatefulWidget {
  final List<String> currencyBase;
  final RatesViewModel viewModel;

  SearchDialog(this.currencyBase, this.viewModel);

  @override
  _SearchDialogState createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  String selectedItem = 'EUR';

  @override
  void initState() {
    super.initState();
  }

  void dropDownItemCallBack(String? val) {
    if (val == null) return;
    setState(() {
      selectedItem = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 75),
      title: Text('Select a currency base'),
      titlePadding: EdgeInsets.all(20),
      content: DropdownCurrencyButton(
        currencyBase: widget.currencyBase,
        callback: dropDownItemCallBack,
        selectedVal: selectedItem,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      actions: [
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0), side: BorderSide(color: Colors.purple)),
              backgroundColor: Colors.white,
            ),
            onPressed: () {
              widget.viewModel.getLatestCurrencyRates(selectedItem);
              Navigator.pop(context);
            },
            icon: Icon(Icons.search),
            label: Text('Search'))
      ],
    );
  }
}
