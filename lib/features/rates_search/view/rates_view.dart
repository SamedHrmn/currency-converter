import 'package:currency_converter/core/components/base_text_field.dart';
import 'package:currency_converter/core/components/rotator_widget.dart';
import 'package:currency_converter/features/rates_search/viewmodel/rates_view_model.dart';
import 'package:currency_converter/shared/widget/dropdown_currency_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RatesPage extends StatefulWidget {
  const RatesPage({super.key});

  @override
  _RatesPageState createState() => _RatesPageState();
}

class _RatesPageState extends State<RatesPage> with SingleTickerProviderStateMixin {
  late final AnimationController transitionController;

  @override
  void initState() {
    super.initState();
    transitionController = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
  }

  @override
  void dispose() {
    transitionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Expanded(
                child: BaseTextField(
                  hintText: 'Search',
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
        ),
        Expanded(
          child: Consumer<RatesViewModel>(
            builder: (context, viewModel, _) {
              if (viewModel.state == RatesState.LoadingState) {
                return RotatorWidget(
                  transitionController: transitionController,
                  assetPath: 'assets/splash_screen/splash_screen_loading.gif',
                );
              } else if (viewModel.state == RatesState.ErrorState) {
                return const Center(
                  child: Text('Error'),
                );
              }

              return rateslistBuilder(viewModel);
            },
          ),
        ),
      ],
    );
  }

  Widget rateslistBuilder(RatesViewModel viewModel) {
    return ListView.separated(
      itemCount: viewModel.rate.rates!.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        final key = viewModel.rate.rates!.keys.elementAt(index);
        return Column(
          children: [
            Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              child: ListTile(
                leading: Image.asset('assets/flags/$key.png'),
                title: Text(key),
                subtitle: viewModel.lastCurrencyBaseForRates != null ? Text('1 ${viewModel.lastCurrencyBaseForRates!.name} = ' '${viewModel.rate.rates![key]}') : null,
              ),
            ),
            const Divider(
              height: 2,
            ),
          ],
        );
      },
    );
  }
}
