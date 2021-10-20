import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/allergy.dart';
import 'package:myapp/controller/user_controller.dart';
import 'package:myapp/page_util/validators.dart';
import 'package:myapp/user/user_ex.dart';
import 'package:myapp/view/components/button/custom_elevated_button.dart';
import 'package:myapp/view/components/textfield/custom_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_page.dart';

class JoinPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final UserController u = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          //아이디 비번 입력할떄 키보드가 올라와서 스크롤이 돼야함
          children: [
            SizedBox(height: 0.07.sw),
            Container(
              alignment: Alignment.center,
              child: Text(
                "회원가입",
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 0.07.sw),
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
    TextEditingController password = TextEditingController();
    TextEditingController passwordConfirm = TextEditingController();
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
          CustomTextFormField(
            hint: "비밀번호",
            obscureText: true,
            funValidate: null,
            controller: password,
          ),
          CustomTextFormField(
            hint: "비밀번호 확인",
            obscureText: true,
            funValidate: null,
            controller: passwordConfirm,
          ),
          SizedBox(height: 10.h),
          Center(
            child: Text(
              "알레르기 정보",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
            ),
          ),
          CustomCheckBoxGroup(
            enableButtonWrap: true,
            buttonValuesList: allergyName,
            buttonLables: allergyName,
            checkBoxButtonValues: (value) {
              List allergyList = value;
              for (dynamic i in allergyList) {
                localUserAllergy[i] = true;
              }
            },
            selectedColor: Colors.lightGreen,
            unSelectedColor: Colors.white,
          ),
          // ...List.generate(allergies.length, (i) {
          //   return UserInfoRadio(text: allergies[i], enabled: true);
          // }),
          SizedBox(height: 10),
          CustomElevatedButton(
            text: "회원가입",
            funpageRoute: () async {
              if (_formKey.currentState!.validate()) {
                if (passwordConfirm.text.trim() != password.text.trim()) {
                  Get.snackbar("회원가입 실패", "비밀번호 확인과 비밀번호가 다릅니다.",
                      colorText: Colors.red, backgroundColor: Colors.white);
                } else {
                  userName = nameController.text;
                  army = armyController.text;
                  unit = unitController.text;
                  classes = classController.text;
                  userAllergy = {...localUserAllergy};
                  Map<String, String> allergy = userAllergy.map(
                      (key, value) => MapEntry(key, value == true ? "1" : "0"));
                  try {
                    int code = await u.join(
                        nameController.text,
                        milNumberController.text,
                        password.text,
                        armyController.text,
                        unitController.text,
                        allergy);
                    if (code == 1) {
                      Get.snackbar("저장완료", "정보가 저장되었습니다.",
                          backgroundColor: Colors.white);
                      Get.to(() => LoginPage());
                    } else
                      Get.snackbar("회원가입 실패", "이미 가입되어 있습니다",
                          colorText: Colors.red, backgroundColor: Colors.white);
                  } catch (e) {
                    Get.snackbar("회원가입 실패", "서버와의 연결이 끊겼습니다.",
                        colorText: Colors.red, backgroundColor: Colors.white);
                  }
                }
              }
            },
            width: double.infinity,
          ),
          SizedBox(height: 10.h),
          TextButton(
            child: Text("이미 회원이신가요?"),
            onPressed: () {
              Get.to(LoginPage()); //회원가입페이지로 이동
            },
          )
        ],
      ),
    );
  }
}
