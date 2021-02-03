import 'package:flutter/material.dart';

class RotatorWidget extends StatelessWidget {
  const RotatorWidget({
    Key key,
    @required this.transitionController,
    this.assetPath,
  }) : super(key: key);

  final AnimationController transitionController;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
        turns: transitionController,
        child: Image.asset(
          "assets/splash_screen/splash_screen_loading.gif",
        ));
  }
}
