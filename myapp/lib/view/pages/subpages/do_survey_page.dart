import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/dto/survey_result_request_Dto.dart';
import 'package:myapp/controller/survey_controller.dart';
import 'package:myapp/domain/survey/survey.dart';
import 'package:survey_kit/survey_kit.dart';

import '../../../theme.dart';

class DoSurveyPage extends StatelessWidget {
  final Survey survey;
  final SurveyController _surveyController = SurveyController();
  final GetSurveyController _getSurveyController =
      Get.put(GetSurveyController());
  DoSurveyPage(this.survey);

  @override
  Widget build(BuildContext context) {
    int questionNumber = survey.questions!.length;
    return Scaffold(
      body: Container(
        child: SurveyKit(
          surveyController: _surveyController,
          task: _orderedTask(survey),
          themeData: SurveyTheme(context),
          onResult: (SurveyResult result) async {
            List<SurveyResultDto> answers = [];
            if (result.finishReason == FinishReason.COMPLETED) {
              for (int i = 1; i <= questionNumber; i++) {
                Map<String, dynamic> question = survey.questions![i - 1];
                String type = question["type"];
                List<String> answerList;
                if (type == "객관식") {
                  String answer =
                      result.results[i].results[0].valueIdentifier ?? "";
                  answerList = [answer];
                } else if (type == "다수선택") {
                  String answer =
                      result.results[i].results[0].valueIdentifier ?? "";
                  answerList = answer.split(",");
                } else {
                  String answer =
                      result.results[i].results[0].valueIdentifier ?? "";
                  answerList = [answer];
                }
                answers.add(SurveyResultDto(i, type, answerList));
              }
              int code = await _getSurveyController.reportAnswer(answers);
              if (code == 1) {
                Get.snackbar(
                  "설문조사",
                  "제출 성공",
                );
              } else
                Get.snackbar(
                  "설문조사",
                  "제출 실패",
                );
            }

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
            stepIdentifier: StepIdentifier(id: index.toString()),
            title: surveyTitle,
            text: explain,
          );
        }
        if (index == questions.length + 1) {
          return CompletionStep(
            stepIdentifier: StepIdentifier(id: index.toString()),
            title: "",
            text: "",
          );
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
