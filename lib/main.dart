import 'package:currency_converter/_components/splash_screen.dart';
import 'package:currency_converter/core/init/locator.dart';
import 'package:currency_converter/ui/rates_convert/viewmodel/converter_view_model.dart';
import 'package:currency_converter/ui/rates_search/viewmodel/rates_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

  setup();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<RatesViewModel>(
          create: (context) => RatesViewModel()),
      ChangeNotifierProvider<ConverterViewModel>(
          create: (context) => ConverterViewModel()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: SplashScreen(RatesViewModel()),
      debugShowCheckedModeBanner: false,
    );
  }
}
