import 'package:currency_converter/core/components/rotator_widget.dart';
import 'package:currency_converter/shared/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  final colorTween = ColorTween(begin: Colors.purple, end: Colors.white);

  late final AnimationController transitionController;

  @override
  void initState() {
    super.initState();

    _initController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(
        const Duration(seconds: 1),
        () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(
            builder: (context) => const HomePage(),
          ),
          (Route<dynamic> route) => route is HomePage,
        ),
      );
    });
  }

  void _initController() {
    transitionController = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
  }

  @override
  void dispose() {
    transitionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: RotatorWidget(transitionController: transitionController, assetPath: 'assets/splash_screen/splash_screen_loading.gif'),
      ),
    );
  }
}
