import 'package:currency_converter/core/components/rotator_widget.dart';
import 'package:currency_converter/features/rates_search/viewmodel/rates_view_model.dart';
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
    return Consumer<RatesViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.state == RatesState.LoadingState) {
          return RotatorWidget(transitionController: transitionController);
        } else if (viewModel.state == RatesState.ErrorState) {
          return const Center(
            child: Text('Error'),
          );
        }

        return rateslistBuilder(viewModel);
      },
    );
  }

  Widget rateslistBuilder(RatesViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.rate.rates!.length,
      itemBuilder: (context, index) {
        final key = viewModel.rate.rates!.keys.elementAt(index);
        return Column(
          children: [
            ListTile(
              leading: Image.asset('assets/flags/$key.png'),
              title: Text(key),
              subtitle: Text('${viewModel.rate.rates![key]}'),
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
