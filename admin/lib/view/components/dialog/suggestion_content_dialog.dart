import 'package:admin/util/validators.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/textfield/custom_text_form_field.dart';
import 'package:admin/view/components/textfield/custom_writing_area.dart';
import 'package:flutter/material.dart';

import '../../../size.dart';

class SuggestionContentDialog extends StatefulWidget {
  final String title;
  final String content;

  SuggestionContentDialog({required this.title, required this.content});

  @override
  _SuggestionContentDialog createState() => _SuggestionContentDialog();
}

class _SuggestionContentDialog extends State<SuggestionContentDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  final bool enabled = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _titleController.text = widget.title;
    _contentController.text = widget.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(32),
      children: [
        Container(
          width: 500,
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
                _writtenComments(),
                _writeComment(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: gap_s),
                      child: CustomElevatedButton(
                        text: "삭제",
                        onPressed: () {
                          // 건의사항 삭제
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

  Column _writtenComments() {
    return Column(
      children: List.generate(
        1,
        (index) => Row(
          children: [
            Expanded(
              child: CustomWritingArea(
                maxLines: 2,
                enabled: false,
                hint: "답변",
                funValidate: validateContent(),
              ),
            ),
            SizedBox(width: gap_xs),
            TextButton(
              onPressed: () {},
              child: Text("수정"),
            ),
            SizedBox(width: gap_xs),
            TextButton(
              onPressed: () {},
              child: Text("삭제"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _writeComment() {
    return Row(
      children: [
        Expanded(
          child: CustomWritingArea(
            maxLines: 2,
            enabled: true,
            controller: _commentController,
            hint: "답변",
            funValidate: validateContent(),
          ),
        ),
        SizedBox(width: gap_xs),
        CustomElevatedButton(
          text: "등록",
          onPressed: () {},
        )
      ],
    );
  }
}
