import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final String text;

  const CustomBackButton({required this.text});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(text),
    );
  }
}
