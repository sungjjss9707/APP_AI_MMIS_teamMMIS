import 'package:flutter/material.dart';

class UserInfoTextFormField extends StatelessWidget {
  String text;
  String? info;
  bool enabled;
  int n;
  final validator;
  TextEditingController? controller;
  UserInfoTextFormField({
    required this.text,
    this.info,
    required this.enabled,
    this.n = 10,
    this.controller,
    required this.validator,
  });
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(height: 10),
        TextFormField(
          validator: validator,
          enabled: enabled,
          controller: controller,
          decoration: InputDecoration(
            hintText: enabled == true ? "" : info,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.black54,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.black54,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.black54,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.black54,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.black54,
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
