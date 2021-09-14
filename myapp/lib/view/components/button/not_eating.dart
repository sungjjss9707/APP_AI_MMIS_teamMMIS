import 'package:flutter/material.dart';

class NotEating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.blue[400],
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        "불취식",
        style: TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}
