import 'package:flutter/material.dart';

import '../../../size.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final onPressed; //익명함수를 받을거임
  final double? width;
  final Color? color;
  final textSize;

  const CustomElevatedButton(
      {required this.text,
      this.onPressed,
      this.width,
      this.color,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: width != null ? Size(width!, 50) : null,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(5),
        // ),
      ),
      onPressed: onPressed,
      child: Text(
        "$text",
        style: TextStyle(fontSize: textSize ?? 16),
      ),
    );
  }
}
