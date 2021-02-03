import 'package:currency_converter/core/components/animated_loading_text_widget.dart';
import 'package:currency_converter/core/components/rotator_widget.dart';
import 'package:currency_converter/ui/rates_search/viewmodel/rates_view_model.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/_components/home_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen(RatesViewModel viewModel);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final colorTween = ColorTween(begin: Colors.purple, end: Colors.white);
  AnimationController backgroundController;
  AnimationController transitionController;
  Animation<Color> animation;

  @override
  void initState() {
    super.initState();

    _initController();
    _router(seconds: 3);
  }

  void _initController() {
    backgroundController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = colorTween.animate(backgroundController)
      ..addListener(() {
        setState(() {});
      });
    backgroundController.forward();

    transitionController =
        AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..repeat();
  }

  void _router({int seconds}) {
    Future.delayed(Duration(seconds: seconds)).then((value) =>
        Navigator.pushAndRemoveUntil(context, _createRoute(),
            (Route<dynamic> route) => route is HomePage));
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.ease));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    transitionController.dispose();
    backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: animation.value,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotatorWidget(
              transitionController: transitionController,
              assetPath: "assets/splash_screen/splash_screen_loading.gif"),
          AnimatedLoadingTextWidget(),
        ],
      ),
    );
  }
}
