import 'package:flutter/material.dart';

class RotatorWidget extends StatelessWidget {
  const RotatorWidget({
    required this.transitionController,
    required this.assetPath,
    super.key,
  });

  final AnimationController transitionController;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: transitionController,
      child: Image.asset(
        assetPath,
      ),
    );
  }
}
