import 'package:admin/view/components/survey/survey_question_form_field.dart';

class Survey {
  final String? id;
  final String? title;
  final String? explain;
  final List<SurveyQuestionFormField>? questions;
  final List<Result>? result;

  Survey({this.id, this.title, this.explain, this.questions, this.result});
  Survey.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        explain = json["explain"],
        questions = json["questions"],
        result = convertToResult(json["result"]);
}

List<Result> convertToResult(dynamic rawResult) {
  List<Result> returnValue = [];
  for (List<Map<String, dynamic>> i in rawResult) {
    List<QuestionResult> result = [];
    for (Map<String, dynamic> j in i) {
      result.add(QuestionResult(j["id"], j["type"], j["answer"]));
    }
    returnValue.add(Result(result));
  }
  return returnValue;
}

class Result {
  final List<QuestionResult> result;

  Result(this.result);
}

class QuestionResult {
  final String id;
  final String type;
  final List<String> answer;

  QuestionResult(this.id, this.type, this.answer);
}
