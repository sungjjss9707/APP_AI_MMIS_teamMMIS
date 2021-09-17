import 'package:flutter/material.dart';

class YesEating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.lightGreen[400],
        borderRadius: BorderRadius.circular(2),
      ),
      child: const Text(
        "취식",
        style: TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}
