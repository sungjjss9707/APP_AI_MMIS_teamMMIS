import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/view/components/custom_elevated_button.dart';
import 'package:myapp/view/components/custom_text_form_field.dart';

import 'login_page.dart';

class JoinPage extends StatelessWidget {
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
                "회원가입",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _joinForm(), ////////////////////////
          ],
        ),
      ),
    );
  }

  Widget _joinForm() {
    //이름쓰는칸, 군번쓰는칸, 계급쓰는칸, 회원가입버튼 네개로 이루어짐
    return Form(
      //한번에 서버로 날릴거라 이 네개를 폼으로 묶는게 좋음
      child: Column(
        children: [
          CustomTextFormField(
            hint: "이름",
            funValidate: null,
          ),
          CustomTextFormField(
            hint: "군번",
            funValidate: null,
          ),
          CustomTextFormField(
            hint: "계급",
            funValidate: null,
          ),
          SizedBox(height: 10),
          CustomElevatedButton(
            text: "회원가입",
            funpageRoute: () {
              if (true) {
                ////////////////////////////////////////일단은 true로 넣었는데 회원가입가능한
                // 올바른 군번과 이름을 넣어야지 서버로 값들을
                // 보내고 로그인 페이지로 넘어가야함
                Get.to(LoginPage());
              }
            },
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
