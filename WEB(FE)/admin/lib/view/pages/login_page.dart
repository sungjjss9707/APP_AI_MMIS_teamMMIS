import 'package:admin/controller/admin_controller.dart';
import 'package:admin/size.dart';
import 'package:admin/style.dart';
import 'package:admin/util/validators.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/login_and_join/tag_and_textformfield.dart';
import 'package:admin/view/pages/join_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'frame_page.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final AdministerController a = Get.put(AdministerController());
  final TextEditingController _militaryNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          //한번에 서버로 날릴거라 이 네개를 폼으로 묶는게 좋음
          child: Container(
            padding: const EdgeInsets.all(gap_m),
            width: 400,
            height: 600,
            child: ListView(
              children: [
                SizedBox(
                  width: 400,
                  height: 140,
                  child: Image.asset(
                    "black_logo_transparent.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Text(
                    "군 급식 정보 체계",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: gap_m),
                Center(
                  child: Text(
                    "관리자 체계 로그인",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: gap_s,
                ),
                TagAndTextFormField(
                  hint: "군번을 입력하세요",
                  text: "군번",
                  controller: _militaryNumber,
                  funValidate: validateMilitaryNumber(),
                ),
                TagAndTextFormField(
                  hint: "비밀번호를 입력하세요",
                  text: "비밀번호",
                  controller: _password,
                  funValidate: validatePassWord(),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                CustomElevatedButton(
                  width: double.infinity,
                  text: "로그인",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      int r = await a.login(
                          _militaryNumber.text.trim(), _password.text.trim());
                      if (r == 1) {
                        Get.to(() => FramePage());
                      } else
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              "로그인 실패",
                              style: subtitle1(),
                            ),
                            content: Text(
                              "군번이나 비밀번호가 틀렸습니다.",
                              style: body1(),
                            ),
                            actions: [
                              CustomElevatedButton(
                                text: "닫기",
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                    }
                  },
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Get.to(() => JoinPage());
                  },
                  child: Text("회원가입"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
