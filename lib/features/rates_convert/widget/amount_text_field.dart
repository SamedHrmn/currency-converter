import 'package:currency_converter/core/components/base_text_field.dart';
import 'package:flutter/material.dart';

class TextFieldAmount extends StatelessWidget {
  const TextFieldAmount({
    required this.controller,
    required this.outlineBorderColor,
    required this.hintColor,
    super.key,
  });

  final TextEditingController controller;
  final Color outlineBorderColor;
  final Color hintColor;

  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      controller: controller,
      hintStyle: TextStyle(color: hintColor),
      labelText: 'Amount',
      hintText: 'Please enter amount.. e.g: 20',
      radius: 12,
      borderColor: outlineBorderColor,
    );
  }
}
