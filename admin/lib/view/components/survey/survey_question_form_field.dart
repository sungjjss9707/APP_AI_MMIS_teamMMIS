import 'package:admin/style.dart';
import 'package:admin/view/components/survey/multipleChoice.dart';
import 'package:admin/view/components/survey/single_choice.dart';
import 'package:flutter/material.dart';

import '../../../size.dart';

class SurveyQuestionFormField extends StatefulWidget {
  final funValidate;

  SurveyQuestionFormField({this.funValidate});

  @override
  _SurveyQuestionFormFieldState createState() =>
      _SurveyQuestionFormFieldState();
}

class _SurveyQuestionFormFieldState extends State<SurveyQuestionFormField> {
  final _questionController = TextEditingController();
  int? _selectedValue;

  @override
  void initState() {
    _selectedValue = 1;
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
            _selectedValue == 1
                ? SingleChoice()
                : _selectedValue == 2
                    ? MultipleChoice()
                    : Container(),
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
            controller: _questionController,
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
              _selectedValue = value;
            });
          },
          value: _selectedValue,
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
