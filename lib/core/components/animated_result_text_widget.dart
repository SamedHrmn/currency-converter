import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:currency_converter/ui/rates_convert/viewmodel/converter_view_model.dart';
import 'package:flutter/material.dart';

class AnimatedResultText extends StatelessWidget {
  const AnimatedResultText({
    Key key,
    @required this.controller,
    @required this.converterViewModel,
    @required this.totalRepeat,
    @required this.durationSec,
    @required this.fontSize,
    @required this.textColor,
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
        child: WavyAnimatedTextKit(
          totalRepeatCount: totalRepeat,
          speed: Duration(seconds: durationSec),
          text: [
            (double.parse(converterViewModel.conventer.result.toString()) *
                    (controller.text.isNotEmpty
                        ? int.parse(controller.text)
                        : 0))
                .toStringAsFixed(2)
          ],
          textStyle: TextStyle(color: textColor, fontSize: fontSize),
        ),
      );
    } else
      return Text(
        "Result is..",
        style: TextStyle(fontSize: 16),
      );
  }
}
