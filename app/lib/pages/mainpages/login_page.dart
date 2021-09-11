import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_mmis/components/custom_elevated_button.dart';
import 'package:project_mmis/components/custom_text_form_field.dart';
import 'package:project_mmis/pages/mainpages/framepage.dart';

import 'join_page.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          //아이디 비번 입력할떄 키보드가 올라와서 스크롤이 돼야함
          children: [
            Container(
              alignment: Alignment.center,
              height: 200,
              child: Text(
                "로그인",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _loginForm(), ////////////////////////밑에 만들어놈
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    //이름입력, 군번입력, 로그인 버튼, 회원가입 버튼 네개로 이루어짐
    return Form(
      key: _formKey,
      //한번에 서버로 날릴거라 이 네개를 폼으로 묶는게 좋음
      child: Column(
        children: [
          CustomTextFormField(
            hint: "이름",
          ),
          CustomTextFormField(
            hint: "군번",
          ),
          SizedBox(height: 10),
          CustomElevatedButton(
            text: "로그인",
            funpageRoute: () {
              if (true) {
                ////////////////////////////////////////////////일단 true로 넣었는데 로그인 성공할때만 if문 통과해야함
                Get.to(FramePage());
              }
            },
          ),
          SizedBox(height: 10),
          CustomElevatedButton(
            text: "회원가입",
            funpageRoute: () {
              Get.to(JoinPage()); //회원가입페이지로 이동
            },
          ),
        ],
      ),
    );
  }
}
