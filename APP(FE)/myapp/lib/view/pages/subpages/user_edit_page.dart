import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/user_controller.dart';
import 'package:myapp/page_util/validators.dart';
import 'package:myapp/user/user_ex.dart';
import 'package:myapp/view/components/appBar/sub_page_appbar.dart';
import 'package:myapp/view/components/textfield/user_info_text_form_field.dart';

import 'package:myapp/view/pages/initialpages/framepage.dart';

import '../../../allergy.dart';

class UserEditPage extends StatelessWidget {
  @override
  final _formKey = GlobalKey<FormState>();
  final UserController u = Get.find();

  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: "${u.principal.value.username}");
    TextEditingController classController =
        TextEditingController(text: "${u.principal.value.rank}");
    TextEditingController unitController =
        TextEditingController(text: "${u.principal.value.unit}");
    TextEditingController passwordController =
        TextEditingController(text: "*******");

    final List<String> allergies = [];
    for (String i in userAllergy.keys) {
      if (userAllergy[i] == true) allergies.add(i);
    }
    return Scaffold(
      appBar: subPageAppBar("회원정보 수정"),
      body: Padding(
        padding: EdgeInsets.only(
          top: 30.h,
          left: 20.w,
          right: 20.w,
          bottom: 30.h,
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              UserInfoTextFormField(
                  obscureText: false,
                  info: "",
                  text: "소속",
                  controller: unitController,
                  enabled: true,
                  validator: validateUnit()),
              UserInfoTextFormField(
                  obscureText: false,
                  info: "",
                  text: "계급",
                  controller: classController,
                  enabled: true,
                  validator: validateClass()),
              UserInfoTextFormField(
                  obscureText: false,
                  info: "",
                  text: "이름",
                  controller: nameController,
                  enabled: true,
                  validator: validateName()),
              UserInfoTextFormField(
                  obscureText: true,
                  info: "",
                  text: "비밀번호",
                  controller: passwordController,
                  enabled: true,
                  validator: validatePassWorld()),
              Divider(),
              Center(
                child: Text(
                  "알레르기 정보",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                ),
              ),
              CustomCheckBoxGroup(
                enableButtonWrap: true,
                buttonValuesList: allergyName,
                buttonLables: allergyName,
                defaultSelected: allergies,
                checkBoxButtonValues: (value) {
                  List allergyList = value;
                  for (dynamic i in allergyList) {
                    localUserAllergy[i] = true;
                  }
                },
                selectedColor: Colors.lightGreen,
                unSelectedColor: Colors.white,
              ),
              Divider(),
              SizedBox(height: 8.h),
              Center(
                child: TextButton(
                  child: Text(
                    "저장하기",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.lightGreen,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      userName = nameController.text;
                      unit = unitController.text;
                      classes = classController.text;
                      userAllergy = {...localUserAllergy};
                      Get.offAll(() => FramePage());
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
