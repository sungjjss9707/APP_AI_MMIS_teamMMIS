import 'package:admin/controller/notice_controller.dart';
import 'package:admin/util/validators.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/textfield/custom_text_form_field.dart';
import 'package:admin/view/components/textfield/custom_writing_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../size.dart';

class NoticeContentDialog extends StatefulWidget {
  final String title;
  final String content;
  final int id;

  NoticeContentDialog(
      {required this.title, required this.content, required this.id});

  @override
  _NoticeContentDialogState createState() => _NoticeContentDialogState();
}

class _NoticeContentDialogState extends State<NoticeContentDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  late bool enabled;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _titleController.text = widget.title;
    _contentController.text = widget.content;
    enabled = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NoticeController n = Get.find();
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
                    enabled == false
                        ? Padding(
                            padding: const EdgeInsets.only(right: gap_s),
                            child: CustomElevatedButton(
                              text: "수정하기",
                              onPressed: () {
                                setState(() {
                                  enabled = true;
                                });
                              },
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(right: gap_s),
                            child: CustomElevatedButton(
                              text: "수정완료",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_titleController.text != widget.title ||
                                      _contentController.text !=
                                          widget.content) {
                                    try {
                                      n.updateById(
                                          widget.id,
                                          _titleController.text,
                                          _contentController.text);
                                    } catch (e) {
                                      Get.snackbar("", "수정 실패");
                                    }
                                    String newTitle = _titleController.text;
                                    String newContent = _contentController.text;
                                    print("title $newTitle");
                                    print("content $newContent");
                                  }
                                  setState(() {
                                    enabled = false;
                                  });
                                }
                              },
                            ),
                          ),
                    enabled == false
                        ? Padding(
                            padding: const EdgeInsets.only(right: gap_s),
                            child: CustomElevatedButton(
                              text: "삭제",
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          )
                        : Container(),
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
