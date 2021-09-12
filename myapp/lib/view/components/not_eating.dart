import 'package:flutter/material.dart';

class NotEating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        "불취식",
        style: TextStyle(color: Colors.white, fontSize: 9),
      ),
    );
  }
}
