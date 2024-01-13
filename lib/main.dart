import 'package:currency_converter/core/init/locator.dart';
import 'package:currency_converter/features/rates_convert/viewmodel/converter_view_model.dart';
import 'package:currency_converter/features/rates_search/viewmodel/rates_view_model.dart';
import 'package:currency_converter/shared/home_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]),
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge),
    dotenv.load(),
  ]);
  setup();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<RatesViewModel>(create: (context) => RatesViewModel()),
        ChangeNotifierProvider<ConverterViewModel>(create: (context) => ConverterViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
