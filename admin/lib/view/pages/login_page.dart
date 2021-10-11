import 'package:admin/controller/admin_controller.dart';
import 'package:admin/size.dart';
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
            height: 500,
            child: Column(
              children: [
                Text(
                  "MMIS 관리자 체계 로그인",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TagAndTextFormField(
                  text: "군번",
                  controller: _militaryNumber,
                  funValidate: validateMilitaryNumber(),
                ),
                TagAndTextFormField(
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
                      }
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
