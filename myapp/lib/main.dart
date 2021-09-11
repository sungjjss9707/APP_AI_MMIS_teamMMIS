import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/mainpages/framepage.dart';

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
