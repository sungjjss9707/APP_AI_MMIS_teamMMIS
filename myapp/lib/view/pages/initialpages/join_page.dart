import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/allergy.dart';
import 'package:myapp/controller/user_controller.dart';
import 'package:myapp/page_util/validators.dart';
import 'package:myapp/user/user_ex.dart';
import 'package:myapp/view/components/button/custom_elevated_button.dart';
import 'package:myapp/view/components/textfield/custom_text_form_field.dart';
import 'package:myapp/view/components/user_info_radio.dart';

import 'login_page.dart';

class JoinPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final UserController u = Get.find();
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
    TextEditingController nameController = TextEditingController();
    TextEditingController milNumberController = TextEditingController();
    TextEditingController classController = TextEditingController();
    TextEditingController armyController = TextEditingController();
    TextEditingController unitController = TextEditingController();
    final allergies = allergyName;
    //이름쓰는칸, 군번쓰는칸, 계급쓰는칸, 회원가입버튼 네개로 이루어짐
    return Form(
      key: _formKey,
      //한번에 서버로 날릴거라 이 네개를 폼으로 묶는게 좋음
      child: Column(
        children: [
          CustomTextFormField(
            hint: "이름",
            funValidate: null,
            controller: nameController,
          ),
          CustomTextFormField(
            hint: "군번",
            funValidate: validateMilitaryNumber(),
            controller: milNumberController,
          ),
          CustomTextFormField(
            hint: "계급",
            funValidate: null,
            controller: classController,
          ),
          CustomTextFormField(
            hint: "소속",
            funValidate: null,
            controller: unitController,
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              "알레르기 정보",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          ...List.generate(allergies.length, (i) {
            return UserInfoRadio(text: allergies[i], enabled: true);
          }),
          SizedBox(height: 10),
          CustomElevatedButton(
            text: "회원가입",
            funpageRoute: () {
              if (_formKey.currentState!.validate()) {
                userName = nameController.text;
                army = armyController.text;
                unit = unitController.text;
                classes = classController.text;
                userAllergy = {...localUserAllergy};
                Get.to(() => LoginPage());
                Get.snackbar("저장완료", "정보가 저장되었습니다.",
                    backgroundColor: Colors.white);
              }
            },
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
