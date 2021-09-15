import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/user/user.dart';
import 'package:myapp/view/components/textfield/user_info_text_form_field.dart';
import 'package:myapp/view/components/user_info_radio.dart';
import 'package:myapp/view/pages/subpages/user_edit_page.dart';

class UserInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "회원정보",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 30,
          left: 20,
          right: 20,
          bottom: 30,
        ),
        child: ListView(
          children: [
            UserInfoTextFormField(text: "소속", info: unit, enabled: false),
            UserInfoTextFormField(text: "계급", info: classes, enabled: false),
            UserInfoTextFormField(text: "이름", info: userName, enabled: false),
            Divider(),
            Center(
              child: Text(
                "알레르기 정보",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            UserInfoRadio(text: "갑각류", enabled: false),
            UserInfoRadio(text: "견과류", enabled: false),
            UserInfoRadio(text: "달걀", enabled: false),
            UserInfoRadio(text: "땅콩", enabled: false),
            UserInfoRadio(text: "밀", enabled: false),
            UserInfoRadio(text: "생선", enabled: false),
            UserInfoRadio(text: "우유", enabled: false),
            UserInfoRadio(text: "조개", enabled: false),
            UserInfoRadio(text: "콩", enabled: false),
            Divider(),
            SizedBox(height: 10),
            Center(
              child: OutlinedButton(
                child: Text(
                  "수정하기",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                  20,
                ))),
                onPressed: () {
                  localUserAllergy = userAllergy;
                  Get.to(() => UserEditPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
