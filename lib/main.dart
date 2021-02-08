import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '_components/splash_screen.dart';
import 'core/init/locator.dart';
import 'ui/rates_convert/viewmodel/converter_view_model.dart';
import 'ui/rates_search/viewmodel/rates_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  setup();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<RatesViewModel>(create: (context) => RatesViewModel()),
      ChangeNotifierProvider<ConverterViewModel>(create: (context) => ConverterViewModel()),
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
