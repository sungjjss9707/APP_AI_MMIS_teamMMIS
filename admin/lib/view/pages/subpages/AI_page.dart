import 'package:admin/size.dart';
import 'package:admin/style.dart';
import 'package:admin/view/components/home/customTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// AI 이용 페이지
class AIPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitle("AI 실험실"),
        Divider(color: Colors.grey),
        Text(
          "급식이 1.0.0",
          style: h5(),
        ),
        SizedBox(height: gap_s),
        Text("급식이 1.0.0은 급식 관리자들이 메뉴를 구성할 때, 도와주는 인공지능 모델입니다."),
      ],
    );
  }
}
