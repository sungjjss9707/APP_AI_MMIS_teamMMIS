import 'package:admin/controller/menu_controller.dart';
import 'package:admin/util/Info.dart';
import 'package:admin/util/validators.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/login_and_join/tag_and_textformfield.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../size.dart';
import '../../../style.dart';

// 사이즈 문제 해결해야 됨.
class NewMenuInputDialog extends StatelessWidget {
  final _menuName = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final Map<String, String> _allergy = {
    "계란류": "0",
    "우유": "0",
    "메밀": "0",
    "땅콩": "0",
    "대두": "0",
    "밀": "0",
    "고등어": "0",
    "게": "0",
    "새우": "0",
    "돼지고기": "0",
    "복숭아": "0",
    "토마토": "0",
    "아황산류": "0",
    "호두": "0",
    "닭고기": "0",
    "쇠고기": "0",
    "오징어": "0",
    "조개류": "0",
    "잣": "0",
  };
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height > 864
        ? 800
        : MediaQuery.of(context).size.height - 64;
    List<dynamic> allergyList = [];
    List<TextEditingController> _nutritionInfoList = List.generate(
        nutritionName.length, (index) => TextEditingController(text: "0"));
    return SimpleDialog(
      title: Text(
        "메뉴 입력",
        style: h5(),
      ),
      contentPadding: EdgeInsets.all(32),
      children: [
        Container(
          width: 500,
          height: _height,
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  "부대에서 제공하는 메뉴 정보를 추가합니다.",
                  style: body1(),
                ),
                SizedBox(height: gap_m),
                Container(
                  padding: const EdgeInsets.all(gap_m),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TagAndTextFormField(
                    controller: _menuName,
                    text: "메뉴 이름",
                    funValidate: validateIsEmpty(),
                  ),
                ),
                SizedBox(height: gap_m),
                _nutritionInfo(_nutritionInfoList),
                SizedBox(height: gap_m),
                _allergyInfo(allergyList),
                SizedBox(height: gap_m),
                Container(
                  child: Row(
                    children: [
                      Spacer(),
                      CustomElevatedButton(
                        text: "확인",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final m = Get.put(MenuController());
                            await m.save(
                                _menuName.text,
                                _convertNutritionInfo(_nutritionInfoList),
                                _allergy);
                            print(_menuName.text);
                            print(_convertNutritionInfo(_nutritionInfoList));
                            print(_allergy);
                            // 연결 후 팝업창 닫음
                            Navigator.pop(context);
                          }
                        },
                      ),
                      SizedBox(width: gap_m),
                      CustomElevatedButton(
                        text: "취소",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _nutritionInfo(List<TextEditingController> list) {
    return Container(
      padding: const EdgeInsets.all(gap_m),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "* 영양정보",
            style: subtitle2(),
          ),
          SizedBox(height: gap_s),
          Wrap(
            alignment: WrapAlignment.center,
            children: List.generate(
              nutritionName.length,
              (index) => SizedBox(
                // container의 반절 하면 딱 맞음.
                width: 250,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: gap_m),
                  child: TagAndTextFormField(
                    controller: list[index],
                    funValidate: validateNumeric(),
                    text: nutritionName[index],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _allergyInfo(List<dynamic> allergyList) {
    return Container(
        padding: const EdgeInsets.all(gap_m),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "* 알레르기 정보",
              style: subtitle2(),
            ),
            SizedBox(height: gap_s),
            CustomCheckBoxGroup(
              enableButtonWrap: true,
              buttonValuesList: allergyName,
              buttonLables: allergyName,
              checkBoxButtonValues: (value) {
                allergyList = value;
                _updateAllergyMap(allergyList);
              },
              selectedColor: Colors.lightGreen,
              unSelectedColor: Colors.white,
            ),
          ],
        ));
  }

  Map<String, String> _convertNutritionInfo(List<TextEditingController> list) {
    Map<String, String> result = {};
    for (int i = 0; i < list.length; i++) {
      result[nutritionNameWithOutScale[i]] = list[i].text.trim();
    }
    return result;
  }

  void _updateAllergyMap(List<dynamic> list) {
    for (dynamic i in list) {
      _allergy[i.toString()] = "1";
    }
  }
}
