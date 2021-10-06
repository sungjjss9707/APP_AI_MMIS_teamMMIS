import 'package:admin/controller/ai_controller.dart';
import 'package:admin/size.dart';
import 'package:admin/style.dart';
import 'package:admin/view/components/home/customTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// AI 이용 페이지
class AIPage extends StatelessWidget {
  final AIController ai = Get.put(AIController());
  final a1 = TextEditingController();
  final a2 = TextEditingController();
  final a3 = TextEditingController();
  final a4 = TextEditingController();
  final a5 = TextEditingController();
  final a6 = TextEditingController();
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
        Container(
          width: 400,
          height: 400,
          child: Column(
            children: [
              TextFormField(
                controller: a1,
              ),
              TextFormField(
                controller: a2,
              ),
              TextFormField(
                controller: a3,
              ),
              TextFormField(
                controller: a4,
              ),
              TextFormField(
                controller: a5,
              ),
              TextFormField(
                controller: a6,
              ),
              TextButton(
                  onPressed: () async {
                    Map data = {
                      "rice": a1.text,
                      "mainDish": a2.text,
                      "soup": a3.text,
                      "serveDish": a4.text,
                      "vegetable": a5.text,
                      "dessert": a6.text,
                    };
                    print(data);
                    await ai.getRecommendedMenus(data);
                    print("end");
                  },
                  child: Text("보내기"))
            ],
          ),
        ),
      ],
    );
  }
}
