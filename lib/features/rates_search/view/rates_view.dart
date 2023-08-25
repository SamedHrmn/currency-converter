import 'package:currency_converter/core/components/base_text_field.dart';
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
  String? searchText;
  Map<String, double> searchRates = {};
  late final AnimationController animController;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400), value: 1);
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  void updateList() {
    animController
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
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
                      hintText: 'Search',
                      keyboardType: TextInputType.text,
                      onChanged: (p0) {
                        setState(() {
                          searchText = p0;
                          searchRates = {};
                          viewModel.rate.rates!.forEach((key, value) {
                            if (searchText != null && (searchText?.isNotEmpty ?? false)) {
                              if (key.contains(searchText!.toUpperCase())) {
                                searchRates[key] = value;
                              }
                            }
                          });

                          updateList();
                        });
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
        ),
        Expanded(
          child: Consumer<RatesViewModel>(
            builder: (context, viewModel, _) {
              if (viewModel.state == RatesState.LoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
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
