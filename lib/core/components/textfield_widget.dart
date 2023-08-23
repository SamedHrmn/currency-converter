import 'package:flutter/material.dart';

class TextFieldAmount extends StatelessWidget {
  const TextFieldAmount({
    Key? key,
    required this.controller,
    required this.outlineBorderColor,
    required this.hintColor,
    required this.labelColor,
  }) : super(key: key);

  final TextEditingController controller;
  final Color outlineBorderColor;
  final Color hintColor;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: 250,
      height: 100,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelStyle: TextStyle(color: labelColor),
            hintStyle: TextStyle(color: hintColor),
            labelText: 'Amount',
            hintText: 'Please enter amount.. e.g: 20',
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: outlineBorderColor), borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}
