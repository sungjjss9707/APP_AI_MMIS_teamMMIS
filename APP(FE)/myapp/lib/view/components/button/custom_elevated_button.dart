import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final funpageRoute; //익명함수를 받을거임
  final double? width;
  final primary;
  final textStyle;

  const CustomElevatedButton(
      {required this.text,
      this.funpageRoute,
      this.width,
      this.primary,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: primary,
        minimumSize: width != null ? Size(width!, 50) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: funpageRoute,
      child: Text(
        "$text",
        style: textStyle,
      ),
    );
  }
}
