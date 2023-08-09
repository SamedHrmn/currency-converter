import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/components/animated_result_text_widget.dart';
import '../../../core/components/button_widget.dart';
import '../../../core/components/dropdown_currency_button.dart';
import '../../../core/components/rotator_widget.dart';
import '../../../core/components/textfield_widget.dart';
import '../../rates_search/viewmodel/rates_view_model.dart';
import '../viewmodel/converter_view_model.dart';

class ConverterPage extends StatefulWidget {
  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> with SingleTickerProviderStateMixin {
  List<String> currencyBase = [];
  Map<String, double> rates = {};
  String selectedItemFrom = 'EUR';
  String selectedItemTo = 'TRY';
  String resultConverted = '0';
  late final TextEditingController controller;
  late final AnimationController transitionController;
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.red, Colors.purple],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  void initState() {
    super.initState();
    currencyBase = [];
    controller = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RatesViewModel>(context, listen: false).getLatestCurrencyRates('EUR');
    });

    transitionController = AnimationController(vsync: this, duration: Duration(seconds: 3))..repeat();
  }

  @override
  void dispose() {
    transitionController.dispose();
    super.dispose();
  }

  void dropDownLeftItemCallBack(String? val) {
    if (val == null) return;
    setState(() {
      selectedItemFrom = val;
    });
  }

  void dropDownRightItemCallBack(String? val) {
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
      return RotatorWidget(transitionController: transitionController);
    } else if (viewModel.state == RatesState.LoadedState) {
      rates = viewModel.rate.rates ?? {};
      rates.forEach((key, value) => currencyBase.add(key));
      currencyBase = currencyBase.toSet().toList();

      return Consumer<ConverterViewModel>(
        builder: (context, converterViewModel, child) {
          if (converterViewModel.state == ConverterState.LoadingState) {
            return RotatorWidget(transitionController: transitionController);
          }
          if (converterViewModel.state == ConverterState.ErrorState) {
            return RotatorWidget(transitionController: transitionController);
          }

          return Container(
            child: Column(
              children: [
                SizedBox(height: 20),
                buildDropDownButtons(selectedItemFrom, selectedItemTo, dropDownLeftItemCallBack, dropDownRightItemCallBack),
                TextFieldAmount(controller: controller, outlineBorderColor: Colors.purple, hintColor: Colors.grey, labelColor: Colors.purple),
                AnimatedResultText(controller: controller, converterViewModel: converterViewModel, totalRepeat: 10, durationSec: 3, fontSize: 22, textColor: Colors.black),
                SizedBox(
                  height: 20,
                ),
                ButtonConvert(
                    selectedItemFrom: selectedItemFrom,
                    selectedItemTo: selectedItemTo,
                    converterViewModel: converterViewModel,
                    bgColor: Colors.white,
                    icon: Icon(Icons.repeat),
                    labelText: Text('Convert'),
                    borderColor: Colors.purple),
                Expanded(
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Developed by Samed Harman',
                          style: TextStyle(fontSize: 12, foreground: Paint()..shader = linearGradient),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          DateFormat.yMMMEd('en_US').format(viewModel.rate.date!),
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          );
        },
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildDropDownButtons(String selectedItemFrom, String selectedItemTo, Function(String? item)? dropDownLeftItemCallBack, Function(String? item) dropDownRightItemCallBack) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DropdownCurrencyButton(
          currencyBase: currencyBase,
          callback: dropDownLeftItemCallBack,
          selectedVal: selectedItemFrom,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        DropdownCurrencyButton(currencyBase: currencyBase, callback: dropDownRightItemCallBack, selectedVal: selectedItemTo, mainAxisAlignment: MainAxisAlignment.spaceEvenly),
      ],
    );
  }
}
