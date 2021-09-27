import 'package:admin/util/validators.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/textfield/custom_text_form_field.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_page.dart';

class JoinPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: _height > 400 ? _height * 0.5 - 200 : 0),
          Center(
            child: Form(
              key: _formKey,
              //한번에 서버로 날릴거라 이 네개를 폼으로 묶는게 좋음
              child: Container(
                height: 600,
                width: 400,
                child: Column(
                  children: [
                    Text(
                      "MMIS 관리자 체계 회원가입",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    CustomTextFormField(
                      hint: "이름",
                    ),
                    CustomTextFormField(
                      hint: "소속",
                    ),
                    CustomTextFormField(
                      hint: "군번",
                      funValidate: validateMilitaryNumber(),
                    ),
                    CustomTextFormField(
                      hint: "비밀번호",
                      funValidate: validatePassWord(),
                    ),
                    CustomTextFormField(
                      hint: "비밀번호 확인",
                      funValidate: validatePassWord(),
                    ),
                    SizedBox(height: 10),
                    CustomElevatedButton(
                      width: double.infinity,
                      text: "회원가입",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Get.to(() => LoginPage());
                        }
                      },
                    ),
                    SizedBox(height: 5),
                    TextButton(
                      onPressed: () {
                        Get.to(() => LoginPage());
                      },
                      child: Text("이미 회원이신가요?"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: _height > 400 ? _height * 0.5 - 200 : 0),
        ],
      ),
    );
  }
}
