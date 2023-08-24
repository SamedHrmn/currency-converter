import 'package:currency_converter/core/services/network_status_service.dart';
import 'package:currency_converter/features/rates_convert/view/converter_view.dart';
import 'package:currency_converter/features/rates_search/view/rates_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(
        backgroundColor: Color.fromARGB(249, 246, 246, 246),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
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
                break;
              case 1:
                break;
            }
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xfff0f5f6),
                Color(0xfff6f6f6),
              ],
            ))),
          ),
          StreamProvider<NetworkStatus>(
            initialData: NetworkStatus.Online,
            create: (context) => NetworkStatusService().networkStatusController.stream,
            builder: (context, child) => TabBarView(
              controller: _tabController,
              children: const [
                ConverterPage(),
                RatesPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
