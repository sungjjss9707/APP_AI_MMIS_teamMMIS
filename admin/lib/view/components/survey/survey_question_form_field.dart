import 'package:admin/style.dart';
import 'package:admin/view/components/survey/multipleChoice.dart';
import 'package:admin/view/components/survey/short_answer.dart';
import 'package:admin/view/components/survey/single_choice.dart';
import 'package:flutter/material.dart';

import '../../../size.dart';

class SurveyQuestionFormField extends StatefulWidget {
  final funValidate;
  int index;
  final questionController = TextEditingController();
  dynamic questionType;
  int? selectedValue;
  bool isCompulsory = false;
  SingleChoice singleChoice = SingleChoice();
  MultipleChoice multipleChoice = MultipleChoice();
  ShortAnswer shortAnswer = ShortAnswer();
  SurveyQuestionFormField({Key? key, required this.index, this.funValidate})
      : super(key: key);

  @override
  _SurveyQuestionFormFieldState createState() =>
      _SurveyQuestionFormFieldState();
}

class _SurveyQuestionFormFieldState extends State<SurveyQuestionFormField> {
  @override
  void initState() {
    widget.questionController.clear();
    widget.selectedValue = 1;
    widget.questionType = widget.singleChoice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: gap_s),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      width: getMediaQueryWidth(context) * 0.4,
      padding: const EdgeInsets.all(gap_m),
      child: Form(
        child: Column(
          children: [
            _questionAndDropdown(),
            widget.selectedValue == 1
                ? widget.singleChoice
                : widget.selectedValue == 2
                    ? widget.multipleChoice
                    : widget.shortAnswer,
            Row(
              children: [
                Spacer(),
                Text("필수"),
                SizedBox(width: gap_s),
                Switch(
                  value: widget.isCompulsory,
                  onChanged: (value) {
                    setState(() {
                      if (widget.isCompulsory == true)
                        widget.isCompulsory = false;
                      else
                        widget.isCompulsory = true;
                    });
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _questionAndDropdown() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            style: h5(),
            controller: widget.questionController,
            decoration: InputDecoration(
              hintText: "질문",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[200]!),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.lightGreen),
              ),
            ),
            validator: widget.funValidate,
          ),
        ),
        SizedBox(width: gap_m),
        DropdownButton(
          elevation: 0,
          onChanged: (int? value) {
            setState(() {
              widget.selectedValue = value;
              // if (widget.selectedValue == 1)
              //   widget.questionType = QuestionType<SingleChoice>(singleChoice);
              // else if (widget.selectedValue == 2)
              //   widget.questionType = QuestionType<MultipleChoice>(multipleChoice);
              // else
              //   widget.questionType = QuestionType<ShortAnswer>(shortAnswer);
            });
          },
          value: widget.selectedValue,
          items: [
            DropdownMenuItem(
              child: Text("객관식 질문"),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text("다수 선택"),
              value: 2,
            ),
            DropdownMenuItem(
              child: Text("주관식"),
              value: 3,
            ),
          ],
        ),
      ],
    );
  }
}
