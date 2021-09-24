import 'package:admin/components/button/custom_elevated_button.dart';
import 'package:admin/components/textfield/custom_text_form_field.dart';
import 'package:admin/components/textfield/custom_writing_area.dart';
import 'package:admin/page_util/validators.dart';
import 'package:flutter/material.dart';

import '../../size.dart';

class NoticeContentDialog extends StatelessWidget {
  final String title;
  final String content;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  NoticeContentDialog({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(32),
      children: [
        Container(
          width: 500,
          height: 500,
          child: Column(
            children: [
              CustomTextFormField(
                controller: _titleController,
                hint: "제목",
                funValidate: validateTitle(),
              ),
              CustomWritingArea(
                controller: _contentController,
                hint: "내용",
                funValidate: validateContent(),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomElevatedButton(
                    text: "수정",
                    onPressed: () {
                      if (_titleController.text != title ||
                          _contentController.text != content) {
                        // 여기서 글을 수정된 내용을 서버로 통신.
                        String newTitle = _titleController.text;
                        String content = _contentController.text;
                      }
                    },
                  ),
                  SizedBox(width: gap_s),
                  CustomElevatedButton(
                    text: "삭제",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: gap_s),
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
      ],
    );
  }
}
