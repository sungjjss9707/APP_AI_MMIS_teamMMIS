import 'package:admin/view/components/textfield/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../size.dart';

class TagAndTextFormField extends StatelessWidget {
  final String text;
  final controller;
  final funValidate;
  final obscureText;
  final hint;

  const TagAndTextFormField(
      {this.text = "",
      this.controller,
      this.funValidate,
      this.obscureText = false,
      this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$text",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: gap_xs),
        CustomTextFormField(
          obscureText: obscureText,
          hint: hint ?? "",
          enabledBorderSide: true,
          controller: controller,
          funValidate: funValidate,
        ),
        SizedBox(height: gap_xs),
      ],
    );
  }
}
