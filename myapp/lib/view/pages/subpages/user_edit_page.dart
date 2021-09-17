import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/user/user.dart';
import 'package:myapp/view/components/textfield/user_info_text_form_field.dart';
import 'package:myapp/view/components/user_info_radio.dart';
import 'package:myapp/view/pages/initialpages/framepage.dart';

class UserEditPage extends StatelessWidget {
  @override
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    nameController.text = userName;
    TextEditingController classController = TextEditingController();
    classController.text = classes;
    TextEditingController unitController = TextEditingController();
    unitController.text = unit;
    final allergies = userAllergy.keys.toList();
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              UserInfoTextFormField(
                  text: "소속", controller: unitController, enabled: true, n: 50),
              UserInfoTextFormField(
                  text: "계급", controller: classController, enabled: true),
              UserInfoTextFormField(
                  text: "이름", controller: nameController, enabled: true),
              Divider(),
              Center(
                child: Text(
                  "알레르기 정보",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              ...List.generate(allergies.length, (i) {
                return UserInfoRadio(text: allergies[i], enabled: true);
              }),
              Divider(),
              SizedBox(height: 10),
              Center(
                child: OutlinedButton(
                  child: Text(
                    "저장하기",
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
                    if (_formKey.currentState!.validate()) {
                      userName = nameController.text;
                      unit = unitController.text;
                      classes = classController.text;
                      userAllergy = {...localUserAllergy};
                      Get.to(() => FramePage());
                      Get.snackbar("저장완료", "정보가 저장되었습니다.",
                          backgroundColor: Colors.white);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
