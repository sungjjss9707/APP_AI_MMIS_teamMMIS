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

  OrderedTask _orderedTask(RealSurvey survey) {
    String id = survey.id;
    String surveyTitle = survey.title;
    String explain = survey.explain;
    List<Map<String, dynamic>> questions = survey.questions;
    return OrderedTask(
      id: TaskIdentifier(id: id),
      steps: List.generate(questions.length + 2, (index) {
        if (index == 0) {
          return InstructionStep(
            title: surveyTitle,
            text: explain,
          );
        }
        if (index == questions.length + 1) {
          return CompletionStep(
              stepIdentifier: StepIdentifier(), title: "", text: "");
        }
        Map<String, dynamic> question = questions[index - 2];
        String questionTitle = question["text"];
        String type = question["type"];
        bool isOptional = question["isOptional"] == "yes" ? true : false;
        List<String> optionList = question["option"];
        return QuestionStep(
          title: questionTitle,
          isOptional: isOptional,
          answerFormat: type == "객관식"
              ? SingleChoiceAnswerFormat(
                  textChoices: convertToTextChoice(optionList))
              : type == "다수선택"
                  ? MultipleChoiceAnswerFormat(
                      textChoices: convertToTextChoice(optionList))
                  : TextAnswerFormat(),
        );
      }),
    );
  }

  List<TextChoice> convertToTextChoice(List<String> optionList) {
    List<TextChoice> result = [];
    int length = optionList.length;
    for (int index = 0; index < length; index++) {
      result.add(TextChoice(text: optionList[index], value: index.toString()));
    }
    return result;
  }
}
