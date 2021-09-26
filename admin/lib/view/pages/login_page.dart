import 'package:admin/page_util/validators.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/textfield/custom_text_form_field.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_page.dart';

class LoginPage extends StatelessWidget {
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
                height: 400,
                width: 400,
                child: Column(
                  children: [
                    Text(
                      "MMIS 관리자 체계 로그인",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    CustomTextFormField(
                      hint: "군번",
                      funValidate: validateMilitaryNumber(),
                    ),
                    CustomTextFormField(
                      hint: "비밀번호",
                      funValidate: validatePassWorld(),
                    ),
                    SizedBox(height: 10),
                    CustomElevatedButton(
                      width: double.infinity,
                      text: "로그인",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ////////////////////////////////////////////////일단 true로 넣었는데 로그인 성공할때만 if문 통과해야함
                          Get.to(HomePage());
                        }
                      },
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
