import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hint;
  final String? value;
  final funValidate;
  final controller;
  //final String type;

  CustomTextFormField({
    this.hint,
    this.value,
    this.funValidate,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: TextFormField(
        controller: controller,
        initialValue: value ?? null, //널이면 빈칸 넣으란 말임
        validator: funValidate,
        decoration: InputDecoration(
          hintText: "$hint", //이렇게 넣는게 더 좋음 걍 힌트 하지말고
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
    );
  }
}
