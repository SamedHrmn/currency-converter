import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  const BaseTextField({
    super.key,
    this.controller,
    this.labelStyle,
    this.hintStyle,
    this.labelText,
    this.hintText,
    this.radius,
    this.borderColor,
  });

  final TextEditingController? controller;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final String? labelText;
  final String? hintText;
  final double? radius;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelStyle: labelStyle,
        hintStyle: hintStyle,
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: borderColor != null ? BorderSide(color: borderColor!) : BorderSide.none,
          borderRadius: BorderRadius.circular(radius ?? 4),
        ),
      ),
    );
  }
}
