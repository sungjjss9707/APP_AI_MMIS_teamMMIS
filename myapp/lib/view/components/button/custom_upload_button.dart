import 'package:flutter/material.dart';

class CustomUploadButom extends StatelessWidget {
  final String text;
  final onPressed;

  const CustomUploadButom({required this.text, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
