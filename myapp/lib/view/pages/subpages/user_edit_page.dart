import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/user_controller.dart';
import 'package:myapp/page_util/validators.dart';
import 'package:myapp/user/user_ex.dart';
import 'package:myapp/view/components/textfield/user_info_text_form_field.dart';

import 'package:myapp/view/pages/initialpages/framepage.dart';

import '../../../allergy.dart';

class UserEditPage extends StatelessWidget {
  @override
  final _formKey = GlobalKey<FormState>();
  final user = Get.put(UserController());

  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    nameController.text = userName;
    TextEditingController classController = TextEditingController();
    classController.text = classes;
    TextEditingController unitController = TextEditingController();
    unitController.text = unit;
    final List<String> allergies = [];
    for (String i in userAllergy.keys) {
      if (userAllergy[i] == true) allergies.add(i);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "회원정보",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
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
                  text: "소속",
                  controller: unitController,
                  enabled: true,
                  validator: validateUnit()),
              UserInfoTextFormField(
                  text: "계급",
                  controller: classController,
                  enabled: true,
                  validator: validateClass()),
              UserInfoTextFormField(
                  text: "이름",
                  controller: nameController,
                  enabled: true,
                  validator: validateName()),
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
                child: OutlinedButton(
                  child: Text(
                    "저장하기",
                    style: TextStyle(
                        fontSize: 18.sp,
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
