import 'package:admin/controller/not_eating_controller.dart';
import 'package:admin/util/validators.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/login_and_join/tag_and_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../size.dart';

class TotalNumDialog extends StatelessWidget {
  final DateTime date;
  final _totalNumChangeBreakFast = TextEditingController();
  final _totalNumChangeBrunch = TextEditingController();
  final _totalNumChangeLunch = TextEditingController();
  final _totalNumChangeDinner = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final NotEatingController not = Get.find();
  TotalNumDialog(this.date);

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //여기서 통신하면 됨.
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
