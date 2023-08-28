import 'package:currency_converter/core/constants/color_constants.dart';
import 'package:currency_converter/core/constants/string_constants.dart';
import 'package:currency_converter/core/enums/currency_enum.dart';
import 'package:currency_converter/features/rates_convert/view/converter_view_mixin.dart';
import 'package:currency_converter/features/rates_convert/viewmodel/converter_view_model.dart';
import 'package:currency_converter/features/rates_convert/widget/amount_text_field.dart';
import 'package:currency_converter/features/rates_convert/widget/convert_button.dart';
import 'package:currency_converter/features/rates_search/viewmodel/rates_view_model.dart';
import 'package:currency_converter/shared/widget/app_loading_indicator.dart';
import 'package:currency_converter/shared/widget/app_text.dart';
import 'package:currency_converter/shared/widget/dropdown_currency_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> with ConverterViewMixin {
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
            return const AppLoadingIndicator();
          }
          if (converterViewModel.state == ConverterState.ErrorState) {
            return AppText.error(text: StringConstants.errorText);
          }

          double? converted;
          if (converterViewModel.convertModel?.result != null) {
            converted = double.parse(converterViewModel.convertModel!.result.toString());
          }

          return Column(
            children: [
              _ConverterCard(
                ratesViewModel: viewModel,
                controller: controller,
                converted: converted,
                leftItemCallback: dropDownLeftItemCallBack,
                rightItemCallback: dropDownRightItemCallBack,
              ),
              convertButton(converterViewModel),
              rateDateText(viewModel),
            ],
          );
        },
      );
    } else {
      return const SizedBox();
    }
  }

  Padding rateDateText(RatesViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: AppText(
        text: DateFormat.yMMMEd('en_US').format(viewModel.rate.date!),
        size: 13,
      ),
    );
  }

  SizedBox convertButton(ConverterViewModel converterViewModel) {
    return SizedBox(
      height: 56,
      width: 200,
      child: ButtonConvert(
        selectedItemFrom: selectedItemFrom,
        selectedItemTo: selectedItemTo,
        converterViewModel: converterViewModel,
        bgColor: Colors.white,
        icon: Icons.repeat,
        labelText: StringConstants.convertButtonText,
      ),
    );
  }
}

class _ConverterCard extends StatelessWidget {
  const _ConverterCard({
    required this.ratesViewModel,
    required this.controller,
    required this.leftItemCallback,
    required this.rightItemCallback,
    this.converted,
  });

  final RatesViewModel ratesViewModel;
  final double? converted;
  final void Function(CurrencyEnum?)? leftItemCallback;
  final void Function(CurrencyEnum?)? rightItemCallback;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownCurrencyButton(
                currencyBase: ratesViewModel.currencyBase,
                onItemSelected: leftItemCallback,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                initialValue: CurrencyEnum.EUR,
              ),
              DropdownCurrencyButton(
                currencyBase: ratesViewModel.currencyBase,
                onItemSelected: rightItemCallback,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                initialValue: CurrencyEnum.TRY,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: TextFieldAmount(
              controller: controller,
              outlineBorderColor: ColorConstants.primaryColor,
              hintColor: ColorConstants.secondaryColor,
            ),
          ),
          if (converted != null) ...{
            AppText(
              text: (converted! * (controller.text.isNotEmpty ? int.parse(controller.text) : 0)).toStringAsFixed(2),
              size: 24,
            ),
          },
        ],
      ),
    );
  }
}
