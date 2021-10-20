import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YesEating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.lightGreen[400],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        "취식",
        style: TextStyle(color: Colors.white, fontSize: 10.sp),
      ),
    );
  }
}
