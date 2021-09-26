import 'package:admin/style.dart';
import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String text;

  const CustomTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: h4(),
    );
  }
}
