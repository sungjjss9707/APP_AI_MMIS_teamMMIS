import 'package:flutter/material.dart';
import 'package:myapp/theme.dart';
import 'package:research_package/model.dart';
import 'package:research_package/research_package.dart';

class DoSurveyPage extends StatelessWidget {
  const DoSurveyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RPOrderedTask exampleTask = RPOrderedTask(
      closeAfterFinished: true,
      identifier: "test",
      steps: [
        RPInstructionStep(
          text: "제 3차 브런치 데이 설문조사",
          identifier: "instructionID",
          title: "Instructions",
        ),
        RPQuestionStep(
            identifier: "QuestionId",
            answerFormat: RPChoiceAnswerFormat(
              answerStyle: RPChoiceAnswerStyle.SingleChoice,
              choices: [
                RPChoice(text: "먹음", value: 0),
                RPChoice(text: "안먹음", value: 1),
              ],
            ),
            title: "example"),
        RPCompletionStep(
            identifier: "completionId", title: "감사합니다.", text: "ok"),
      ],
    );
    return Theme(
      data: themeData.copyWith(
        sliderTheme: SliderThemeData.fromPrimaryColors(
          primaryColor: Colors.lightGreen,
          primaryColorDark: Colors.lightGreen,
          primaryColorLight: Colors.lightGreen,
          valueIndicatorTextStyle: TextStyle(),
        ),
        accentColor: Colors.lightGreen,
        accentIconTheme: IconThemeData(color: Colors.lightGreen),
        buttonColor: Colors.lightGreen,
        secondaryHeaderColor: Colors.lightGreen,
      ),
      child: RPUITask(
        task: exampleTask,
        onSubmit: (result) {
          print(result.results.entries.first);
        },
        onCancel: (result) {},
      ),
    );
  }
}
