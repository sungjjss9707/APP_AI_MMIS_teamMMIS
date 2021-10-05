import 'package:admin/controller/admin_controller.dart';
import 'package:admin/size.dart';
import 'package:admin/util/validators.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/textfield/custom_text_form_field.dart';
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
            height: 400,
            child: Column(
              children: [
                Text(
                  "MMIS 관리자 체계 로그인",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                CustomTextFormField(
                  controller: _militaryNumber,
                  hint: "군번",
                  funValidate: validateMilitaryNumber(),
                ),
                CustomTextFormField(
                  controller: _password,
                  hint: "비밀번호",
                  funValidate: validatePassWord(),
                ),
                SizedBox(height: 10),
                CustomElevatedButton(
                  width: double.infinity,
                  text: "로그인",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        int result = await a.login(
                            _militaryNumber.text.trim(), _password.text.trim());
                        if (result == 1) {
                          Get.to(() => FramePage());
                        } else {
                          Get.snackbar("로그인 시도", "로그인 실패");
                        }
                      } catch (e) {}
                    }
                  },
                ),
                SizedBox(height: 5),
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
