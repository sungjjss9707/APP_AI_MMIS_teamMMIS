import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/controller/suggestion_controller.dart';
import 'package:myapp/controller/user_controller.dart';
import 'package:myapp/page_util/validators.dart';
import 'package:myapp/view/components/appBar/sub_page_appbar.dart';
import 'package:myapp/view/components/button/custom_elevated_button.dart';
import 'package:myapp/view/components/custom_drawer.dart';
import 'package:myapp/view/components/textfield/custom_text_form_field.dart';
import 'package:myapp/view/components/textfield/custom_writing_area.dart';

class WriteSuggestionPage extends StatelessWidget {
  final String? title;
  final String? content;
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _content = TextEditingController();
  final SuggestionController s = Get.find();

  WriteSuggestionPage({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    if (title != null) _title.text = title!;
    if (content != null) _content.text = content!;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: subPageAppBar("건의사항 작성"),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                  controller: _title, hint: "제목", funValidate: validateTitle()),
              SizedBox(height: 8.h),
              CustomWritingArea(
                  controller: _content,
                  hint: "내용",
                  funValidate: validateContent()),
              SizedBox(height: 8.h),
              CustomElevatedButton(
                funpageRoute: () async {
                  if (_formKey.currentState!.validate()) {
                    final u = Get.put(UserController());
                    await s.postSuggestion(_title.text, _content.text,
                        u.principal.value.militaryNumber ?? "21-12325");
                    Get.back();
                  }
                },
                text: "글쓰기",
                width: double.infinity,
              ),
              SizedBox(height: 4.h),
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
