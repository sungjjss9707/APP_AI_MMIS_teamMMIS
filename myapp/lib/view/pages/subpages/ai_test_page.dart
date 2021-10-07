import 'package:flutter/material.dart';
import 'package:myapp/view/components/ai_menu_input_form.dart';
import 'package:myapp/view/components/appBar/sub_page_appbar.dart';
import 'package:myapp/view/components/button/custom_elevated_button.dart';
import 'package:myapp/view/components/custom_drawer.dart';

class AiTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: subPageAppBar("AI 실험실"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "급식이 1.0.0",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "급식이 1.0.0은 급식 관리자들이 메뉴를 구성할 때, 도와주는 인공지능 모델입니다. 식단을 입력하면, 부대원들에 대한 이 식단의 적합도와 대체 추천 식단을 구해 줍니다. 구성한 식단을 테스트해보세요.",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200]!),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Text(
                    "식단을 테스트해 보세요.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  AIMenuInputForm(),
                ],
              ),
            ),
            CustomElevatedButton(
              funpageRoute: () {},
              text: "입력 !",
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
