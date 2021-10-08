import 'package:admin/util/validators.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/textfield/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../size.dart';

class TotalNumDialog extends StatelessWidget {
  final int totalNum;
  final _totalNumChange = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TotalNumDialog(this.totalNum);

  @override
  Widget build(BuildContext context) {
    _totalNumChange.text = totalNum.toString();
    return SimpleDialog(
      title: Text("부대 인원수 수정하기"),
      contentPadding: const EdgeInsets.all(16),
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Form(
                  key: _formKey,
                  child: CustomTextFormField(
                    funValidate: validateNumeric(),
                    controller: _totalNumChange,
                    hint: "명",
                  ),
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
        )
      ],
    );
  }
}
