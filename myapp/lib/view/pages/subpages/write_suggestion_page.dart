import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/model/inform.dart';

import 'package:myapp/page_util/validators.dart';
import 'package:myapp/view/components/appBar/sub_page_appbar.dart';
import 'package:myapp/view/components/button/custom_elevated_button.dart';
import 'package:myapp/view/components/custom_drawer.dart';
import 'package:myapp/view/components/textfield/custom_text_form_field.dart';
import 'package:myapp/view/components/textfield/custom_writing_area.dart';

class WriteSuggestionPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: subPageAppBar("건의사항 작성"),
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