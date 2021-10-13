import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/domain/survey/survey.dart';
import 'package:survey_kit/survey_kit.dart';

import '../../../theme.dart';

class DoSurveyPage extends StatelessWidget {
  final Survey survey;
  final SurveyController _surveyController = SurveyController();
  DoSurveyPage(this.survey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SurveyKit(
          surveyController: _surveyController,
          task: _orderedTask(survey),
          themeData: SurveyTheme(context),
          onResult: (SurveyResult result) {
            print("1${result.results[1].results[0].valueIdentifier}");
            print("2${result.results[2].results[0].valueIdentifier}");
            print("3${result.results[3].results[0].valueIdentifier}");
            print("4${result.results[4].results[0].valueIdentifier}");
            Get.back();
          },
        ),
      ),
    );
  }

  NavigableTask _orderedTask(Survey survey) {
    String id = survey.id!;
    String surveyTitle = survey.title!;
    String explain = survey.explain!;
    List<Map<String, dynamic>> questions = survey.questions!;
    return NavigableTask(
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
        Map<String, dynamic> question = questions[index - 1];
        String questionTitle = question["text"];
        String type = question["type"];
        bool isOptional = question["isOptional"] == "yes" ? true : false;
        List<dynamic> optionList_dynamic = question["options"];
        List<String> optionList =
            optionList_dynamic.map((e) => e.toString()).toList();
        return QuestionStep(
          stepIdentifier: StepIdentifier(id: index.toString()),
          title: questionTitle,
          isOptional: isOptional,
          text: type == "다수선택" ? "한 개 이상 골라주세요." : "",
          answerFormat: type == "객관식"
              ? SingleChoiceAnswerFormat(
                  textChoices: convertToTextChoice(optionList))
              : type == "다수선택"
                  ? MultipleChoiceAnswerFormat(
                      textChoices: convertToTextChoice(optionList))
                  : TextAnswerFormat(
                      validationRegEx: "^(?!\s*\$).+",
                    ),
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
