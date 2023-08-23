import 'package:currency_converter/core/enums/currency_enum.dart';
import 'package:currency_converter/features/rates_search/widget/search_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:currency_converter/core/components/network_aware_widget.dart';
import 'package:currency_converter/core/services/network_status_service.dart';
import 'package:currency_converter/features/rates_convert/view/converter_view.dart';
import 'package:currency_converter/features/rates_search/view/rates_view.dart';
import 'package:currency_converter/features/rates_search/viewmodel/rates_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Consumer<RatesViewModel>(builder: (context, viewModel, _) {
        if (viewModel.state != RatesState.LoadedState) {
          return const SizedBox();
        }

        return FloatingActionButton(
          backgroundColor: Colors.purple[300],
          child: Icon(Icons.search),
          onPressed: () {
            _builderDialog(context, viewModel);
          },
        );
      }),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: <Color>[Colors.white, Colors.purple])),
        ),
        backgroundColor: Colors.purple.shade300,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                'Converter',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                'Rates',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
          onTap: (tabIndex) {
            switch (tabIndex) {
              case 0:
                print(tabIndex);
                break;
              case 1:
                print(tabIndex);
                break;
            }
          },
        ),
      ),
      body: StreamProvider<NetworkStatus>(
        initialData: NetworkStatus.Online,
        create: (context) => NetworkStatusService().networkStatusController.stream,
        child: NetworkAwareWidget(
          offlineChild: TabBarView(
            controller: _tabController,
            children: [
              ConverterPage(),
              const RatesPage(),
            ],
          ),
          onlineChild: TabBarView(
            controller: _tabController,
            children: [
              ConverterPage(),
              const RatesPage(),
            ],
          ),
        ),
      ),
    );
  }

  void _builderDialog(BuildContext context, RatesViewModel viewModel) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return SearchDialog(
          viewModel,
          initialItem: CurrencyEnum.EUR,
        );
      },
    );
  }
}
