import 'package:admin/util/Info.dart';
import 'package:admin/util/validators.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/login_and_join/tag_and_textformfield.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../size.dart';
import '../../../style.dart';

class NewMenuInputDialog extends StatelessWidget {
  final _menuName = TextEditingController();
  late final List<TextEditingController> _nutritionInfoList;
  final _formKey = GlobalKey<FormState>();

  final Map _allergy = {
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
    List<dynamic> allergyList = [];
    _nutritionInfoList =
        List.generate(nutritionName.length, (index) => TextEditingController());
    return SimpleDialog(
      title: Text(
        "메뉴 입력",
        style: h5(),
      ),
      contentPadding: EdgeInsets.all(32),
      children: [
        Container(
          width: 500,
          height: 800,
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
                _nutritionInfo(),
                SizedBox(height: gap_m),
                _allergyInfo(allergyList),
                SizedBox(height: gap_m),
                Container(
                  child: Row(
                    children: [
                      Spacer(),
                      CustomElevatedButton(
                        text: "확인",
                        onPressed: () {
                          print(_menuName.text);
                          print(_convertNutritionInfo(_nutritionInfoList));
                          print(_allergy);
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

  Widget _nutritionInfo() {
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
                    controller: _nutritionInfoList[index],
                    funValidate: validateIsEmpty(),
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
