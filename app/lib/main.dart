import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_mmis/pages/mainpages/framepage.dart';
import 'package:project_mmis/pages/mainpages/homepage.dart';
import 'package:project_mmis/pages/mainpages/login_page.dart';
import 'package:project_mmis/pages/subpages/notice_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(backgroundColor: Colors.white, appBarTheme: AppBarTheme()),
      home: FramePage(),
    );
  }
}
