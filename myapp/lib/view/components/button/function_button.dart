import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FunctionButton extends StatefulWidget {
  final IconData icon;
  final String text;
  final onTap;

  const FunctionButton({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  _FunctionButtonState createState() =>
      _FunctionButtonState(icon: icon, text: text, onTap: onTap);
}

class _FunctionButtonState extends State<FunctionButton> {
  final IconData icon;
  final String text;
  final onTap;

  _FunctionButtonState({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: (1.sw - 32.w) / 3,
        height: (1.sw - 32.w) / 3,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black38,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: (1.sw - 32.w) / 12),
            SizedBox(height: 5.w),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
