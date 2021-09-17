import 'package:flutter/material.dart';

class UserInfoTextFormField extends StatelessWidget {
  String text;
  String? info;
  bool enabled;
  int n;
  TextEditingController? controller;
  UserInfoTextFormField(
      {required this.text,
      this.info,
      required this.enabled,
      this.n = 10,
      this.controller});
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
          validator: (value) {
            if (value!.isEmpty) {
              return "공백으로 둘 수 없습니다.";
            } else if (value.length > n) {
              return "입력된 글자가 너무 많습니다.";
            }
          },
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
