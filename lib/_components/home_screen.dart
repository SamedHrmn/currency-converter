import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/components/network_aware_widget.dart';
import '../core/services/network_status_service.dart';
import '../ui/rates_convert/view/converter_view.dart';
import '../ui/rates_search/view/rates_view.dart';
import '../ui/rates_search/viewmodel/rates_view_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  Map<String, double> rates = {};
  List<String> currencyBase = [];

  var subscription;
  var connectionStatus;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    currencyBase = [];
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RatesViewModel>(context);
    //final networkModel = Provider.of<NetworkStatus>(context);

    if (viewModel.state == RatesState.LoadedState) {
      rates = viewModel.rate.rates ?? {};
      rates.forEach((key, value) => currencyBase.add(key));
      currencyBase = currencyBase.toSet().toList();
    }

    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                RatesPage(
                  viewModel: viewModel,
                  currencyBase: currencyBase,
                ),
              ],
            ),
            onlineChild: TabBarView(
              controller: _tabController,
              children: [
                ConverterPage(),
                RatesPage(
                  viewModel: viewModel,
                  currencyBase: currencyBase,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
