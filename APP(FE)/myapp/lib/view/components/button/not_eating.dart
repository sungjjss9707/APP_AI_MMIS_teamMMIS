import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotEating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        "불취식",
        style: TextStyle(color: Colors.white, fontSize: 10.sp),
      ),
    );
  }
}
