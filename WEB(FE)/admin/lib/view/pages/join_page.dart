import 'package:admin/controller/admin_controller.dart';
import 'package:admin/size.dart';
import 'package:admin/util/Info.dart';
import 'package:admin/util/validators.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/login_and_join/tag_and_textAheadFormField.dart';
import 'package:admin/view/components/login_and_join/tag_and_textformfield.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../style.dart';
import 'login_page.dart';

class JoinPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _militaryNumber = TextEditingController();
  final _password = TextEditingController();
  final _passwordConfirm = TextEditingController();
  final _unit = TextEditingController();
  final _rank = TextEditingController();
  final a = Get.put(AdministerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          //한번에 서버로 날릴거라 이 네개를 폼으로 묶는게 좋음
          child: Container(
            width: 400,
            height: 800,
            child: ListView(
              children: [
                Center(
                  child: Text(
                    "관리자 체계 회원가입",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: gap_s,
                ),
                Column(
                  children: [
                    TagAndTextAheadFormField(
                      hint: "소속(부대명)을 입력하세요",
                      funValidate: validateIsEmpty(),
                      text: "소속",
                      controller: _unit,
                      suggestionsCallback: (pattern) {
                        // 여기서는 부대 이름이 들어가야 됨.
                        return MilitaryUnit.getSuggestions(pattern);
                      },
                    ),
                    TagAndTextAheadFormField(
                      hint: "계급을 입력하세요",
                      funValidate: validateIsEmpty(),
                      text: "계급",
                      controller: _rank,
                      suggestionsCallback: (pattern) {
                        // 여기서는 부대 이름이 들어가야 됨.
                        return Rank.getSuggestions(pattern);
                      },
                    ),
                    TagAndTextFormField(
                      hint: "군번을 입력하세요",
                      text: "군번",
                      controller: _militaryNumber,
                      funValidate: validateMilitaryNumber(),
                    ),
                    TagAndTextFormField(
                      hint: "이름을 입력하세요",
                      text: "이름",
                      controller: _name,
                      funValidate: validateIsEmpty(),
                    ),
                    TagAndTextFormField(
                      hint: "비밀번호를 입력하세요",
                      obscureText: true,
                      text: "비밀번호",
                      controller: _password,
                      funValidate: validatePassWord(),
                    ),
                    TagAndTextFormField(
                      hint: "비밀번호를 입력하세요",
                      obscureText: true,
                      text: "비밀번호확인",
                      controller: _passwordConfirm,
                      funValidate: validatePassWord(),
                    )
                  ],
                ),
                SizedBox(height: 10),
                CustomElevatedButton(
                  width: double.infinity,
                  text: "회원가입",
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        _password.text == _passwordConfirm.text) {
                      int code = await a.join(
                        _name.text.trim(),
                        _militaryNumber.text.trim(),
                        _password.text.trim(),
                        _rank.text.trim(),
                        _unit.text.trim(),
                      );
                      if (code == 1) {
                        Get.to(() => LoginPage());
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              "회원가입 실패",
                              style: subtitle1(),
                            ),
                            content: Text(
                              "이미 가입된 아이디입니다.",
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
                    } else if (_password.text != _passwordConfirm.text) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            "비밀번호 오류",
                            style: subtitle1(),
                          ),
                          content: Text(
                            "비밀번호가 서로 다릅니다.",
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
                    Get.to(() => LoginPage());
                  },
                  child: Text("이미 회원이신가요?"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
