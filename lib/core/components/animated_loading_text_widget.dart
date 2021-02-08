import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedLoadingTextWidget extends StatelessWidget {
  const AnimatedLoadingTextWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linearGradient = LinearGradient(
      colors: <Color>[Colors.white, Colors.purple],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Container(
      width: 150,
      height: 100,
      alignment: Alignment.center,
      child: WavyAnimatedTextKit(
        text: ['Loading'],
        textStyle: TextStyle(foreground: Paint()..shader = linearGradient, fontSize: 32, fontWeight: FontWeight.w400),
        isRepeatingAnimation: true,
      ),
    );
  }
}
