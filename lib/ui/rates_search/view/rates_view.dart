import 'package:flutter/material.dart';

import '../../../_components/search_dialog_widget.dart';
import '../../../core/components/rotator_widget.dart';
import '../viewmodel/rates_view_model.dart';

class RatesPage extends StatefulWidget {
  final RatesViewModel viewModel;
  final List<String> currencyBase;

  RatesPage({this.currencyBase, this.viewModel});

  @override
  _RatesPageState createState() => _RatesPageState();
}

class _RatesPageState extends State<RatesPage> with SingleTickerProviderStateMixin {
  AnimationController transitionController;

  @override
  void initState() {
    super.initState();
    transitionController = AnimationController(vsync: this, duration: Duration(seconds: 3))..repeat();
  }

  @override
  void dispose() {
    transitionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.viewModel.state == RatesState.LoadingState
        ? RotatorWidget(transitionController: transitionController)
        : (widget.viewModel.state == RatesState.LoadedState)
            ? Scaffold(
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.purple[300],
                  child: Icon(Icons.search),
                  onPressed: () {
                    _builderDialog(context, widget.viewModel, widget.currencyBase);
                  },
                ),
                body: rateslistBuilder(widget.viewModel),
              )
            : Center(child: Text('Error')));
  }

  Widget rateslistBuilder(RatesViewModel viewModel) {
    return ListView.builder(
        itemCount: viewModel.rate.rates.length,
        itemBuilder: (context, index) {
          var key = viewModel.rate.rates.keys.elementAt(index);
          return Column(children: [
            ListTile(
              leading: Image.asset('assets/flags/' + key + '.png'),
              title: Text('$key'),
              subtitle: Text('${viewModel.rate.rates[key]}'),
            ),
            Divider(
              height: 2.0,
            ),
          ]);
        });
  }

  void _builderDialog(BuildContext context, RatesViewModel viewModel, List<String> currencyBase) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return SearchDialog(currencyBase, viewModel);
      },
    );
  }
}
