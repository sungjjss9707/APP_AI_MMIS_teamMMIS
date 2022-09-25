import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/diet_controller.dart';
import 'package:myapp/controller/menu_controller.dart';
import 'package:myapp/controller/user_controller.dart';
import 'package:myapp/page_util/validators.dart';
import 'package:myapp/view/components/button/custom_elevated_button.dart';
import 'package:myapp/view/components/textfield/custom_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'framepage.dart';
import 'join_page.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final u = Get.put(UserController());
  final _militaryNumber = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          //아이디 비번 입력할떄 키보드가 올라와서 스크롤이 돼야함
          children: [
            Image.asset(
              "logo/logo_mmis.png",
              fit: BoxFit.cover,
            ),
            Center(
              child: Text(
                "군 급식 정보 체계",
                style: TextStyle(
                    fontSize: 32.w,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreen),
              ),
            ),
            Text(
              "현재 회원가입을 한 후, 로그인을 했을 때, 통신이 안되는 버그가 있습니다. 회원가입 후 앱을 껐다 킨 뒤, 로그인 해주세요.",
              style: TextStyle(fontSize: 12.sp, color: Colors.red),
            ),
            SizedBox(height: 16.w),
            _loginForm(), ////////////////////////밑에 만들어놈
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    //이름입력, 군번입력, 로그인 버튼, 회원가입 버튼 네개로 이루어짐
    return Form(
      key: _formKey,
      //한번에 서버로 날릴거라 이 네개를 폼으로 묶는게 좋음
      child: Column(
        children: [
          CustomTextFormField(
            controller: _militaryNumber,
            hint: "군번",
          ),
          CustomTextFormField(
            controller: _password,
            obscureText: true,
            hint: "비밀번호",
            funValidate: validatePassWorld(),
          ),
          SizedBox(height: 10),
          CustomElevatedButton(
            width: double.infinity,
            text: "로그인",
            funpageRoute: () async {
              if (_formKey.currentState!.validate()) {
                int code = await u.login(
                    _militaryNumber.text.trim(), _password.text.trim());
                if (code == 1) {
                  DateTime now = DateTime.now();
                  final d = Get.put(DietController());
                  final menu = Get.put(MenuController());
                  int code1 = await d.findMonth(
                      now.year.toString(), now.month.toString());
                  int code2 = await menu.findAll();
                  if (code1 == 1 && code2 == 1) Get.off(() => FramePage());
                } else
                  Get.snackbar(
                    "로그인 실패",
                    "아이디나 비밀번호가 알맞지 않습니다. ",
                    colorText: Colors.red,
                    duration: Duration(seconds: 1),
                  );
              }
            },
          ),
          SizedBox(height: 10.h),
          TextButton(
            child: Text("회원가입"),
            onPressed: () {
              Get.off(() => JoinPage()); //회원가입페이지로 이동
            },
          ),
        ],
      ),
    );
  }
}
