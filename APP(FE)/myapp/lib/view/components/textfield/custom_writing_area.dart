import 'package:flutter/material.dart';

class CustomWritingArea extends StatelessWidget {
  final String hint;
  final funValidate;

  final controller;

  const CustomWritingArea(
      {required this.hint, required this.funValidate, this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        maxLines: 10,
        controller: controller,
        validator: funValidate,
        decoration: InputDecoration(
            hintText: "Enter $hint",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            )),
      ),
    );
  }
}
