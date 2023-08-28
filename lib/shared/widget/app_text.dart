import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText({super.key, required this.text, this.size, this.color});

  final String text;
  final double? size;
  final Color? color;

  factory AppText.error({required String text, double? size}) => AppText(
        text: text,
        size: size,
        color: Colors.red,
      );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color ?? Colors.black, fontSize: size),
    );
  }
}
