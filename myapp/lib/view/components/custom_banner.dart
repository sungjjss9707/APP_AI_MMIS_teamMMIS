import 'package:flutter/material.dart';

class CustomBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black26),
          ),
          child: Text(" [공지]21 - 3차 병사 브런치 데이 메뉴 조사 "),
        ),
      ),
    );
  }
}
