import 'package:admin/util/validators.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/login_and_join/tag_and_textformfield.dart';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import 'login_page.dart';

class JoinPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _militaryNumber = TextEditingController();
  final _password = TextEditingController();
  final _passwordConfirm = TextEditingController();
  final _unit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: _height > 400 ? _height * 0.5 - 200 : 0),
          Center(
            child: Form(
              key: _formKey,
              //한번에 서버로 날릴거라 이 네개를 폼으로 묶는게 좋음
              child: Container(
                height: 600,
                width: 400,
                child: Column(
                  children: [
                    Text(
                      "MMIS 관리자 체계 회원가입",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: [
                        TypeAheadFormField(
                          onSuggestionSelected: (String suggestion) {
                            _unit.text = suggestion;
                          },
                          itemBuilder: (context, String suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          suggestionsCallback: (pattern) {
                            return MilitaryUnit.getSuggestions(pattern);
                          },
                        ),
                        TagAndTextFormField(
                          text: "군번",
                          controller: _militaryNumber,
                          funValidate: validateMilitaryNumber(),
                        ),
                        TagAndTextFormField(
                          text: "이름",
                          controller: _name,
                          funValidate: validateMilitaryNumber(),
                        ),
                        TagAndTextFormField(
                          text: "비밀번호",
                          controller: _password,
                          funValidate: validateMilitaryNumber(),
                        ),
                        TagAndTextFormField(
                          text: "비밀번호확인",
                          controller: _passwordConfirm,
                          funValidate: validateMilitaryNumber(),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    CustomElevatedButton(
                      width: double.infinity,
                      text: "회원가입",
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _password.text == _passwordConfirm.text) {
                          Get.to(() => LoginPage());
                        }
                      },
                    ),
                    SizedBox(height: 5),
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
          SizedBox(height: _height > 400 ? _height * 0.5 - 200 : 0),
        ],
      ),
    );
  }
}

class MilitaryUnit {
  static final List<String> units = [
    '공군 제xx전투비행단',
    '육군 제**사단',
    '육군 제**사단',
    '육군 제**사단',
    '육군 제**사단',
    '육군 1xx연대',
    '해병대 xx부대',
    '국방부 ??정책과',
    '국방부 xx정책과',
    '공군 제a전투비행단',
    '공군 제b전투비행단',
    '공군 제c전투비행단',
    '공군 제d전투비행단',
    '공군 제e전투비행단',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(units);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
