import 'package:flutter/material.dart';
import 'package:myapp/view/components/textfield/user_info_text_form_field.dart';
import 'package:myapp/view/components/user_info_radio.dart';

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
            UserInfoTextFormField(text: "소속", info: "소속 예시", enabled: false),
            UserInfoTextFormField(text: "계급", info: "계급 예시", enabled: false),
            UserInfoTextFormField(text: "이름", info: "이름 예시", enabled: false),
            Divider(),
            Center(
              child: Text(
                "알레르기 정보",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            UserInfoRadio(text: "계란", allergy: true),
            UserInfoRadio(text: "두부", allergy: true),
            UserInfoRadio(text: "두부", allergy: true),
            UserInfoRadio(text: "두부", allergy: true),
            UserInfoRadio(text: "두부", allergy: true),
            UserInfoRadio(text: "두부", allergy: true),
            UserInfoRadio(text: "두부", allergy: true),
            UserInfoRadio(text: "두부", allergy: true),
            UserInfoRadio(text: "두부", allergy: true),
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
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
