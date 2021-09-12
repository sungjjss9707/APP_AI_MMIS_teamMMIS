import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/model/inform.dart';

import 'package:myapp/page_util/validators.dart';
import 'package:myapp/view/components/custom_elevated_button.dart';
import 'package:myapp/view/components/custom_text_form_field.dart';
import 'package:myapp/view/components/custom_writing_area.dart';

class WriteSuggestionPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(hint: "제목", funValidate: validateTitle()),
              CustomWritingArea(hint: "내용", funValidate: validateContent()),
              CustomElevatedButton(
                funpageRoute: () {
                  if (_formKey.currentState!.validate()) {}
                },
                text: "글쓰기",
                width: double.infinity,
              ),
              SizedBox(height: 4),
              CustomElevatedButton(
                funpageRoute: () {
                  Get.back();
                },
                text: "취소",
                width: double.infinity,
              )
            ],
          ),
        ),
      ),
    );
  }
}
