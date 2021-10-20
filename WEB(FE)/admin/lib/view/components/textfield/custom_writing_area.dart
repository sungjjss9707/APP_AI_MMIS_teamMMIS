import 'package:flutter/material.dart';

class CustomWritingArea extends StatelessWidget {
  final String? hint;
  final funValidate;
  final controller;
  final enabled;
  final maxLines;

  const CustomWritingArea(
      {this.hint,
      required this.funValidate,
      this.controller,
      this.enabled,
      this.maxLines = 15});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        maxLines: maxLines,
        enabled: enabled,
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
          ),
        ),
      ),
    );
  }
}
