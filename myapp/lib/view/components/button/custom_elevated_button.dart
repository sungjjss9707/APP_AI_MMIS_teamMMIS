import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final funpageRoute; //익명함수를 받을거임
  final double? width;

  const CustomElevatedButton(
      {required this.text, this.funpageRoute, this.width});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: width != null ? Size(width!, 50) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: funpageRoute,
      child: Text("$text"),
    );
  }
}
