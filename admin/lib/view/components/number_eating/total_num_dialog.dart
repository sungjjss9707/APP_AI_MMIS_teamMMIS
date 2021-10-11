import 'package:admin/controller/not_eating_controller.dart';
import 'package:admin/util/editDateFormat.dart';
import 'package:admin/util/validators.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/login_and_join/tag_and_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../size.dart';

class TotalNumDialog extends StatelessWidget {
  final DateTime date;
  final List<String> totalNumOfPeopleList;
  final _totalNumChangeBreakFast = TextEditingController();
  final _totalNumChangeBrunch = TextEditingController();
  final _totalNumChangeLunch = TextEditingController();
  final _totalNumChangeDinner = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final NotEatingController not = Get.find();
  TotalNumDialog(this.date, this.totalNumOfPeopleList);

  @override
  Widget build(BuildContext context) {
    final String year = getYear(date);
    final String month = getMonth(date);
    final String day = getDay(date);
    _totalNumChangeBreakFast.text = totalNumOfPeopleList[0];
    _totalNumChangeBrunch.text = totalNumOfPeopleList[1];
    _totalNumChangeLunch.text = totalNumOfPeopleList[2];
    _totalNumChangeDinner.text = totalNumOfPeopleList[3];
    return SimpleDialog(
      title: Text("부대 인원수 수정하기"),
      contentPadding: const EdgeInsets.all(16),
      children: [
        Container(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: TagAndTextFormField(
                    text: "조식",
                    funValidate: validateNumeric(),
                    controller: _totalNumChangeBreakFast,
                    hint: "명",
                  ),
                  width: 200,
                ),
                SizedBox(
                  child: TagAndTextFormField(
                    text: "브런치",
                    funValidate: validateNumeric(),
                    controller: _totalNumChangeBrunch,
                    hint: "명",
                  ),
                  width: 200,
                ),
                SizedBox(
                  child: TagAndTextFormField(
                    text: "중식",
                    funValidate: validateNumeric(),
                    controller: _totalNumChangeLunch,
                    hint: "명",
                  ),
                  width: 200,
                ),
                SizedBox(
                  child: TagAndTextFormField(
                    text: "석식",
                    funValidate: validateNumeric(),
                    controller: _totalNumChangeDinner,
                    hint: "명",
                  ),
                  width: 200,
                ),
                SizedBox(height: gap_s),
                Row(
                  children: [
                    Spacer(),
                    CustomElevatedButton(
                      text: "수정하기",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (_totalNumChangeBreakFast.text.trim() !=
                              totalNumOfPeopleList[0]) {
                            await not.changeTotalNumOfPeople(year, month, day,
                                "조식", _totalNumChangeBreakFast.text.trim());
                          }
                          if (_totalNumChangeBrunch.text.trim() !=
                              totalNumOfPeopleList[1]) {
                            await not.changeTotalNumOfPeople(year, month, day,
                                "브런치", _totalNumChangeBrunch.text.trim());
                          }
                          if (_totalNumChangeLunch.text.trim() !=
                              totalNumOfPeopleList[2]) {
                            await not.changeTotalNumOfPeople(year, month, day,
                                "중식", _totalNumChangeLunch.text.trim());
                          }
                          if (_totalNumChangeDinner.text.trim() !=
                              totalNumOfPeopleList[3]) {
                            await not.changeTotalNumOfPeople(year, month, day,
                                "석식", _totalNumChangeDinner.text.trim());
                          }
                          not.findByDate(year, month, day);
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
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
