import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../ui/rates_convert/viewmodel/converter_view_model.dart';

class AnimatedResultText extends StatelessWidget {
  const AnimatedResultText({
    Key? key,
    required this.controller,
    required this.converterViewModel,
    required this.totalRepeat,
    required this.durationSec,
    required this.fontSize,
    required this.textColor,
  }) : super(key: key);

  final TextEditingController controller;
  final ConverterViewModel converterViewModel;
  final int totalRepeat;
  final int durationSec;
  final double fontSize;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    if (converterViewModel.state == ConverterState.LoadedState) {
      return Container(
        width: 100,
        height: 50,
        alignment: Alignment.center,
        child: AnimatedTextKit(
          totalRepeatCount: totalRepeat,
          animatedTexts: [
            WavyAnimatedText(
              (double.parse(converterViewModel.conventer.result.toString()) * (controller.text.isNotEmpty ? int.parse(controller.text) : 0)).toStringAsFixed(2),
              speed: Duration(seconds: durationSec),
              textStyle: TextStyle(color: textColor, fontSize: fontSize),
            ),
          ],
        ),
      );
    } else {
      return Text(
        'Result is..',
        style: TextStyle(fontSize: 16),
      );
    }
  }
}
