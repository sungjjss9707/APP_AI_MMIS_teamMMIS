import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myapp/view/pages/initialpages/framepage.dart';

AppBar subPageAppBar(String title) {
  return AppBar(
    title: Text(
      "$title",
      style: TextStyle(fontSize: 14.sp),
    ),
    actions: [
      IconButton(
        onPressed: () {
          Get.offAll(() => FramePage());
        },
        icon: Icon(Icons.home_outlined),
      ),
      SizedBox(width: 4.w),
    ],
  );
}
