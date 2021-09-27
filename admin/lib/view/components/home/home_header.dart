import 'package:admin/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen[400],
      child: Center(
        child: InkWell(
          onTap: () {
            Get.to(() => HomePage());
          },
          child: Text(
            "MMIS",
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}
