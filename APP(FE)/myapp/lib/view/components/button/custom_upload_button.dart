import 'package:flutter/material.dart';

class CustomUploadButton extends StatelessWidget {
  final String text;
  final onPressed;

  const CustomUploadButton({required this.text, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
