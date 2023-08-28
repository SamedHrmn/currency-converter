import 'package:currency_converter/core/components/base_text_field.dart';
import 'package:currency_converter/core/constants/string_constants.dart';
import 'package:flutter/material.dart';

class TextFieldAmount extends StatelessWidget {
  const TextFieldAmount({
    this.controller,
    this.outlineBorderColor,
    this.hintColor,
    super.key,
  });

  final TextEditingController? controller;
  final Color? outlineBorderColor;
  final Color? hintColor;

  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      controller: controller,
      hintStyle: TextStyle(color: hintColor),
      hintText: StringConstants.amountHintText,
      radius: 12,
      borderColor: outlineBorderColor,
    );
  }
}
