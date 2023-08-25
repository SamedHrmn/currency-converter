import 'package:currency_converter/core/enums/currency_enum.dart';
import 'package:currency_converter/features/rates_convert/viewmodel/converter_view_model.dart';
import 'package:currency_converter/features/rates_convert/widget/amount_text_field.dart';
import 'package:currency_converter/features/rates_convert/widget/convert_button.dart';
import 'package:currency_converter/features/rates_search/viewmodel/rates_view_model.dart';
import 'package:currency_converter/shared/widget/dropdown_currency_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  CurrencyEnum selectedItemFrom = CurrencyEnum.EUR;
  CurrencyEnum selectedItemTo = CurrencyEnum.TRY;
  String resultConverted = '0';
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RatesViewModel>().getLatestCurrencyRates('EUR');
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

  void resultConvertedCallBack(String? val) {
    if (val == null) return;
    setState(() {
      resultConverted = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RatesViewModel>(context);

    if (viewModel.state == RatesState.LoadingState || viewModel.state == RatesState.ErrorState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (viewModel.state == RatesState.LoadedState) {
      return Consumer<ConverterViewModel>(
        builder: (context, converterViewModel, child) {
          if (converterViewModel.state == ConverterState.LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (converterViewModel.state == ConverterState.ErrorState) {
            return const Center(
              child: Text('Error'),
            );
          }

          double? converted;
          if (converterViewModel.convertModel?.result != null) {
            converted = double.parse(converterViewModel.convertModel!.result.toString());
          }

          return Column(
            children: [
              const SizedBox(height: 32),
              buildDropDownButtons(viewModel),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: TextFieldAmount(
                  controller: controller,
                  outlineBorderColor: Colors.purple,
                  hintColor: Colors.grey,
                ),
              ),
              if (converted != null) ...{
                Text(
                  (converted * (controller.text.isNotEmpty ? int.parse(controller.text) : 0)).toStringAsFixed(2),
                  style: const TextStyle(color: Colors.black),
                ),
              },
              const SizedBox(
                height: 20,
              ),
              ButtonConvert(
                selectedItemFrom: selectedItemFrom,
                selectedItemTo: selectedItemTo,
                converterViewModel: converterViewModel,
                bgColor: Colors.white,
                icon: Icons.repeat,
                labelText: 'Convert',
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    DateFormat.yMMMEd('en_US').format(viewModel.rate.date!),
                    style: const TextStyle(fontSize: 13, color: Colors.black),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildDropDownButtons(RatesViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DropdownCurrencyButton(
          currencyBase: viewModel.currencyBase,
          onItemSelected: dropDownLeftItemCallBack,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          initialValue: CurrencyEnum.EUR,
        ),
        DropdownCurrencyButton(
          currencyBase: viewModel.currencyBase,
          onItemSelected: dropDownRightItemCallBack,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          initialValue: CurrencyEnum.TRY,
        ),
      ],
    );
  }
}
