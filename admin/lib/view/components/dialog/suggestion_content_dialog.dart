import 'package:admin/controller/suggestion_controller.dart';
import 'package:admin/util/validators.dart';
import 'package:admin/view/components/button/custom_elevated_button.dart';
import 'package:admin/view/components/suggestion/written_comment_box.dart';
import 'package:admin/view/components/textfield/custom_text_form_field.dart';
import 'package:admin/view/components/textfield/custom_writing_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../size.dart';

class SuggestionContentDialog extends StatefulWidget {
  final int id;

  SuggestionContentDialog({required this.id});

  @override
  _SuggestionContentDialog createState() => _SuggestionContentDialog();
}

class _SuggestionContentDialog extends State<SuggestionContentDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _postCommentController = TextEditingController();
  late List<WrittenCommentBox> _writtenCommentsList;

  final bool enabled = false;
  final _formKey = GlobalKey<FormState>();
  SuggestionController s = Get.find();

  @override
  Future<void> initState() async {
    _titleController.text = s.suggestion.value.title!;
    _contentController.text = s.suggestion.value.content!;
    _writtenCommentsList =
        List.generate(s.suggestion.value.comments!.length, (index) {
      WrittenCommentBox writtenCommentBox = WrittenCommentBox(
        enabled: true,
      );
      writtenCommentBox.controller.text =
          s.suggestion.value.comments![index].content ?? "";
      return WrittenCommentBox();
    });
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
                        onPressed: () async {
                          await s.deleteById(widget.id);
                          Navigator.pop(context);
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

  Widget _writtenComments() {
    return Obx(
      () => Column(
        children: List.generate(_writtenCommentsList.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: gap_m),
            child: Row(
              children: [
                Expanded(
                  child: _writtenCommentsList[index],
                ),
                SizedBox(width: gap_xs),
                TextButton(
                  onPressed: () {
                    setState(() async {
                      await s.updateComment(
                          widget.id,
                          s.suggestion.value.comments![index].id!,
                          _writtenCommentsList[index].controller.text);
                    });
                  },
                  child: Text("수정"),
                ),
                SizedBox(width: gap_s),
                TextButton(
                  onPressed: () {
                    setState(() async {
                      await s.deleteComment(
                          widget.id, s.suggestion.value.comments![index].id!);
                    });
                  },
                  child: Text("삭제"),
                ),
              ],
            ),
          );
        }),
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
            controller: _postCommentController,
            hint: "답변",
            funValidate: validateContent(),
          ),
        ),
        SizedBox(width: gap_xs),
        CustomElevatedButton(
          text: "등록",
          onPressed: () async {
            await s.postComment(widget.id, _postCommentController.text);
          },
        )
      ],
    );
  }
}
