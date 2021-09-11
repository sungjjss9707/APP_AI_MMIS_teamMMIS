import 'package:flutter/material.dart';

class YesEating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        "취식",
        style: TextStyle(color: Colors.white, fontSize: 9),
      ),
    );
  }
}
