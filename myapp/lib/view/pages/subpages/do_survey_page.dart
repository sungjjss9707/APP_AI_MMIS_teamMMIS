import 'package:flutter/material.dart';
import 'package:research_package/model.dart';
import 'package:research_package/research_package.dart';

class DoSurveyPage extends StatelessWidget {
  const DoSurveyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RPOrderedTask exampleTask = RPOrderedTask(
      identifier: "test",
      steps: [
        RPInstructionStep(
          identifier: "instructionID",
          title: "Instructions",
        ),
        RPQuestionStep(
            identifier: "QuestionId",
            answerFormat: RPChoiceAnswerFormat(
              answerStyle: RPChoiceAnswerStyle.SingleChoice,
              choices: [
                RPChoice(text: "1", value: 3),
                RPChoice(text: "1", value: 2)
              ],
            ),
            title: "example"),
        RPCompletionStep(identifier: "completionId", title: "thank you"),
      ],
    );
    return RPUITask(
      task: exampleTask,
      onSubmit: (result) {},
      onCancel: (result) {},
    );
  }
}
