import 'dart:convert';

import 'package:admin/view/components/survey/survey_question_form_field.dart';
import 'package:flutter/material.dart';

class SurveyPostDto {
  final String title;
  final String explain;
  final String seq;
  final List<SurveyQuestionFormField> question;

  SurveyPostDto(this.title, this.explain, this.seq, this.question);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {
      "title": title,
      "explain": explain,
      "seq": seq,
    };
    List<Map> questionsList = [];
    for (SurveyQuestionFormField i in question) {
      Map<String, dynamic> question = {};
      question["id"] = i.index;
      question["text"] = i.questionController.text;
      question["type"] = showQuestionType(i);
      question["isOptional"] = i.isOptional == true ? "no" : "yes";
      question["options"] = getOption(i);
      questionsList.add(question);
    }
    result["question"] = jsonEncode(questionsList);
    print(result["question"].runtimeType);
    return result;
  }

  String showQuestionType(SurveyQuestionFormField i) {
    if (i.selectedValue == 1)
      return "객관식";
    else if (i.selectedValue == 2)
      return "다수선택";
    else
      return "단답식";
  }

  List<String> getOption(SurveyQuestionFormField i) {
    List<String> options = [];
    if (i.selectedValue == 1) {
      for (TextEditingController j in i.singleChoice.textEditingControllers) {
        options.add(j.text);
      }
    } else if (i.selectedValue == 2) {
      for (TextEditingController j in i.multipleChoice.textEditingControllers) {
        options.add(j.text);
      }
    }
    return options;
  }
}
