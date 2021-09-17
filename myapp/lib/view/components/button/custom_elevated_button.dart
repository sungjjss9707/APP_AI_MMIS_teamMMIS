import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final funpageRoute; //익명함수를 받을거임
  final double width;

  const CustomElevatedButton(
      {required this.text, required this.funpageRoute, required this.width});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: funpageRoute,
      child: Text("$text"),
    );
  }
}
