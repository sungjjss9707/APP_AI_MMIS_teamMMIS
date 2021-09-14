import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/theme.dart';

import 'view/pages/initialpages/framepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: FramePage(),
    );
  }
}
