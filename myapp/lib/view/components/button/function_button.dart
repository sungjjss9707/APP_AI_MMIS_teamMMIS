import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FunctionButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final onTap;
  final double length;

  const FunctionButton(
      {required this.icon,
      required this.text,
      required this.onTap,
      required this.length});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: length,
        height: length,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black38,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(height: 5),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
