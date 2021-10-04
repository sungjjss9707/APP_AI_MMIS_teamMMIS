import 'package:flutter/material.dart';
import 'package:myapp/domain/survey/survey.dart';
import 'package:survey_kit/survey_kit.dart';

class DoSurveyPage extends StatelessWidget {
  final RealSurvey survey;

  const DoSurveyPage(this.survey);

  @override
  Widget build(BuildContext context) {
    return SurveyKit(
      task: _orderedTask(survey),
      onResult: (SurveyResult result) {},
    );
  }
}

OrderedTask _orderedTask(RealSurvey survey) {
  String id = survey.id;
  String surveyTitle = survey.title;
  String explain = survey.explain;
  List<Map<String, dynamic>> questions = survey.questions;
  return OrderedTask(
    id: TaskIdentifier(id: id),
    steps: List.generate(questions.length, (index) {
      Map<String, dynamic> question = questions.first;
      String questionTitle = question["title"];
      String type = question["type"];
      List<String> optionList = question["option"];
      return QuestionStep(answerFormat: question)
    }),
  );
}
