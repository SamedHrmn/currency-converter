import 'package:currency_converter/core/constants/color_constants.dart';
import 'package:currency_converter/core/constants/string_constants.dart';
import 'package:currency_converter/core/services/network_status_service.dart';
import 'package:currency_converter/features/rates_convert/view/converter_view.dart';
import 'package:currency_converter/features/rates_search/view/rates_view.dart';
import 'package:currency_converter/shared/widget/app_scaffold.dart';
import 'package:currency_converter/shared/widget/app_text.dart';
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
    return AppScaffold(
      appBar: homeAppBar(),
      child: Stack(
        children: [
          Positioned.fill(
            child: backgroundGradient(),
          ),
          tabPages(),
        ],
      ),
    );
  }

  StreamProvider<NetworkStatus> tabPages() {
    return StreamProvider<NetworkStatus>(
      initialData: NetworkStatus.Online,
      create: (context) => NetworkStatusService().networkStatusController.stream,
      builder: (context, child) => TabBarView(
        controller: _tabController,
        children: const [
          ConverterPage(),
          RatesPage(),
        ],
      ),
    );
  }

  AppBar homeAppBar() {
    return AppBar(
      backgroundColor: ColorConstants.primaryColor,
      bottom: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(
            child: AppText(
              text: StringConstants.homeTabConverter,
            ),
          ),
          Tab(
            child: AppText(
              text: StringConstants.homeTabRates,
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
    );
  }

  DecoratedBox backgroundGradient() {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xfff0f5f6),
            ColorConstants.primaryColor,
          ],
        ),
      ),
    );
  }
}
