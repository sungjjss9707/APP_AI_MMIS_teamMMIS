import 'package:admin/controller/notice_controller.dart';
import 'package:admin/util/validators.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/textfield/custom_text_form_field.dart';
import 'package:admin/view/components/textfield/custom_writing_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../size.dart';

class NoticeWriteDialog extends StatefulWidget {
  @override
  _NoticeWriteDialogState createState() => _NoticeWriteDialogState();
}

class _NoticeWriteDialogState extends State<NoticeWriteDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final bool enabled = true;
  final _formKey = GlobalKey<FormState>();
  final NoticeController n = Get.find();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(32),
      children: [
        Container(
          width: 500,
          height: 500,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  enabled: enabled,
                  controller: _titleController,
                  hint: "제목",
                  funValidate: validateTitle(),
                ),
                CustomWritingArea(
                  enabled: enabled,
                  controller: _contentController,
                  hint: "내용",
                  funValidate: validateContent(),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: gap_s),
                      child: CustomElevatedButton(
                        text: "게시하기",
                        onPressed: () async {
                          try {
                            await n.save(
                                _titleController.text, _contentController.text);
                            Navigator.pop(context);
                          } catch (e) {
                            Get.snackbar("", "게시 실패");
                          }
                        },
                      ),
                    ),
                    CustomElevatedButton(
                      text: "닫기",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
