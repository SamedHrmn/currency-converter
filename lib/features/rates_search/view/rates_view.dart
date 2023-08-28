import 'package:currency_converter/core/components/base_text_field.dart';
import 'package:currency_converter/core/constants/string_constants.dart';
import 'package:currency_converter/features/rates_search/view/rates_view_mixin.dart';
import 'package:currency_converter/features/rates_search/viewmodel/rates_view_model.dart';
import 'package:currency_converter/shared/widget/app_text.dart';
import 'package:currency_converter/shared/widget/dropdown_currency_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RatesPage extends StatefulWidget {
  const RatesPage({super.key});

  @override
  _RatesPageState createState() => _RatesPageState();
}

class _RatesPageState extends State<RatesPage> with SingleTickerProviderStateMixin, RatesViewMixin {
  @override
  void initState() {
    super.initState();
    animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400), value: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        searchFieldAndBaseCurrency(),
        ratesListBuilder(),
      ],
    );
  }

  Expanded ratesListBuilder() {
    return Expanded(
      child: Consumer<RatesViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.state == RatesState.LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (viewModel.state == RatesState.ErrorState) {
            return AppText.error(text: StringConstants.errorText);
          }

          return _RatesList(viewModel: viewModel, animController: animController, searchRates: searchRates);
        },
      ),
    );
  }

  Padding searchFieldAndBaseCurrency() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Consumer<RatesViewModel>(
              builder: (context, viewModel, _) {
                if (viewModel.state != RatesState.LoadedState) {
                  return const SizedBox();
                }

                return BaseTextField(
                  hintText: StringConstants.searchHintText,
                  keyboardType: TextInputType.text,
                  onChanged: (p0) {
                    updateSearchOperation(viewModel, p0);
                  },
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Consumer<RatesViewModel>(
            builder: (context, viewModel, _) {
              if (viewModel.state != RatesState.LoadedState) {
                return const SizedBox();
              }

              return DropdownCurrencyButton(
                currencyBase: viewModel.currencyBase,
                onItemSelected: (onItem) {
                  if (onItem == null) return;
                  viewModel.getLatestCurrencyRates(onItem.name);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _RatesList extends StatelessWidget {
  const _RatesList({required this.viewModel, required this.animController, required this.searchRates});

  final RatesViewModel viewModel;
  final AnimationController animController;
  final Map<String, double> searchRates;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animController,
      child: ListView.separated(
        itemCount: searchRates.isEmpty ? viewModel.rate.rates!.length : searchRates.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final key = searchRates.isEmpty ? viewModel.rate.rates!.keys.elementAt(index) : searchRates.keys.elementAt(index);
          return Column(
            children: [
              Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                child: ListTile(
                  leading: Image.asset('assets/flags/$key.png'),
                  title: Text(key),
                  subtitle: viewModel.lastCurrencyBaseForRates != null
                      ? Text('1 ${viewModel.lastCurrencyBaseForRates!.name} = ' '${searchRates.isEmpty ? viewModel.rate.rates![key] : searchRates[key]}')
                      : null,
                ),
              ),
              const Divider(
                height: 2,
              ),
            ],
          );
        },
      ),
    );
  }
}
