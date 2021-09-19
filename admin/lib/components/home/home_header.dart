import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen[400],
      child: Center(
        child: Text(
          "MMIS",
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
