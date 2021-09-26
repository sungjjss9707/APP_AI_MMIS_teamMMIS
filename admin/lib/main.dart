import 'package:admin/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(Admin());
}

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "admin",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
