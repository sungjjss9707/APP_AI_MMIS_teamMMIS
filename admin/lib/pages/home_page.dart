import 'package:admin/components/home/home_header.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          HomeHeader(),
        ],
      ),
    );
  }
}