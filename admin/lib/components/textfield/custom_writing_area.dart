import 'package:flutter/material.dart';

class CustomWritingArea extends StatelessWidget {
  final String? hint;
  final funValidate;
  final String? value;
  final controller;

  const CustomWritingArea(
      {this.hint, required this.funValidate, this.value, this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        maxLines: 15,
        initialValue: value,
        validator: funValidate,
        controller: controller,
        decoration: InputDecoration(
            hintText: "Enter $hint",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            )),
      ),
    );
  }
}
